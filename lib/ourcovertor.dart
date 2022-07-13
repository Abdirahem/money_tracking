class CurrencyFormatting {
  kmb_currency(num) {
    if (num > 999 && num < 9999) {
      return ('${(num).toStringAsFixed(1)}');
    } else if (num > 9999 && num < 999999) {
      return ('${(num / 1000).toStringAsFixed(1)}K');
    } else if (num > 999999 && num < 999999999) {
      return ('${(num / 1000000).toStringAsFixed(1)}M');
    } else if (num > 999999999) {
      return ('${(num / 1000000000).toStringAsFixed(1)}B');
    }
  }
}
