part 'src/flag_assets.dart';
part 'src/icon_assets.dart';
part 'src/image_assets.dart';
part 'src/lottie_assets.dart';
part 'src/svg_assets.dart';
part 'src/video_assets.dart';

mixin _BasePaths {
  static const imagePath = 'assets/images/';
  static const iconPath = 'assets/icons/';
  static const videoPath = 'assets/video/';
  static const svgPath = 'assets/svg/';
  static const lottiePath = 'assets/lottie/';
  static const flagPath = 'assets/images/flags/';
}

/// AssetPath
/// Eg: [AssetPath.svg.logo].
/// Call [AssetPath] class and its variant to fetch assets.
class AssetPath {
  const AssetPath._();

  static final IconAssets icon = IconAssets();
  static final ImageAssets image = ImageAssets();
  static final VideoAssets video = VideoAssets();
  static final SvgAssets svg = SvgAssets();
  static final LottieAssets lottie = LottieAssets();
  static final FlagAssets flag = FlagAssets();
}
