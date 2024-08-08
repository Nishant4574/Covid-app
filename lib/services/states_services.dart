import 'dart:convert';

import 'package:covid_app/services/Utilities/app_url.dart';

import '../model/WorldStatesModel.dart';
import 'package:http/http.dart'as http;

class StatesServices{
  Future<WorldStatesModel> fetchWorkStatesRecords()async{
    final response =await http.get(Uri.parse(AppUrl.worldStatesApi));
    if(response.statusCode==200){
      var data =jsonDecode(response.body);
      return WorldStatesModel.fromJson(data);
    }else{
     return throw Exception("Error");
    }
  }
  Future<List<dynamic>> fetchCountriesRecords()async{
    final response =await http.get(Uri.parse(AppUrl.CountriesList));
    if(response.statusCode==200){
      var data =jsonDecode(response.body);
      return data;
    }else{
      return throw Exception("Error");
    }
  }
}