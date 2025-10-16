import 'package:dkb_retail/core/constants/asset_path/asset_path.dart';

class AssetTitle {
  final String? assetPath;
  final String title;

  AssetTitle({this.assetPath, required this.title});

  factory AssetTitle.withDefaultPath({required String title}) {
    return AssetTitle(assetPath: AssetPath.icon.domestic, title: title);
  }
}
