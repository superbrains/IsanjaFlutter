import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:isanja/global.dart' as global;

class RegistrationService {
  static Future<int> postProfile(String fullname, ) async {
    String url = global.host + "/api/Registers";
    try {
      final response = await http.post(url,
          headers: {'content-type': 'application/json'},
          body: jsonEncode({
            'name': '$fullname',
           
           
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

  static int getResponse(String responseBody) {
    int data;
    data = json.decode(responseBody)["id"];
    return data;
  }

  // static ProfileClass parse(String responseBody) {
   
  //   final profileClass = profileClassFromJson(responseBody);
  //   return profileClass;
  // }
}
