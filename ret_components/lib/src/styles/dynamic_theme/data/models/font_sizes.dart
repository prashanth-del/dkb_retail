import 'package:freezed_annotation/freezed_annotation.dart';

part 'font_sizes.freezed.dart';
part 'font_sizes.g.dart';

@freezed
class FontSizes with _$FontSizes {
  const factory FontSizes({
    required double fontSizeExtraSmall,
    required double fontSizeSubtitle,
    required double fontSizeTitle,
    required double fontSizeBigTitle,
    required double fontSizeHeadline3,
    required double fontSizeHeadline2,
    required double fontSizeHeadline1,
    required double labelFontSize,
  }) = _FontSizes;

  factory FontSizes.fromJson(Map<String, dynamic> json) =>
      _$FontSizesFromJson(json);
}