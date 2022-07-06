import 'package:http/http.dart' as http;
import 'dart:convert';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = '7B9B619B-C9C8-44AC-974C-84A77AFDA5AD';
const String base = 'BTC';

class CoinData {
  Future getCoinData(String targetCurrency) async {
    Map<String, String> cryptoPrices = {};
    for(String crypto in cryptoList) {
      var requestURL = '$coinAPIURL/$crypto/$targetCurrency/?apikey=$apiKey';
      http.Response response = await http.get(Uri.parse(requestURL));

      if(response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        cryptoPrices[crypto] = decodedData['rate'].toString();
      }
      else {
        throw 'Problem with request ${response.statusCode}';
      }
    }
    return cryptoPrices;
  }
}
