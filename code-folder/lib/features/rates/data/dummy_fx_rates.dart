import '../domain/entities/fx_rates.dart';

class DummyFxRatesResponse {
  static List<FxRates> get rates => [
    FxRates(
      isoCode: "USD",
      isoCodeNum: "840",
      curName: "United States Dollar",
      shortCurName: "Dollar",
      ttBuy: "0.275103",
      ttSell: "3.650000000",
    ),
    FxRates(
      isoCode: "AUD",
      isoCodeNum: "36",
      curName: "Australia, Dollars",
      shortCurName: "Dollar",
      ttBuy: "0.423307",
      ttSell: "2.483500000",
    ),
    FxRates(
      isoCode: "NZD",
      isoCodeNum: "554",
      curName: "New Zealand, Dollars",
      shortCurName: "Dollar",
      ttBuy: "0.475733",
      ttSell: "2.209830000",
    ),
  ];
}
