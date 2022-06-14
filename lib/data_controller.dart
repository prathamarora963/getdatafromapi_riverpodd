import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:riverpodd/datamodel.dart';
final getDataFuture = ChangeNotifierProvider<getdatafromapi>((ref) => getdatafromapi());

class getdatafromapi extends ChangeNotifier {
  List<dataModel> listDataModel = [];

  getdatafromapi() {
    getdata();
  }

  Future getdata() async {
    listDataModel = [];
    var respone = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    List data = jsonDecode(respone.body);
    for (int i = 0; i < data.length; i++) {
      listDataModel.add(dataModel.fromMap(data[i]));
      print(data[i]);
    }
    notifyListeners();
  }
}