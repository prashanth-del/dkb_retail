// seed.dart — create a feature folder skeleton and basic stubs.
//
// Usage:
//   dart run db_codegen:seed --feature login
//   dart run db_codegen:seed --feature transfers --base lib/features
//   dart run db_codegen:seed --feature approvals --no-gitkeep
//
// Default base = lib/features

import 'dart:io';

void main(List<String> args) {
  final feature = _arg(args, '--feature');
  final base = _arg(args, '--base') ?? 'lib/features';
  final addGitkeep = !args.contains('--no-gitkeep');

  if (feature == null || feature.trim().isEmpty) {
    _help();
    exit(64);
  }

  final slug = _slug(feature);      // e.g., login
  final pascal = _pascal(feature);  // e.g., Login
  final root = _join(base, slug);

  final plan = <String>[
    // data
    _join(root, 'data'),
    _join(root, 'data', 'datasource'),
    _join(root, 'data', 'datasource', 'src'),
    _join(root, 'data', 'models'),
    _join(root, 'data', 'repository'),
    // domain
    _join(root, 'domain'),
    _join(root, 'domain', 'entities'),
    _join(root, 'domain', 'locator'),
    _join(root, 'domain', 'repository'),
    // presentation
    _join(root, 'presentation'),
    _join(root, 'presentation', 'controller'),
    _join(root, 'presentation', 'controller', 'state'),
    _join(root, 'presentation', 'pages'),
    _join(root, 'presentation', 'widgets'),
  ];

  for (final dir in plan) {
    Directory(dir).createSync(recursive: true);
    if (addGitkeep) {
      final keep = File(_join(dir, '.gitkeep'));
      if (!keep.existsSync()) keep.writeAsStringSync('');
    }
    stdout.writeln('✔︎ $dir');
  }

  // ---- Stub files (created only if missing) ----
  _writeIfMissing(
    _join(root, 'data', 'datasource', '${slug}_datasource.dart'),
    '''
// Data source for $feature — implement your API calls here.
abstract class ${pascal}DataSource {
  // Example:
  // Future<Map<String, dynamic>> login({required String username, required String password});
}
''',
  );

  _writeIfMissing(
    _join(root, 'domain', 'repository', '${slug}_repository.dart'),
    '''
// Domain repository interface for $feature.
abstract class ${pascal}Repository {
  // Define the methods your presentation/domain will use.
  // Example:
  // Future<Result<User>> login({required String username, required String password});
}
''',
  );

  _writeIfMissing(
    _join(root, 'data', 'repository', '${slug}_repository_impl.dart'),
    '''
// Repository implementation for $feature — bridge Data -> Domain.
import '../../domain/repository/${slug}_repository.dart';
// import '../datasource/${slug}_datasource.dart';

class ${pascal}RepositoryImpl implements ${pascal}Repository {
  // final ${pascal}DataSource _ds;
  // ${pascal}RepositoryImpl(this._ds);

  // Implement ${pascal}Repository methods here using _ds
}
''',
  );

  _writeIfMissing(
    _join(root, 'presentation', 'controller', '${slug}_providers.dart'),
    '''
// Riverpod providers/controllers for $feature.
// Define your Notifiers, Controllers, and Providers here.
// Example:
// final ${slug}ControllerProvider = StateNotifierProvider<${pascal}Controller, ${pascal}State>((ref) {
//   final repo = ref.watch(${slug}RepositoryProvider);
//   return ${pascal}Controller(repo);
// });
''',
  );

  stdout.writeln('\n✨ Seeding done! ✨');
  stdout.writeln('🌱 Feature: $feature');
  stdout.writeln('📂 Path   : $root\n');
}

String? _arg(List<String> args, String key) {
  final i = args.indexOf(key);
  return (i >= 0 && i + 1 < args.length) ? args[i + 1] : null;
}

String _join(String a, [String? b, String? c, String? d]) =>
    [a, b, c, d].whereType<String>().join(Platform.pathSeparator);

String _slug(String s) => s
    .trim()
    .replaceAll(RegExp(r'[^a-zA-Z0-9]+'), '_')
    .replaceAll(RegExp(r'_+'), '_')
    .replaceAll(RegExp(r'^_|_$'), '')
    .toLowerCase();

String _pascal(String s) {
  final parts = _slug(s).split('_');
  return parts.map((p) => p.isEmpty ? '' : p[0].toUpperCase() + p.substring(1)).join();
}

void _writeIfMissing(String path, String content) {
  final f = File(path);
  if (!f.existsSync()) {
    f.writeAsStringSync(content);
    stdout.writeln('✍️  $path');
  } else {
    stdout.writeln('⚠️  Skip (exists): $path');
  }
}

void _help() {
  stdout.writeln('''
seed — create a feature folder skeleton (data/domain/presentation)

Required:
  --feature <name>        e.g., login

Optional:
  --base <path>           root for features (default: lib/features)
  --no-gitkeep            do not create .gitkeep files

Examples:
  dart run db_codegen:seed --feature login
  dart run db_codegen:seed --feature approvals --base lib/modules
  dart run db_codegen:seed --feature profile --no-gitkeep
''');
}
