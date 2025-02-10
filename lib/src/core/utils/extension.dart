import 'package:kiosk/src/models/response/income_chart_response.dart';

import '../../models/data/addons_data.dart';
import '../../models/data/bag_data.dart';

extension AddProduct on List<Addons>? {
  String toUniqueString() {
    List<Addons> addons = this ?? [];

    List<int?> stockIds = addons
        .where(
          (element) => element.active ?? false,
        )
        .toList()
        .map(
          (e) => e.product?.stock?.id,
        )
        .toList();
    stockIds.sort();
    return stockIds.join(',');
  }
}

extension AddProduct2 on List<BagProductData>? {
  String toUniqueString() {
    List<BagProductData> addons = this ?? [];

    List<int?> stockIds = addons
        .map(
          (e) => e.stockId,
        )
        .toList();
    stockIds.sort();
    return stockIds.join(',');
  }
}

extension Time on DateTime {
  bool toEqualTime(DateTime time) {
    if (time.year != year) {
      return false;
    } else if (time.month != month) {
      return false;
    } else if (time.day != day) {
      return false;
    }
    return true;
  }

  bool toEqualTimeWithHour(DateTime time) {
    if (time.year != year) {
      return false;
    } else if (time.month != month) {
      return false;
    } else if (time.day != day) {
      return false;
    } else if (time.hour != hour) {
      return false;
    }
    return true;
  }
}

extension FindPriceIndex on List<num> {
  double findPriceIndex(num price) {
    if (price != 0) {
      int startIndex = 0;
      int endIndex = 0;
      for (int i = 0; i < length; i++) {
        if ((this[i]) >= price.toInt()) {
          startIndex = i;
          break;
        }
      }
      for (int i = 0; i < length; i++) {
        if ((this[i]) <= price) {
          endIndex = i;
        }
      }
      if (startIndex == endIndex) {
        return length.toDouble();
      }

      num a = this[startIndex] - this[endIndex];
      num b = price - this[endIndex];
      num c = b / a;
      return startIndex.toDouble() + c;
    } else {
      return 0;
    }
  }
}

extension FindPrice on List<IncomeChartResponse> {
  num findPrice(DateTime time) {
    num price = 0;
    for (int i = 0; i < length; i++) {
      if (this[i].time!.toEqualTime(time)) {
        price = this[i].totalPrice ?? 0;
      }
    }
    return price;
  }

  num findPriceWithHour(DateTime time) {
    num price = 0;
    for (int i = 0; i < length; i++) {
      if (this[i].time!.toEqualTimeWithHour(time)) {
        price = this[i].totalPrice ?? 0;
      }
    }
    return price;
  }
}

extension BoolParsing on String {
  bool toBool() {
    return this == "true" || this == "1";
  }
}

extension ExtendedIterable<E> on Iterable<E> {
  mapIndexed<T>(T Function(E e, int i) f) {
    var i = 0;
    return map((e) => f(e, i++)).toList();
  }
}
