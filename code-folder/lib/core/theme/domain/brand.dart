enum Brand { regular, private }

extension BrandX on Brand {
  String get key => switch (this) {
    Brand.regular => 'regular',
    Brand.private => 'private',
  };

  String get displayName => switch (this) {
    Brand.regular => 'Regular',
    Brand.private => 'Private',
  };

  static Brand fromKey(String? s) {
    switch (s) {
      case 'regular':
        return Brand.regular;
      case 'private':
      default:
        return Brand.private;
    }
  }
}
