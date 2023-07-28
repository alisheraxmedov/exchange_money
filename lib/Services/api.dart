import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:money_exchange/key/key.dart';

class CurrencyConverter{

  Future<Map<String, dynamic>> getExchangeRates()async{
    final response = await http.get(Uri.parse(url2));
    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }else{
      throw Exception("status code eror");
    }
  }
}