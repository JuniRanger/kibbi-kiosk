class CurrencyData {
  CurrencyData({
    String? symbol,
    String? title,
  }) {
    _symbol = symbol ?? "\$";
    _title = title ?? "MXN";
  }

  CurrencyData.fromJson(dynamic json) {
    _symbol = json['symbol'] ?? "\$";
    _title = json['title'] ?? "MXN";
  }

  String? _symbol;
  String? _title;

  CurrencyData copyWith({
    String? symbol,
    String? title,
  }) =>
      CurrencyData(
        symbol: symbol ?? _symbol,
        title: title ?? _title,
      );

  String? get symbol => _symbol;
  String? get title => _title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['symbol'] = _symbol;
    map['title'] = _title;
    return map;
  }
}