import 'package:crypto_android_widget/infra/http_request/http_request.dart';
import 'package:dio/dio.dart';

class CryptosService {
  final request = HttpRequest();

  Future<List> fetch() async {
    try {
      Response response = await request.httpGet('/cryptocurrency/listings/latest?CMC_PRO_API_KEY=4d99bb12-f6a2-49f1-86cf-2a626165bdc4');
      return response.data['data'].map((e) {
      //return response.data.map((e){
        final priceFormatted =
        e['quote']['USD']['price'].toStringAsFixed(2);
        return {
          'name': e['name'],
          'symbol': e['symbol'],
          'price': priceFormatted,
          'selected': false,
        };
      }).toList();
    } catch (e) {
      return [];
    }
  }

  Future fetchCryptoMetrics(cryptoSymbol) async {
    try {
      final url = "/cryptocurrency/quotes/latest?symbol=$cryptoSymbol&CMC_PRO_API_KEY=4d99bb12-f6a2-49f1-86cf-2a626165bdc4";
      Response response = await request.httpGet(url);

      final crypto = response.data['data']['$cryptoSymbol'];
      var priceFormatted =
      crypto['quote']['USD']['price'].toStringAsFixed(2);
      return {
        'name': crypto['name'],
        'symbol': crypto['symbol'],
        'price': priceFormatted,
        'selected': false,
      };
    } catch (e) {
      return null;
    }
  }
}
