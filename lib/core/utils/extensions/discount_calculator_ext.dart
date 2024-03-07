extension DiscountCalculatorExtension on double {
  double toDiscountedPrice(double? discount) {
    if (discount == null) return this;
    final discountPrice = (this - (this * (discount / 100)));

    return (discountPrice * 100).round() / 100;
  }

  double toOriginalPrice(double? discount) {
    if (discount == null) return this;
    final origPrice = (this + (this * (discount / 100)));

    return (origPrice * 100).round() / 100;
  }
}
