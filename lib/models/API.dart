import 'dart:convert';

import 'package:http/http.dart' as http;

const baseUrl = 'http://10.0.2.2:4000/graphql?query=';

class API {
  static Future postQuery(String apiUri, String query) {
    Map<String, String> requestHeaders = {'Content-type': 'application/json'};
    final encodedQuery = jsonEncode({"query": query});
    return http.post(apiUri, body: encodedQuery, headers: requestHeaders);
  }

  static Future getUsers() {
    //var url = baseUrl + "{users{id,firstName,lastName,email}}";
    //   return http.get(baseUrl +
    //       '{users{firstName,lastName,email,_id,experience,total_donated,medals{name,description,asset_key}}}');
  }

  static Future getUserWeekReciepts(String user_id) {
    // get the week reciepts for the user.
  }
}
