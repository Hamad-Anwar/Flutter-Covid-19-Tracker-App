import 'dart:convert';

import 'package:corona_info/Model/Home_data_model.dart';
import 'package:corona_info/Services/Utils/AppUrls.dart';
import 'package:http/http.dart' as http;
class ApiServices{

   Future<HomeDataModel> getAllDataApi()async{
    final response=await http.get(Uri.parse(AppUrl.allUrl));
    var data=jsonDecode(response.body);
    if(response.statusCode==200){
      return HomeDataModel.fromJson(data);
    }else{
      throw Exception("Error");
    }
  }

  Future<List<dynamic>> getCountriesDataApi()async{

    final response=await http.get(Uri.parse(AppUrl.countriesUrl));
    var data=jsonDecode(response.body);
    if(response.statusCode==200){
      return data;
    }else{
      throw Exception("Error");
    }
  }

}
