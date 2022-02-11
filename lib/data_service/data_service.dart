import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/utils/api_helper.dart';
import 'package:flutter/material.dart';

class DataService {
  ApiBaseHelper helper = ApiBaseHelper();
  bool isLoading = false;
  Future<List> getNewsDetails() async {
    try {
      var response = await helper.get('');
      // print('the reponse is : ${response["articles"][0]["urlToImage"]}');
      return response["articles"];
    } catch (e) {
      rethrow;
    }
  }
}
