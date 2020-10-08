import 'package:http/http.dart' as http;
import 'package:isanja/Class/CategoryClass.dart';
import 'package:isanja/Class/WordClass.dart';
import 'dart:async';
import 'dart:convert';
import 'package:isanja/global.dart' as global;

class WordService {
  static Future<int> postWord(String word, double points, int categoryId ) async {
    String url = global.host + "/api/Words";
    try {
      final response = await http.post(url,
          headers: {'content-type': 'application/json'},
          body: jsonEncode({
            'word': '$word',
            'categoryID': categoryId,
            'points': points,
           
          }));
      if (response.statusCode == 200) {
        //  print(response.body);

        int resp = getResponse(response.body);
        return resp;
      } else {
       // throw Exception("Error");
      }
    } catch (e) {
     // throw Exception(e.toString());
    }
  }


 

   static Future<int> postToken(String token, int profileId
       ) async {


    String url = global.host+"/api/Tokens";
    try {
     
      final response = await http.post(url,
          headers: {'content-type': 'application/json'},
          body: jsonEncode({
            'token': token,
            'profileID': '$profileId',
            
            
          }));
      if (response.statusCode == 200) {
        //  print(response.body);

        int resp =0;
        return resp;
      } else {
      //  throw Exception("Error");
      }
    } catch (e) {
     // throw Exception(e.toString());
    }
  }
   static Future<List <WordClass>> getAllWords() async {
    String url = global.host +
        "/api/Words" ;
    try {
      final response =
          await http.get(url, headers: {'content-type': 'application/json'});
      if (response.statusCode == 200) {
        // print(response.body);

      List< WordClass> list = parse(response.body);
        return list;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static int getResponse(String responseBody) {
    int data;
    data = json.decode(responseBody)["id"];
    return data;
  }

  static List<WordClass> parse(String responseBody) {
   
    final profileClass = wordClassFromJson(responseBody);
    return profileClass;
    //tring' is not a subtype of type 'Map<String, dynamic>'"
  }
}
