import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/app_strings/default_string.dart';
import 'riverpod_i18n_source.dart';

class I18nBinder extends ConsumerWidget {
  final Widget child;
  const I18nBinder({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DefaultString.bind(RiverpodI18nSource(ref));
    return child;
  }
}
