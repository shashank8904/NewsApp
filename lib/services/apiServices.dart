import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news/models/userModel.dart';

class apiService{
  static const String _basUrl = 'https://jsonplaceholder.typicode.com';

  Future fetchUsers() async {
    final response = await http.get(Uri.parse("$_basUrl/users"));

    if(response.statusCode == 200){
     final data = json.decode(response.body);
     return data.map((json) => User.fromJson(json)).toList();
    }
    else{
      throw Exception("Failed to load Users");
    }

  }


}