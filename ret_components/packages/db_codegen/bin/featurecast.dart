// featurecast_v2.dart
// Incremental feature scaffolder with transactional writes & prompts.
// Multi-API safe (idempotent imports, correct method insertion).
//
// USAGE:
// dart run db_codegen:featurecast \
//   --feature example \
//   --api fetchMenus \
//   --root Menus \
//   --input ../json/menus_payload.json \
//   --force
//   --replace
//
// Then append more APIs with the same --feature.
//
// ---------------------------------------------------------------------

import 'dart:convert';
import 'dart:io';
import 'package:recase/recase.dart';

// ===================== CLI ENTRY =====================

void main(List<String> args) async {
  final feature = _arg(args, '--feature')?.trim();
  final apiName = _arg(args, '--api')?.trim();
  final root = _arg(args, '--root')?.trim();
  final inputs = _argsAll(args, '--input');
  final inputDir = _arg(args, '--input-dir');
  final force = args.contains('--force');
  final replace = args.contains('--replace');

  if (feature == null || apiName == null || root == null ||
      ((inputs == null || inputs.isEmpty) && inputDir == null)) {
    _help();
    exit(64);
  }

  _ensureInputExists(inputs, inputDir);

  final featureDir = Directory('lib/features/${feature!.snakeCase}');
  if (featureDir.existsSync() && !(force || replace)) {
    final ok = _confirm('Feature folder exists: ${featureDir.path}. Continue?');
    if (!ok) {
      stdout.writeln('🚫 Cancelled by user.');
      return;
    }
  }

  // ---------- Parse/ingest all samples ----------
  final reqSamples = <Map<String, dynamic>>[];
  final respDataSamples = <dynamic>[];
  final headerSamples = <Map<String, dynamic>>[];
  final urlSet = <String>{};

  Future<void> ingest(dynamic parsed, {String? origin}) async {
    if (parsed is! Map<String, dynamic>) {
      _die('Top-level JSON must be an object: ${origin ?? ""}', 65);
    }

    // Required: url, headers
    if (!parsed.containsKey('url')) {
      _die('Input JSON missing required key "url"${origin != null ? ' in $origin' : ''}.', 65);
    }
    if (!parsed.containsKey('headers')) {
      _die('Input JSON missing required key "headers"${origin != null ? ' in $origin' : ''}.', 65);
    }
    final url = parsed['url'];
    final headers = parsed['headers'];
    if (url is! String) _die('"url" must be a string${origin != null ? ' in $origin' : ''}.', 65);
    if (headers is! Map<String, dynamic>) _die('"headers" must be an object${origin != null ? ' in $origin' : ''}.', 65);
    urlSet.add(url);
    headerSamples.add(headers);

    // Optional request ({} tolerated)
    if (parsed.containsKey('request')) {
      final req = parsed['request'];
      if (req == null) {
        // treat as {}
      } else if (req is! Map<String, dynamic>) {
        _die('"request" must be an object ({} allowed)${origin != null ? ' in $origin' : ''}.', 65);
      } else {
        reqSamples.add(req);
      }
    }

    // Optional response; if present must have data
    if (parsed.containsKey('response')) {
      final resp = parsed['response'];
      if (resp is! Map<String, dynamic>) {
        _die('"response" must be an object${origin != null ? ' in $origin' : ''}.', 65);
      }
      if (!resp.containsKey('data')) {
        _die('"response.data" missing${origin != null ? ' in $origin' : ''}.', 65);
      }
      respDataSamples.add(resp['data']);
    }
  }

  if (inputs != null) {
    for (final p in inputs) {
      final raw = _readStrict(p);
      await ingest(_json(raw, p), origin: p);
    }
  }
  if (inputDir != null) {
    final dir = Directory(inputDir);
    for (final f in dir.listSync().whereType<File>()) {
      if (!f.path.toLowerCase().endsWith('.json')) continue;
      final raw = _readStrict(f.path);
      await ingest(_json(raw, f.path), origin: f.path);
    }
  }

  final hasRequest = reqSamples.isNotEmpty;
  final hasResponse = respDataSamples.isNotEmpty;

  if (!hasRequest) stdout.writeln('⚠️  No "request" found — skipping request model generation.');
  if (!hasResponse) stdout.writeln('⚠️  No "response.data" found — treating as void success.');

  final respKind = hasResponse ? _detectRespKind(respDataSamples) : _RespKind.voidSuccess;
  final firstHeaders = headerSamples.isNotEmpty ? headerSamples.first : <String, dynamic>{};
  final firstUrl = urlSet.isNotEmpty ? urlSet.first : '';

  // ---------- Inference ----------
  final responseRootDto = '${root!.pascalCase}Dto';
  final requestRootDto = '${apiName!.pascalCase}Request';
  final responseClasses = <String, _Class>{};
  final requestClasses = <String, _Class>{};

  if (hasResponse) {
    final objects = <Map<String, dynamic>>[];
    if (respKind == _RespKind.object) {
      for (final d in respDataSamples) {
        if (d is Map<String, dynamic>) objects.add(d);
      }
    } else if (respKind == _RespKind.list) {
      for (final d in respDataSamples) {
        if (d is List) {
          for (final e in d) {
            if (e is Map<String, dynamic>) objects.add(e);
          }
        }
      }
    }
    if (objects.isNotEmpty) {
      final merged = _inferMergedRoot(responseRootDto, objects);
      _collectClasses(merged, responseClasses);
    }
  }

  if (hasRequest) {
    final mergedReq = _inferMergedRootForRequest(requestRootDto, reqSamples);
    _collectClasses(mergedReq, requestClasses);
  }

  // ---------- Paths ----------
  final base = 'lib/features/${feature.snakeCase}';
  final dataModelsDir = '$base/data/models';
  final datasourcePath = '$base/data/datasource/${feature.snakeCase}_datasource.dart';
  final domainRepoPath = '$base/domain/repositories/${feature.snakeCase}_repository.dart';
  final repoImplPath = '$base/data/repositories/impl/${feature.snakeCase}_repository_impl.dart';
  final providersPath = '$base/presentation/${feature.snakeCase}_providers.dart';
  final urlFile = 'lib/network/data/urls/${feature.snakeCase}_url.dart';
  final statePath = '$base/presentation/state/${apiName.snakeCase}_state.dart';
  final notifierPath = '$base/presentation/controller/${apiName.snakeCase}_notifier.dart';

  for (final d in [
    '$base/data/models',
    '$base/data/datasource',
    '$base/data/repositories/impl',
    '$base/domain/entities',
    '$base/domain/repositories',
    '$base/presentation',
    '$base/presentation/state',
    '$base/presentation/controller',
    'lib/network/data/urls',
  ]) Directory(d).createSync(recursive: true);

  final txn = _GenTxn();

  try {
    // ---------- Emit response DTOs + Entities ----------
    if (hasResponse && responseClasses.isNotEmpty) {
      for (final c in responseClasses.values) {
        _write('$dataModelsDir/${c.name.snakeCase}.dart',
            _emitDtoWithEntityExt(c, responseClasses), replace, txn,
            why: 'response DTO');
        _write('$base/domain/entities/${c.entityName.snakeCase}.dart',
            _emitEntity(c), replace, txn,
            why: 'entity');
      }
    }

    // ---------- Emit request DTOs ----------
    if (hasRequest && requestClasses.isNotEmpty) {
      for (final c in requestClasses.values) {
        final isRoot = c.name == requestRootDto;
        _write('$dataModelsDir/${c.name.snakeCase}.dart',
            _emitRequestDto(c, isRoot: isRoot), replace, txn,
            why: isRoot ? 'request root' : 'request nested');
      }
    }

    // ---------- URL ----------
    _appendUrl(urlFile, feature, apiName, firstUrl, firstHeaders, txn, force || replace);

    // ---------- Domain Repo (Either) ----------
    _appendDomainRepo(domainRepoPath, feature, apiName, root, respKind, hasRequest, txn, force || replace);

    // ---------- Datasource (idempotent imports, proper insertion) ----------
    _appendDatasource(datasourcePath, feature, apiName, root, responseRootDto,
        hasRequest ? requestRootDto : null, firstHeaders, respKind, txn, force || replace);

    // ---------- Repo Impl (Either + ApiErrorX.fromEnvelope) ----------
    _appendRepoImpl(repoImplPath, feature, apiName, root, responseRootDto,
        respKind, hasRequest, txn, force || replace);

    // ---------- Providers (create once) ----------
    if (!File(providersPath).existsSync()) {
      _write(providersPath, _emitProviders(feature), replace, txn, why: 'providers');
    }

    // ---------- State + Notifier (per API) ----------
    _write(statePath, _emitState4(apiName, root, respKind), replace, txn, why: 'state');
    _write(notifierPath, _emitNotifier(apiName, feature, root, respKind, hasRequest), replace, txn, why: 'notifier');

    txn.commit();
    stdout
      ..writeln('\n✅ Generated API "$apiName" under feature "${feature.snakeCase}".')
      ..writeln('   Response kind: ${respKind.name}')
      ..writeln('   Next: dart run build_runner build -d');
  } on _Cancelled catch (e) {
    stdout.writeln('🛑 $e');
    txn.rollback();
  } catch (e, st) {
    stderr.writeln('❌ Error: $e');
    stderr.writeln(st);
    txn.rollback();
    exit(1);
  }
}

// ===================== PROMPTS & TXN HELPERS =====================

bool _confirm(String question, {String defaultNoHint = 'y/N'}) {
  stdout.write('$question ($defaultNoHint): ');
  final resp = stdin.readLineSync()?.trim().toLowerCase();
  return resp == 'y' || resp == 'yes';
}

class _Cancelled implements Exception {
  final String reason;
  _Cancelled(this.reason);
  @override
  String toString() => reason;
}

class _GenTxn {
  final createdFiles = <String>{};
  final backups = <String, String>{};

  void recordCreate(String path) {
    if (!File(path).existsSync()) createdFiles.add(path);
  }

  void backupIfNeeded(String path) {
    final f = File(path);
    if (f.existsSync() && !backups.containsKey(path)) {
      backups[path] = f.readAsStringSync();
    }
  }

  void rollback() {
    backups.forEach((path, content) {
      File(path).writeAsStringSync(content);
    });
    for (final p in createdFiles) {
      final f = File(p);
      if (f.existsSync()) {
        try { f.deleteSync(); } catch (_) {}
      }
    }
    stdout.writeln('↩️  Rolled back changes.');
  }

  void commit() {
    backups.clear();
    createdFiles.clear();
  }
}

void _ensureInputExists(List<String>? inputs, String? inputDir) {
  if (inputs != null) {
    for (final p in inputs) {
      if (!File(p).existsSync()) _die('File not found: $p', 66);
    }
  }
  if (inputDir != null) {
    final dir = Directory(inputDir);
    if (!dir.existsSync()) _die('Directory not found: $inputDir', 66);
    final anyJson = dir
        .listSync()
        .whereType<File>()
        .any((f) => f.path.toLowerCase().endsWith('.json'));
    if (!anyJson) _die('No .json files in $inputDir', 66);
  }
}

// ===================== WRITE/APPEND HELPERS =====================

void _write(String path, String content, bool force, _GenTxn txn, {String? why}) {
  final f = File(path);
  txn.recordCreate(path);
  if (f.existsSync() && !force) {
    final ok = _confirm('File exists: $path. Overwrite?${why != null ? ' [$why]' : ''}');
    if (!ok) throw _Cancelled('User cancelled overwrite of $path');
    txn.backupIfNeeded(path);
  }
  if (!f.existsSync()) {
    f.createSync(recursive: true);
  } else {
    txn.backupIfNeeded(path);
  }
  f.writeAsStringSync(content);
  stdout.writeln('✍️  Wrote: $path');
}

String _ensureImport(String src, String importLine) {
  if (importLine.trim().isEmpty) return src;
  if (RegExp(r'^' + RegExp.escape(importLine) + r'\s*$', multiLine: true).hasMatch(src)) {
    return src; // already present
  }

  // ✅ import block matcher
  final importBlock = RegExp(
    r'''(^import\s+["'][^"']+["'];[^\n]*\n)+''',
    multiLine: true,
  );
  final match = importBlock.firstMatch(src);
  if (match != null) {
    final end = match.end;
    return src.replaceRange(end, end, importLine + '\n');
  }
  return importLine + '\n' + src;
}

int _findClassCloseIndex(String src, String className) {
  // naive but robust enough: find 'class <name>' then last '}' after it.
  final start = src.indexOf('class $className');
  if (start < 0) return -1;
  // walk braces to find matching close
  int i = src.indexOf('{', start);
  if (i < 0) return -1;
  int depth = 1;
  for (i = i + 1; i < src.length; i++) {
    final ch = src[i];
    if (ch == '{') depth++;
    else if (ch == '}') {
      depth--;
      if (depth == 0) return i; // the '}' index
    }
  }
  return -1;
}

// ===================== URL =====================

void _appendUrl(
    String urlFile,
    String feature,
    String apiName,
    String url,
    Map<String, dynamic> headers,
    _GenTxn txn,
    bool force,
    ) {
  final cls = '${feature.pascalCase}Url';
  final urlConst = apiName.camelCase;

  final f = File(urlFile);
  final urlLine = '  static const String $urlConst = "${url.replaceAll('"', '\\"')}";';

  if (!f.existsSync()) {
    final content = 'class $cls {\n$urlLine\n}\n';
    _write(urlFile, content, force, txn, why: 'create urls class');
    return;
  }

  var src = f.readAsStringSync();

  if (!src.contains('class $cls')) {
    if (!force && !_confirm('URL file exists but no $cls class. Replace file: $urlFile?')) {
      throw _Cancelled('User cancelled url file replace');
    }
    txn.backupIfNeeded(urlFile);
    f.writeAsStringSync('class $cls {\n$urlLine\n}\n');
    stdout.writeln('✍️  Rewrote: $urlFile');
    return;
  }

  if (src.contains('static const String $urlConst')) {
    src = src.replaceFirst(
      RegExp(r'static const String ' + urlConst + r'\s*=\s*".*?";'),
      urlLine,
    );
  } else {
    src = src.replaceFirst(RegExp(r'\}\s*$'), '$urlLine\n}\n');
  }

  txn.backupIfNeeded(urlFile);
  f.writeAsStringSync(src);
  stdout.writeln('✍️  Upserted URL in: $urlFile');
}

// ===================== DOMAIN REPO (Either) =====================

void _appendDomainRepo(
    String path,
    String feature,
    String apiName,
    String root,
    _RespKind kind,
    bool hasRequest,
    _GenTxn txn,
    bool force,
    ) {
  final repoName = '${feature.pascalCase}Repository';
  final method = apiName.camelCase;
  final ent = root.pascalCase;

  final retType = switch (kind) {
    _RespKind.voidSuccess => 'Either<ApiError, Unit>',
    _RespKind.object      => 'Either<ApiError, $ent>',
    _RespKind.list        => 'Either<ApiError, List<$ent>>',
  };

  final requestType = '${apiName.pascalCase}Request';
  final signature = hasRequest
      ? '  Future<$retType> $method({ required $requestType request, });\n'
      : '  Future<$retType> $method();\n';

  final requestImport = hasRequest
      ? "import '../../data/models/${apiName.snakeCase}_request.dart';"
      : '';

  final f = File(path);
  if (!f.existsSync()) {
    final content = '''
import 'package:dartz/dartz.dart';
import '../../../../network/domain/models/api_error.dart';
${kind == _RespKind.voidSuccess ? '' : "import '../entities/${ent.snakeCase}.dart';"}
$requestImport

abstract class $repoName {
$signature}
''';
    _write(path, content, force, txn, why: 'create repo interface');
    return;
  }

  var src = f.readAsStringSync();

  // Ensure required imports
  if (!src.contains("package:dartz/dartz.dart")) {
    src = "import 'package:dartz/dartz.dart';\n" + src;
  }
  if (!src.contains("network/domain/models/api_error.dart")) {
    src = src.replaceAll("network/domain/models/api_envelope.dart", "network/domain/models/api_error.dart");
    if (!src.contains("network/domain/models/api_error.dart")) {
      src = src.replaceFirst("abstract class $repoName {", "import '../../../../network/domain/models/api_error.dart';\n\nabstract class $repoName {");
    }
  }
  if (kind != _RespKind.voidSuccess) {
    final entImport = "import '../entities/${ent.snakeCase}.dart';";
    src = _ensureImport(src, entImport);
  }
  if (hasRequest) {
    src = _ensureImport(src, requestImport);
  }

  // Upsert signature
  final methodRegex = RegExp(r'Future<[^>]+>\s+' + method + r'\s*\([^\)]*\)\s*;');
  if (methodRegex.hasMatch(src)) {
    if (!force && !_confirm('Repo method $method exists. Override signature?')) return;
    src = src.replaceFirst(methodRegex, signature.trim());
  } else {
    src = src.replaceFirst(RegExp(r'\}\s*$'), '$signature}\n');
  }

  txn.backupIfNeeded(path);
  File(path).writeAsStringSync(src);
  stdout.writeln('✍️  Updated repo interface: $method');
}

// ===================== DATASOURCE =====================

void _appendDatasource(
    String path,
    String feature,
    String apiName,
    String root,
    String respDto,
    String? requestRoot,
    Map<String, dynamic> headers,
    _RespKind kind,
    _GenTxn txn,
    bool force,
    ) {
  final cls = '${feature.pascalCase}Datasource';
  final method = apiName.camelCase;
  final urlCls = '${feature.pascalCase}Url';
  final urlConst = apiName.camelCase;

  final screenId = (headers['screenId'] ?? 'COMMON').toString();
  final serviceId = (headers['serviceId'] ?? '').toString();
  final subModuleId = (headers['subModuleId'] ?? '').toString();
  final moduleId = (headers['moduleId'] ?? '').toString();

  final returnDto = switch (kind) {
    _RespKind.voidSuccess => 'void',
    _RespKind.object      => respDto,
    _RespKind.list        => 'List<$respDto>',
  };

  final mapper = switch (kind) {
    _RespKind.voidSuccess => 'ApiMapper.mapStatusVoid(json)',
    _RespKind.object      => 'ApiMapper.mapData<$respDto>(json, (d) => $respDto.fromJson(d))',
    _RespKind.list        => 'ApiMapper.mapList<$respDto>(json, (d) => $respDto.fromJson(d))',
  };

  final hasRequest = requestRoot != null;

  final methodSig = hasRequest
      ? '''
  Future<ApiEnvelope<$returnDto>> $method({
    required ${requestRoot!} request,
  }) async {'''
      : '''
  Future<ApiEnvelope<$returnDto>> $method() async {''';

  final bodyBlock = hasRequest
      ? '''
    // Inject DeviceModel (ignored in JSON) — and guard against null
    final appVer = await getAppVersion();
    final deviceModel = await DeviceInfo(appVer: appVer, endToEndId: '').deviceType();
    if (deviceModel == null) {
      return ApiEnvelope.error(
        const ApiError(description: 'Unable to fetch device info'),
        AppStatus.error,
      );
    }
    final withDevice = request.copyWith(deviceInfo: deviceModel);

    return executeApiCall<$returnDto>(
      call: () => dio.post($urlCls.$urlConst, data: withDevice.toJson()),
      mapJson: (json) => $mapper,
    );'''
      : '''
    return executeApiCall<$returnDto>(
      call: () => dio.post($urlCls.$urlConst, data: const <String, dynamic>{}),
      mapJson: (json) => $mapper,
    );''';

  final methodCode = '''
  $methodSig
    final dio = client.customDio(
      authorizationRequired: true,
      screenId: '$screenId',
      serviceId: '$serviceId',
      subModuleId: '$subModuleId',
      moduleId: '$moduleId',
    );

$bodyBlock
  }
''';

  // Build/update file
  final f = File(path);
  if (!f.existsSync()) {
    final header = '''
import 'package:db_uicomponents/db_uicomponents.dart';
import '../../../../core/utils/utils.dart';
import '../../../../network/data/api_mapper.dart';
import '../../../../network/data/execute_api_call.dart';
import '../../../../network/data/model/app_status.dart';
import '../../../../network/data/network_client.dart';
import '../../../../network/domain/models/api_envelope.dart';
import '../../../../network/domain/models/api_error.dart';
${hasRequest ? "import '../models/${requestRoot!.snakeCase}.dart';" : ''}
${kind == _RespKind.voidSuccess ? '' : "import '../models/${respDto.snakeCase}.dart';"}
import '../../../../network/data/urls/${feature.snakeCase}_url.dart';

class $cls {
  final NetworkClient client;
  $cls(this.client);
$methodCode
}
''';
    _write(path, header, force, txn, why: 'create datasource');
    return;
  }

  // Update existing: upsert imports + method, avoid brace duplication
  var src = f.readAsStringSync();

  // Ensure imports
  src = _ensureImport(src, "import 'package:db_uicomponents/db_uicomponents.dart';");
  src = _ensureImport(src, "import '../../../../core/utils/utils.dart';");
  src = _ensureImport(src, "import '../../../../network/data/api_mapper.dart';");
  src = _ensureImport(src, "import '../../../../network/data/execute_api_call.dart';");
  src = _ensureImport(src, "import '../../../../network/data/model/app_status.dart';");
  src = _ensureImport(src, "import '../../../../network/data/network_client.dart';");
  src = _ensureImport(src, "import '../../../../network/domain/models/api_envelope.dart';");
  src = _ensureImport(src, "import '../../../../network/domain/models/api_error.dart';");
  src = _ensureImport(src, "import '../../../../network/data/urls/${feature.snakeCase}_url.dart';");
  if (hasRequest) {
    src = _ensureImport(src, "import '../models/${requestRoot!.snakeCase}.dart';");
  }
  if (kind != _RespKind.voidSuccess) {
    src = _ensureImport(src, "import '../models/${respDto.snakeCase}.dart';");
  }

  // Ensure class exists
  if (!src.contains('class $cls')) {
    // create minimal class wrapper and append
    src += "\nclass $cls {\n  final NetworkClient client;\n  $cls(this.client);\n}\n";
  }

  // Insert/replace method inside class body (before its closing brace)
  final closeIdx = _findClassCloseIndex(src, cls);
  if (closeIdx < 0) {
    // fallback: append safely
    src += '\n' + methodCode;
  } else {
    // remove existing method with same signature if present
    final methodRe = RegExp(r'Future<ApiEnvelope<[^>]+>>\s+' + method + r'\s*\([^\)]*\)\s*async\s*\{[\s\S]*?\n\}');
    if (methodRe.hasMatch(src)) {
      src = src.replaceFirst(methodRe, methodCode.trim());
    } else {
      src = src.replaceRange(closeIdx, closeIdx, '\n$methodCode');
    }
  }

  txn.backupIfNeeded(path);
  File(path).writeAsStringSync(src);
  stdout.writeln('✍️  Upserted datasource method: $method');
}

// ===================== REPO IMPL (Either + ApiErrorX) =====================

void _appendRepoImpl(
    String path,
    String feature,
    String apiName,
    String root,
    String respDto,
    _RespKind kind,
    bool hasRequest,
    _GenTxn txn,
    bool force,
    ) {
  final repoName = '${feature.pascalCase}Repository';
  final dsCls = '${feature.pascalCase}Datasource';
  final method = apiName.camelCase;
  final ent = root.pascalCase;

  final retType = switch (kind) {
    _RespKind.voidSuccess => 'Either<ApiError, Unit>',
    _RespKind.object      => 'Either<ApiError, $ent>',
    _RespKind.list        => 'Either<ApiError, List<$ent>>',
  };

  final reqType = '${apiName.pascalCase}Request';
  final requestParamSig = hasRequest ? '{ required $reqType request, }' : '()';
  final requestCallArg  = hasRequest ? 'request: request' : '';

  // Use ApiErrorX.fromEnvelope(env); and for object-kind map null->left(...)
  final body = switch (kind) {
    _RespKind.voidSuccess => '''
    final env = await datasource.$method($requestCallArg);
    if (!env.ok) return left(ApiErrorX.fromEnvelope(env));
    return right(unit);
''',
    _RespKind.object => '''
    final env = await datasource.$method($requestCallArg);
    if (!env.ok) return left(ApiErrorX.fromEnvelope(env));
    final mapped = env.data?.toEntity();
    if (mapped == null) return left(ApiErrorX.fromEnvelope(env));
    return right(mapped);
''',
    _RespKind.list => '''
    final env = await datasource.$method($requestCallArg);
    if (!env.ok) return left(ApiErrorX.fromEnvelope(env));
    final mapped = env.data?.map((e)=>e.toEntity()).toList() ?? const <${ent}>[];
    return right(mapped);
''',
  };

  final requestImport = hasRequest
      ? "import '../../models/${apiName.snakeCase}_request.dart';"
      : '';

  final headerImports = '''
import 'package:dartz/dartz.dart';
import '../../datasource/${feature.snakeCase}_datasource.dart';
${kind == _RespKind.voidSuccess ? '' : "import '../../models/${respDto.snakeCase}.dart';"}
import '../../../domain/repositories/${feature.snakeCase}_repository.dart';
${kind == _RespKind.voidSuccess ? '' : "import '../../../domain/entities/${ent.snakeCase}.dart';"}
import '../../../../../network/domain/models/api_error.dart' show ApiError, ApiErrorX;
$requestImport
''';

  final methodBlock = '''
  @override
  Future<$retType> $method($requestParamSig) async {
$body
  }
''';

  final f = File(path);
  if (!f.existsSync()) {
    final content = '''
$headerImports
class ${feature.pascalCase}RepositoryImpl implements $repoName {
  final $dsCls datasource;
  ${feature.pascalCase}RepositoryImpl(this.datasource);
$methodBlock
}
''';
    _write(path, content, force, txn, why: 'create repo impl');
    return;
  }

  var src = f.readAsStringSync();

  // Ensure imports (idempotent)
  src = _ensureImport(src, "import 'package:dartz/dartz.dart';");
  src = _ensureImport(src, "import '../../datasource/${feature.snakeCase}_datasource.dart';");
  src = _ensureImport(src, "import '../../../domain/repositories/${feature.snakeCase}_repository.dart';");
  src = _ensureImport(src, "import '../../../../../network/domain/models/api_error.dart' show ApiError, ApiErrorX;");
  if (hasRequest) src = _ensureImport(src, requestImport);
  if (kind != _RespKind.voidSuccess) {
    src = _ensureImport(src, "import '../../models/${respDto.snakeCase}.dart';");
    src = _ensureImport(src, "import '../../../domain/entities/${ent.snakeCase}.dart';");
  }

  // Ensure class exists
  if (!src.contains('class ${feature.pascalCase}RepositoryImpl')) {
    src += "\nclass ${feature.pascalCase}RepositoryImpl implements $repoName {\n  final $dsCls datasource;\n  ${feature.pascalCase}RepositoryImpl(this.datasource);\n}\n";
  }

  // Upsert method
  final methodRe = RegExp(r'@override\s*Future<[^>]+>\s+' + method + r'\s*\([^\)]*\)\s*async\s*\{[\s\S]*?\n\}');
  if (methodRe.hasMatch(src)) {
    if (!force && !_confirm('Repo impl method $method exists. Override?')) return;
    src = src.replaceFirst(methodRe, methodBlock.trim());
  } else {
    // insert before class closing brace
    final closeIdx = _findClassCloseIndex(src, '${feature.pascalCase}RepositoryImpl');
    if (closeIdx < 0) {
      src += '\n$methodBlock';
    } else {
      src = src.replaceRange(closeIdx, closeIdx, '\n$methodBlock');
    }
  }

  txn.backupIfNeeded(path);
  File(path).writeAsStringSync(src);
  stdout.writeln('✍️  Upserted repo impl method: $method');
}

// ===================== FILE EMITTERS =====================

String _emitProviders(String feature) => '''
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../network/network_client_provider.dart';
import '../data/datasource/${feature.snakeCase}_datasource.dart';
import '../data/repositories/impl/${feature.snakeCase}_repository_impl.dart';
import '../domain/repositories/${feature.snakeCase}_repository.dart';

final ${feature.camelCase}DatasourceProvider = Provider<${feature.pascalCase}Datasource>((ref) {
  final client = ref.watch(networkClientProvider);
  return ${feature.pascalCase}Datasource(client);
});

final ${feature.camelCase}RepoProvider = Provider<${feature.pascalCase}Repository>((ref) {
  final ds = ref.watch(${feature.camelCase}DatasourceProvider);
  return ${feature.pascalCase}RepositoryImpl(ds);
});
''';

// ===== Request DTO emitter =====
String _emitRequestDto(_Class c, {required bool isRoot}) {
  final cls = c.name;

  final fields = c.fields.entries.map((e) {
    if (e.key.toLowerCase() == 'deviceinfo') return null; // inject on root only
    return '    ${_maybeQ(_dartTypeForDtoField(e.key, e.value.dartRef))} ${e.key},';
  }).whereType<String>().join('\n');

  final deviceField = isRoot
      ? "\n    @JsonKey(ignore: true) DeviceModel? deviceInfo,"
      : "";

  final imports = [
    "import 'package:freezed_annotation/freezed_annotation.dart';",
    if (isRoot) "import 'package:db_uicomponents/src/utils/device_info/src/device_model.dart';",
  ].join('\n');

  final refs = _refsDto(c).map((cn) => "import './${cn.snakeCase}.dart';").join('\n');

  return '''
$imports
$refs

part '${cls.snakeCase}.freezed.dart';
part '${cls.snakeCase}.g.dart';

@freezed
class $cls with _\$${cls} {
  const factory $cls({
$fields$deviceField
  }) = _${cls};

  factory $cls.fromJson(Map<String, dynamic> json) => _\$${cls}FromJson(json);
}
''';
}

// ===== Response DTO with toEntity extension + matching entity =====
String _emitDtoWithEntityExt(_Class c, Map<String, _Class> all) {
  final cls = c.name;
  final ent = c.entityName;

  final dtoImports = _refsDto(c).map((cn) => "import './${cn.snakeCase}.dart';").join('\n');

  final fields = c.fields.entries
      .map((e) => '    ${_maybeQ(_dartTypeForDtoField(e.key, e.value.dartRef))} ${e.key},')
      .join('\n');

  final args = c.fields.entries.map((e) {
    final t = e.value;
    final entType = _entityType(t);
    final isNullable = entType.endsWith('?');
    return '      ${e.key}: ${_mapDtoToEntity(e.key, t, entType, isNullable)},';
  }).join('\n');

  return '''
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/${ent.snakeCase}.dart';
$dtoImports

part '${cls.snakeCase}.freezed.dart';
part '${cls.snakeCase}.g.dart';

@freezed
class $cls with _\$${cls} {
  const factory $cls({
$fields
  }) = _${cls};

  factory $cls.fromJson(Map<String, dynamic> json) => _\$${cls}FromJson(json);
}

extension ${cls}X on $cls {
  $ent toEntity() => $ent(
$args
  );
}
''';
}

String _emitEntity(_Class c) {
  final name = c.entityName;
  final imports = _refsEntity(c).map((en) => "import './${en.snakeCase}.dart';").join('\n');
  final fieldLines = <String>[];

  for (final e in c.fields.entries) {
    final et = _entityType(e.value);
    final req = et.endsWith('?') ? '' : 'required ';
    fieldLines.add('    $req$et ${e.key},');
  }
  final fields = fieldLines.join('\n');

  return '''
import 'package:freezed_annotation/freezed_annotation.dart';
$imports

part '${name.snakeCase}.freezed.dart';

@freezed
class $name with _\$${name} {
  const factory $name({
$fields
  }) = _${name};
}
''';
}

// ===== Presentation: State & Notifier (Either-aware) =====

String _emitState4(String apiName, String root, _RespKind kind) {
  final stateName = '${apiName.pascalCase}State';
  final ent = root.pascalCase;
  final successLine = switch (kind) {
    _RespKind.voidSuccess => 'const factory $stateName.success() = _Success;',
    _RespKind.object      => 'const factory $stateName.success($ent? data) = _Success;',
    _RespKind.list        => 'const factory $stateName.success(List<$ent> data) = _Success;',
  };

  return '''
import 'package:freezed_annotation/freezed_annotation.dart';
${kind == _RespKind.voidSuccess ? '' : "import '../../domain/entities/${ent.snakeCase}.dart';"}

part '${stateName.snakeCase}.freezed.dart';

@freezed
class $stateName with _\$${stateName} {
  const factory $stateName.initial() = _Initial;
  const factory $stateName.loading() = _Loading;
  $successLine
  const factory $stateName.failure(String message) = _Failure;
}
''';
}

String _emitNotifier(String apiName, String feature, String root, _RespKind kind, bool hasRequest) {
  final stateName = '${apiName.pascalCase}State';
  final notifierName = '${apiName.pascalCase}Notifier';
  final repoName = '${feature.pascalCase}Repository';
  final repoProvider = '${feature.camelCase}RepoProvider';
  final call = apiName.camelCase;

  final requestImport = hasRequest ? "import '../../data/models/${apiName.snakeCase}_request.dart';" : '';

  final methodSig = hasRequest
      ? '''
  Future<void> $call({ required ${apiName.pascalCase}Request request, }) async {'''
      : '''
  Future<void> $call() async {''';

  final callLine = hasRequest
      ? '    final result = await _repo.$call(request: request);\n'
      : '    final result = await _repo.$call();\n';

  final onRight = switch (kind) {
    _RespKind.voidSuccess => 'state = const $stateName.success();',
    _RespKind.object      => 'state = $stateName.success(data);',
    _RespKind.list        => 'state = $stateName.success(data);',
  };

  return '''
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dartz/dartz.dart';
import '../state/${apiName.snakeCase}_state.dart';
import '../../domain/repositories/${feature.snakeCase}_repository.dart';
import '../${feature.snakeCase}_providers.dart';
$requestImport

part '${apiName.snakeCase}_notifier.g.dart';

@riverpod
class $notifierName extends _\$${notifierName} {
  @override
  $stateName build() => const $stateName.initial();

  $repoName get _repo => ref.read($repoProvider);

  $methodSig
    state = const $stateName.loading();
$callLine
    result.fold(
      (err) => state = $stateName.failure(err.description ?? err.mwdesc ?? 'Server Error!'),
      (data) {
        $onRight
      },
    );
  }
}
''';
}

// ===================== SCHEMA INFERENCE CORE =====================

abstract class _Type { String get dartRef; }

class _TNull implements _Type {
  final _Type inner;
  _TNull(this.inner);
  @override String get dartRef => '${inner.dartRef}?';
}
class _TPrim implements _Type {
  final String name;
  _TPrim(this.name);
  @override String get dartRef => name;
}
class _TList implements _Type {
  final _Type item;
  _TList(this.item);
  @override String get dartRef => 'List<${item.dartRef}>';
}
class _TObj implements _Type {
  String className;
  Map<String,_Type> fields;
  _TObj(this.className,this.fields);
  @override String get dartRef => className;
}

class _Class {
  final String name;
  final Map<String,_Type> fields;
  _Class(this.name,this.fields);
  String get entityName => name.endsWith('Dto') ? name.substring(0,name.length-3) : '${name}Entity';
}

_TObj _inferMergedRoot(String rootName, List<Map<String,dynamic>> samples) {
  _TObj? acc;
  for (final m in samples) {
    final cur = _inferObjOnce(rootName.pascalCase, m);
    acc = acc==null ? cur : _merge(acc, cur) as _TObj;
  }
  return acc!;
}

// Request-specific merge that IGNORES "deviceInfo" from samples
_TObj _inferMergedRootForRequest(String rootName, List<Map<String, dynamic>> samples) {
  final sanitized = samples.map((m) {
    final copy = Map<String, dynamic>.from(m);
    copy.removeWhere((k, _) => k.toLowerCase() == 'deviceinfo');
    return copy;
  }).toList();
  return _inferMergedRoot(rootName, sanitized);
}

// SPECIAL CASES:
// - "headers" stays Map<String,dynamic>
// - For Request inference, "deviceInfo" ignored (we inject DeviceModel? at root)
_TObj _inferObjOnce(String className, Map<String,dynamic> json) {
  final f = <String,_Type>{};
  json.forEach((k,v){
    final lower = k.toLowerCase();
    if (lower == 'headers' && v is Map<String, dynamic>) {
      f[k] = _TPrim('Map<String, dynamic>');
    } else {
      f[k] = _infer('$className${k.pascalCase}', v);
    }
  });
  return _TObj(className, f);
}

_Type _infer(String hint, dynamic v) {
  if (v == null) return _TNull(_TPrim('dynamic'));
  if (v is String) return _TPrim('String');
  if (v is bool) return _TPrim('bool');
  if (v is int) return _TPrim('int');
  if (v is double) return _TPrim('double');
  if (v is num) return _TPrim('num');
  if (v is List) {
    if (v.isEmpty) return _TList(_TPrim('dynamic'));
    var item = _infer(_itemHint(hint), v.first);
    for (final e in v.skip(1)) { item = _merge(item, _infer(_itemHint(hint), e)); }
    return _TList(item);
  }
  if (v is Map<String,dynamic>) {
    final sub = _toClass(hint).replaceAll('Dto','') + 'Dto';
    return _inferObjOnce(sub, v);
  }
  return _TPrim('dynamic');
}

String _itemHint(String hint){
  final s = hint.pascalCase;
  return s.endsWith('s') && s.length>1 ? s.substring(0,s.length-1) : '${s}Item';
}

_Type _merge(_Type a,_Type b){
  if (a.runtimeType==b.runtimeType && a.dartRef==b.dartRef) return a;
  if (a is _TNull) return _TNull(_merge(a.inner,b));
  if (b is _TNull) return _TNull(_merge(a,b.inner));
  if (a is _TList && b is _TList) return _TList(_merge(a.item,b.item));
  if (a is _TObj && b is _TObj){
    final keys = {...a.fields.keys, ...b.fields.keys};
    final mf = <String,_Type>{};
    for (final k in keys){
      final at=a.fields[k], bt=b.fields[k];
      if (at==null) mf[k]=_TNull(bt!);
      else if (bt==null) mf[k]=_TNull(at);
      else mf[k]=_merge(at,bt);
    }
    return _TObj(a.className,mf);
  }
  return _TPrim('dynamic');
}

void _collectClasses(_TObj root, Map<String,_Class> out){
  if (out.containsKey(root.className)) return;
  out[root.className] = _Class(root.className, root.fields);
  for (final t in root.fields.values){
    if (t is _TObj) _collectClasses(t, out);
    if (t is _TList && t.item is _TObj) _collectClasses(t.item as _TObj, out);
  }
}

String _toClass(String raw){
  final s = raw.pascalCase;
  return s.endsWith('s') && s.length>1 ? s.substring(0,s.length-1) : s;
}

Set<String> _refsDto(_Class c){
  final r = <String>{};
  for (final t in c.fields.values){
    if (t is _TObj) r.add(t.className);
    if (t is _TList && t.item is _TObj) r.add((t.item as _TObj).className);
  }
  r.remove(c.name);
  return r;
}

Set<String> _refsEntity(_Class c){
  final r = <String>{};
  for (final t in c.fields.values){
    if (t is _TObj) r.add(_entityName(t.className));
    if (t is _TList && t.item is _TObj) r.add(_entityName((t.item as _TObj).className));
  }
  r.remove(_entityName(c.name));
  return r;
}

String _entityName(String dto) => dto.endsWith('Dto') ? dto.substring(0,dto.length-3) : '${dto}Entity';

// ✅ never make `dynamic` nullable
String _maybeQ(String t) {
  if (t == 'dynamic') return 'dynamic';
  return t.endsWith('?') ? t : '$t?';
}

// Map DTO primitive/list/object to entity types:
String _entityType(_Type t) {
  if (t is _TObj) return '${_entityName(t.className)}?';
  if (t is _TList) {
    final item = t.item;
    final ref = (item is _TObj) ? _entityName(item.className) : item.dartRef.replaceAll('?', '');
    return 'List<$ref>';
  }
  return t.dartRef.replaceAll('?', '');
}

// Keep "headers" as Map<String,dynamic> in DTOs
String _dartTypeForDtoField(String field, String originalRef) {
  if (field.toLowerCase() == 'headers') return 'Map<String, dynamic>';
  return originalRef;
}

// Map a DTO field to the corresponding entity field expression
String _mapDtoToEntity(String name, _Type t, String entityType, bool isNullable){
  if (!isNullable) {
    switch (entityType){
      case 'String': return '$name ?? ""';
      case 'bool': return '$name ?? false';
      case 'int': return '$name ?? 0';
      case 'double': return '$name ?? 0.0';
      case 'DateTime': return '$name ?? DateTime.fromMillisecondsSinceEpoch(0)';
    }
  } else {
    if (['String?','bool?','int?','double?','DateTime?'].contains(entityType)) return name;
  }
  if (t is _TObj) return '$name?.toEntity()';
  if (t is _TList) {
    final item = t.item;
    final objList = item is _TObj;
    return objList ? '$name?.map((e)=>e.toEntity()).toList() ?? const []' : '$name ?? const []';
  }
  return name;
}

// ===================== UTILITIES =====================

enum _RespKind { object, list, voidSuccess }

_RespKind _detectRespKind(List<dynamic> samples) {
  var sawObject = false, sawList = false;
  for (final d in samples) {
    if (d == null) continue;
    if (d is List) sawList = true;
    if (d is Map<String, dynamic>) sawObject = true;
  }
  if (sawList) return _RespKind.list;
  if (sawObject) return _RespKind.object;
  return _RespKind.voidSuccess;
}

String _readStrict(String path) {
  final f = File(path);
  if (!f.existsSync()) _die('File not found: $path', 66);
  return f.readAsStringSync();
}

dynamic _json(String raw, String origin) {
  try { return jsonDecode(raw); }
  on FormatException catch (e) { _die('Invalid JSON in $origin: ${e.message}', 65); }
}

Never _die(String m, int c) { stderr.writeln('❌ $m'); exit(c); }

void _help() {
  stdout.writeln('''
featurecast (v2) — incrementally add APIs into a feature

Required:
  --feature <name>    e.g., example
  --api <name>        e.g., fetchMenus
  --root <RootClass>  response root/entity base, e.g., Menus
  --input <path>      sample JSONs containing url/headers/request/response
Optional:
  --input-dir <folder>
  --force
  --replace

Notes:
- "request" is optional ({} tolerated). If present, generator emits request DTO and datasource injects DeviceModel.
- "response.data" optional; if missing, treated as void success (Unit at domain).
- Multi-API safe: imports are upserted; methods are inserted before class closing brace.
''');
}

String? _arg(List<String> args, String key) {
  final i = args.indexOf(key);
  return (i >= 0 && i + 1 < args.length) ? args[i + 1] : null;
}

List<String>? _argsAll(List<String> args, String key) {
  final out = <String>[];
  for (int i=0;i<args.length;i++) {
    if (args[i]==key && i+1<args.length) out.add(args[++i]);
  }
  return out.isEmpty ? null : out;
}
