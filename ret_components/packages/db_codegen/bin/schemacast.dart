// // SchemaCast — JSON -> Freezed DTO + Entity generator (envelope-aware)
// Examples:
//   dart run db_codegen:schemacast --feature transfers --root TransfersPendingCountItem --input ./TransferCount.json
//   dart run db_codegen:schemacast --feature transfers --root TransferDetail --input ./TransferDetails.json \
//       --entity-nullable detailsMap.innerKey,actionHistory.userName,mt103String,transferDet
//
// After generation, run in your app:
//   dart run build_runner build -d

import 'dart:convert';
import 'dart:io';
import 'package:recase/recase.dart';

void main(List<String> args) async {
  final feature = _arg(args, '--feature');
  final root = _arg(args, '--root');
  final inputs = _argsAll(args, '--input');    // can repeat
  final inputDir = _arg(args, '--input-dir');  // optional dir with *.json
  final force = args.contains('--force');

  final nullableKeysRaw = _arg(args, '--entity-nullable'); // comma delimited, supports dotted paths
  final allowlistPaths = <List<String>>[];
  if (nullableKeysRaw != null) {
    for (final token in nullableKeysRaw.split(',')) {
      final p = token.trim();
      if (p.isEmpty) continue;
      allowlistPaths.add(p.split('.').map((s) => s.trim()).where((s) => s.isNotEmpty).toList());
    }
  }

  if (feature == null || root == null || ((inputs == null || inputs.isEmpty) && inputDir == null)) {
    _help();
    exit(64); // EX_USAGE
  }

  // 1) Collect samples (unwrap {status,data}, step into single-key object)
  final samples = <Map<String, dynamic>>[];

  Future<void> _ingest(dynamic parsed, {String? origin}) async {
    dynamic d = parsed;
    if (d is Map && d['status'] != null && d['data'] != null) d = d['data'];
    if (d is Map && d.keys.length == 1) d = d.values.first;

    if (d is List) {
      for (final e in d) {
        if (e is Map<String, dynamic>) samples.add(e);
      }
    } else if (d is Map<String, dynamic>) {
      samples.add(d);
    } else {
      stderr.writeln('⚠️  Skipped non-object JSON ${origin ?? ""}');
    }
  }

  if (inputs != null) {
    for (final p in inputs) {
      final raw = p == '-' ? await _readAllStdin() : _readFileStrict(p);
      final val = _safeDecode(raw, p);
      await _ingest(val, origin: p);
    }
  }
  if (inputDir != null) {
    final dir = Directory(inputDir);
    if (!dir.existsSync()) _fatal('Directory not found: $inputDir', 66);
    final files = dir
        .listSync(recursive: false)
        .whereType<File>()
        .where((f) => f.path.toLowerCase().endsWith('.json'));
    var any = false;
    for (final f in files) {
      any = true;
      final raw = _readFileStrict(f.path);
      final val = _safeDecode(raw, f.path);
      await _ingest(val, origin: f.path);
    }
    if (!any) _fatal('No .json files in $inputDir', 66);
  }

  if (samples.isEmpty) _fatal('No valid JSON objects found after unwrapping.', 65);

  final rootDtoName = '${root.pascalCase}Dto';

  // 2) Infer merged schema (DTO)
  final merged = _inferMergedRoot(rootDtoName, samples);

  // 3) Collect all classes
  final classes = <String, _Class>{};
  _collectClasses(merged, classes);

  // 4) Build a field graph from root to resolve dotted allowlist → ClassName::field
  final nullableClassFields = _resolveAllowlistToClassFields(
    rootDtoName,
    classes,
    allowlistPaths,
  ); // Set of "ClassName::field"

  // 5) Emit files
  final dtoDir = Directory('lib/features/$feature/data/models')..createSync(recursive: true);
  final entDir = Directory('lib/features/$feature/domain/entities')..createSync(recursive: true);

  for (final c in classes.values) {
    final dtoPath = '${dtoDir.path}/${c.name.snakeCase}.dart';
    final entPath = '${entDir.path}/${c.entityName.snakeCase}.dart';
    _write(dtoPath, _emitDtoFreezed(c, classes), force);
    _write(entPath, _emitEntityFreezed(c, classes, nullableClassFields), force);
  }

  stdout.writeln('\n🌱 [SchemaCast] Feature "$feature" generated ${classes.length} types.');
  stdout.writeln('📂 Output: ${File('lib/features/$feature').absolute.path}');
  stdout.writeln('➡️  Next: run "dart run build_runner build -d" in your app.');
}

void _help() {
  stdout.writeln('''
schemacast — JSON -> Freezed DTO + Entity generator (envelope-aware)

Required:
  --feature <name>        e.g., transfers
  --root <RootClass>      e.g., TransferDetail
  --input <path|->        one or more JSON files (can repeat), "-" = stdin
OR:
  --input-dir <folder>    directory with multiple *.json samples
Optional:
  --force                 overwrite existing files
  --entity-nullable a,b,c or dotted a.b,c.d.e
                         make specific entity fields nullable (top-level or nested)

Examples:
  dart run db_codegen:schemacast --feature transfers --root TransfersPendingCountItem --input ./TransferCount.json
  dart run db_codegen:schemacast --feature transfers --root TransferDetail --input ./TransferDetails.json --entity-nullable detailsMap.innerKey,mt103String
''');
}

// ---------- robust IO helpers ----------

String _readFileStrict(String path) {
  final file = File(path);
  if (!file.existsSync()) _fatal('File not found: $path', 66);
  try {
    return file.readAsStringSync();
  } on FileSystemException catch (e) {
    _fatal('Cannot read file: $path\nReason: ${e.message}', 66);
  }
  return '';
}

Future<String> _readAllStdin() async {
  if (stdin.hasTerminal) _fatal('No stdin provided. Use --input <path> or --input - and pipe JSON.', 64);
  final raw = await stdin.transform(utf8.decoder).join();
  if (raw.trim().isEmpty) _fatal('Empty stdin. Pipe JSON or use --input <path>.', 65);
  return raw;
}

dynamic _safeDecode(String raw, String origin) {
  try {
    return jsonDecode(raw);
  } on FormatException catch (e) {
    _fatal('Invalid JSON in $origin:\n${e.message}', 65);
  }
  return null;
}

Never _fatal(String msg, int code) {
  stderr.writeln('❌ $msg');
  exit(code);
}

String? _arg(List<String> args, String key) {
  final i = args.indexOf(key);
  return (i >= 0 && i + 1 < args.length) ? args[i + 1] : null;
}

List<String>? _argsAll(List<String> args, String key) {
  final out = <String>[];
  for (int i = 0; i < args.length; i++) {
    if (args[i] == key && i + 1 < args.length) out.add(args[++i]);
  }
  return out.isEmpty ? null : out;
}

void _write(String path, String content, bool force) {
  final f = File(path);

  if (f.existsSync() && !force) {
    stdout.writeln('⚠️  File already exists: $path');
    while (true) {
      stdout.write('Do you want to overwrite it? (y/N): ');
      final resp = stdin.readLineSync()?.trim();
      if (resp == null || resp.isEmpty || resp.toLowerCase() == 'n') {
        stdout.writeln('⏭️  Skipped: $path');
        return;
      } else if (resp.toLowerCase() == 'y') {
        break;
      } else {
        stdout.writeln('❌ Invalid input. Please enter "y" or "n".');
      }
    }
  }

  f.writeAsStringSync(content);
  stdout.writeln('✍️  Wrote: $path');
}

/* =====================  Schema types  ===================== */

abstract class _Type { String get dartRef; }

class _TNull implements _Type {
  final _Type inner;
  _TNull(this.inner);
  @override
  String get dartRef => '${inner.dartRef}?';
}

class _TPrim implements _Type {
  final String name; // String, bool, int, double, num, DateTime, dynamic
  _TPrim(this.name);
  @override
  String get dartRef => name;
}

class _TList implements _Type {
  final _Type item;
  _TList(this.item);
  @override
  String get dartRef => 'List<${item.dartRef}>';
}

class _TObj implements _Type {
  String className;                   // e.g., TransferDetailDto
  Map<String, _Type> fields;          // field -> type
  _TObj(this.className, this.fields);
  @override
  String get dartRef => className;
}

class _Class {
  final String name;                  // e.g., TransferDetailDto
  final Map<String, _Type> fields;
  _Class(this.name, this.fields);
  String get entityName => name.endsWith('Dto') ? name.substring(0, name.length - 3) : '${name}Entity';
}

/* =====================  Inference & merge (DTO)  ===================== */

_TObj _inferMergedRoot(String rootName, List<Map<String, dynamic>> samples) {
  _TObj? acc;
  for (final m in samples) {
    final cur = _inferObjOnce(rootName.pascalCase, m);
    acc = acc == null ? cur : _mergeTypes(acc!, cur) as _TObj;
  }
  return acc!;
}

_TObj _inferObjOnce(String className, Map<String, dynamic> json) {
  final fields = <String, _Type>{};
  json.forEach((k, v) {
    fields[k] = _inferOnce('$className${k.pascalCase}', v);
  });
  return _TObj(className, fields);
}

_Type _inferOnce(String hint, dynamic v) {
  if (v == null) return _TNull(_TPrim('dynamic'));
  if (v is String) {
    // keep String (no DateTime auto-detection to avoid false positives)
    return _TPrim('String');
  }
  if (v is bool) return _TPrim('bool');
  if (v is int) return _TPrim('int');
  if (v is double) return _TPrim('double');
  if (v is num) return _TPrim('num');
  if (v is List) {
    if (v.isEmpty) return _TList(_TPrim('dynamic'));
    var item = _inferOnce(_itemHint(hint), v.first);
    for (final e in v.skip(1)) {
      item = _mergeTypes(item, _inferOnce(_itemHint(hint), e));
    }
    return _TList(item);
  }
  if (v is Map<String, dynamic>) {
    // Nested DTO classname: <Hint>Dto (collapse duplicate 'Dto')
    var sub = _keyToClass(hint).replaceAll('Dto', '') + 'Dto';
    return _inferObjOnce(sub, v);
  }
  return _TPrim('dynamic');
}

String _itemHint(String hint) {
  final s = hint.pascalCase;
  if (s.endsWith('s') && s.length > 1) return s.substring(0, s.length - 1);
  return '${s}Item';
}

_Type _mergeTypes(_Type a, _Type b) {
  if (a.runtimeType == b.runtimeType && a.dartRef == b.dartRef) return a;

  // nullability bubbles up
  if (a is _TNull) return _TNull(_mergeTypes(a.inner, b));
  if (b is _TNull) return _TNull(_mergeTypes(a, b.inner));

  // lists: merge items
  if (a is _TList && b is _TList) return _TList(_mergeTypes(a.item, b.item));

  // objects: merge field-wise
  if (a is _TObj && b is _TObj) {
    final keys = {...a.fields.keys, ...b.fields.keys};
    final mf = <String, _Type>{};
    for (final k in keys) {
      final at = a.fields[k];
      final bt = b.fields[k];
      if (at == null) mf[k] = _TNull(bt!);
      else if (bt == null) mf[k] = _TNull(at);
      else mf[k] = _mergeTypes(at, bt);
    }
    return _TObj(a.className, mf);
  }

  // primitives disagreement → dynamic
  return _TPrim('dynamic');
}

void _collectClasses(_TObj root, Map<String, _Class> out) {
  if (out.containsKey(root.className)) return;
  out[root.className] = _Class(root.className, root.fields);
  for (final f in root.fields.values) {
    if (f is _TObj) _collectClasses(f, out);
    if (f is _TList && f.item is _TObj) _collectClasses(f.item as _TObj, out);
  }
}

String _keyToClass(String raw) {
  final s = raw.pascalCase;
  if (s.endsWith('s') && s.length > 1) return s.substring(0, s.length - 1);
  return s;
}

/* ============== Allowlist resolution (dotted paths) ============== */

Set<String> _resolveAllowlistToClassFields(
    String rootDtoName,
    Map<String, _Class> classes,
    List<List<String>> allowlistPaths,
    ) {
  final out = <String>{};
  for (final path in allowlistPaths) {
    if (path.isEmpty) continue;

    // navigate from root DTO through the path, stopping at the parent of the final field
    String? curClass = rootDtoName;
    for (int i = 0; i < path.length - 1; i++) {
      final seg = path[i];
      curClass = _stepToChildClass(curClass, seg, classes);
      if (curClass == null) break;
    }
    if (curClass == null) continue;

    final lastField = path.last;
    out.add('$curClass::$lastField'); // mark that class.field as nullable
  }
  return out;
}

// From className, follow field name (or list item) to the next class if object-like
String? _stepToChildClass(String? className, String field, Map<String, _Class> classes) {
  if (className == null) return null;
  final c = classes[className];
  if (c == null) return null;
  final t = c.fields[field];
  if (t == null) return null;

  if (t is _TObj) return t.className;
  if (t is _TList && t.item is _TObj) return (t.item as _TObj).className;
  return null; // primitive or list<primitive> → no deeper class
}

/* =====================  Type helpers  ===================== */

String _entityNameOf(String dtoClassName) =>
    dtoClassName.endsWith('Dto') ? dtoClassName.substring(0, dtoClassName.length - 3) : '${dtoClassName}Entity';

Set<String> _referencedDtoClasses(_Class c) {
  final refs = <String>{};
  for (final t in c.fields.values) {
    if (t is _TObj) refs.add(t.className);
    if (t is _TList && t.item is _TObj) refs.add((t.item as _TObj).className);
  }
  refs.remove(c.name);
  return refs;
}

Set<String> _referencedEntityClasses(_Class c) {
  final refs = <String>{};
  for (final t in c.fields.values) {
    if (t is _TObj) refs.add(_entityNameOf(t.className));
    if (t is _TList && t.item is _TObj) refs.add(_entityNameOf((t.item as _TObj).className));
  }
  refs.remove(_entityNameOf(c.name)); // avoid self-import
  return refs;
}

/* =====================  Emit: DTO  ===================== */

String _emitDtoFreezed(_Class c, Map<String, _Class> all) {
  final cls = c.name;
  final ent = _entityNameOf(c.name);

  final dtoImports = _referencedDtoClasses(c)
      .map((cn) => "import './${cn.snakeCase}.dart';")
      .join('\n');

  final fields = c.fields.entries
      .map((e) => '    ${_dtoType(e.value.dartRef)} ${e.key},')
      .join('\n');

  final toEntityArgs = c.fields.entries.map((e) {
    final entityT = _entityTypeFromDtoRef(c.name, e.key, e.value); // entity type string
    final isNullable = entityT.endsWith('?');
    return '      ${e.key}: ${_dtoToEntityExpr(e.key, e.value, entityT, isNullable)},';
  }).join('\n');

  return '''
// GENERATED DTO (Freezed): $cls
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
$toEntityArgs
  );
}
''';
}

String _dtoType(String t) => t.endsWith('?') ? t : '$t?';

/* =====================  Emit: Entity  ===================== */

// Entities mirror DTO shapes with these rules:
// - Object fields: always nullable (SomeEntity?)
// - Primitive/List: non-null unless allowlisted (nullableClassFields)
// - List<T>: non-null List by default; allowlist can make it `List<T>?`
// - NO json_serializable on entities: no .g.dart part and no fromJson factory
String _emitEntityFreezed(
    _Class c,
    Map<String, _Class> all,
    Set<String> nullableClassFields,
    ) {
  final name = _entityNameOf(c.name);

  final entityImports = _referencedEntityClasses(c)
      .map((en) => "import './${en.snakeCase}.dart';")
      .join('\n');

  final fieldLines = <String>[];
  for (final e in c.fields.entries) {
    final et = _entityTypeFromDtoRef(
      c.name,
      e.key,
      e.value,
      nullableClassFields: nullableClassFields,
    );
    final isNullable = et.endsWith('?');
    final req = isNullable ? '' : 'required ';
    fieldLines.add('    $req$et ${e.key},');
  }
  final fields = fieldLines.join('\n');

  return '''
// GENERATED Entity (Freezed): $name
import 'package:freezed_annotation/freezed_annotation.dart';
$entityImports

part '${name.snakeCase}.freezed.dart';

@freezed
class $name with _\$${name} {
  const factory $name({
$fields
  }) = _${name};
}
''';
}

/* =====================  Entity type derivation  ===================== */

String _entityTypeFromDtoRef(
    String currentClass,
    String fieldName,
    _Type dtoType, {
      Set<String> nullableClassFields = const {},
    }) {
  // object -> always nullable entity object
  if (dtoType is _TObj) return '${_entityNameOf(dtoType.className)}?';

  // list
  if (dtoType is _TList) {
    final item = dtoType.item;
    final itemRef = (item is _TObj)
        ? _entityNameOf(item.className)
        : _stripNullable(_primRef(item.dartRef));
    final base = 'List<$itemRef>';
    final markNullable = nullableClassFields.contains('$currentClass::$fieldName');
    return markNullable ? '$base?' : base;
  }

  // primitive: make non-null unless allowlisted
  final basePrim = _stripNullable(_primRef(dtoType.dartRef));
  final markNullable = nullableClassFields.contains('$currentClass::$fieldName');
  return markNullable ? '$basePrim?' : basePrim;
}

String _stripNullable(String t) => t.endsWith('?') ? t.substring(0, t.length - 1) : t;
String _primRef(String t) => t; // keep primitive as-is (no promotions)

/* =====================  Mapping DTO -> Entity  ===================== */

String _dtoToEntityExpr(String name, _Type t, String entityType, bool isNullable) {
  // primitives defaults if non-nullable
  if (!isNullable) {
    switch (entityType) {
      case 'String':
        return '$name ?? ""';
      case 'bool':
        return '$name ?? false';
      case 'int':
        return '$name ?? 0';
      case 'double':
        return '$name ?? 0.0';
      case 'DateTime':
        return '$name ?? DateTime.fromMillisecondsSinceEpoch(0)';
    }
  } else {
    // nullable primitives: pass-through
    if (entityType == 'String?' || entityType == 'bool?' || entityType == 'int?' || entityType == 'double?' || entityType == 'DateTime?') {
      return name;
    }
  }

  // object entity (always nullable)
  if (t is _TObj) {
    return '$name?.toEntity()';
  }

  // list
  if (t is _TList) {
    final item = t.item;
    final isObjList = item is _TObj;
    if (isNullable) {
      // nullable List<T>?
      if (isObjList) return '$name?.map((e)=>e.toEntity()).toList()';
      return name; // nullable List<primitive>? -> pass-through
    } else {
      // non-nullable List<T>
      if (isObjList) return '$name?.map((e)=>e.toEntity()).toList() ?? const []';
      return '$name ?? const []';
    }
  }

  // fallback: return as-is
  return name;
}
