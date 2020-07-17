import 'dart:convert';

import 'package:http/http.dart' as http;

const baseUrl = 'https://3.130.4.139/graphql?query=';

class API {
  static Future postQuery(String apiUri, String query) {
    Map<String, String> requestHeaders = {'Content-type': 'application/json'};
    final encodedQuery = jsonEncode({"query": query});
    return http.post(apiUri, body: encodedQuery, headers: requestHeaders);
  }

  static Future getUsers() {
    String getUsersQuery =
        "{ users { firstName, lastName, email, experience, medals, total_donated, _id } }";
    return API.postQuery(baseUrl, getUsersQuery);
  }

  static Future fetchLeaderboard(int offset, int limit) {
    String leaderboardQuery =
        "{ leaderboard(offset:${offset},limit:${limit}){lastName,firstName,_id,email,experience,total_donated} }";
    return API.postQuery(baseUrl, leaderboardQuery);
  }

  static Future getUserWeekReceipts(String user_id) {
    // get the week reciepts for the user.
    String weekReceiptsQuery =
        "{ weekReceipts(user_id:\"${user_id}\") {npo_id, amount, user_id, date_time} }";
    return API.postQuery(baseUrl, weekReceiptsQuery);
  }

  static Future getLockedMedals(String user_id) {
    String lockedMedalsQuery = """{userLockedMedals(_id:"${user_id}") {
    name, description, alt_description, asset_key, date_awarded
  }}""";
    return API.postQuery(baseUrl, lockedMedalsQuery);
  }

  static Future getUser(String user_id) {
    String userQuery =
        "{ user(_id: \"${user_id}\") { firstName, lastName, email, experience, medals, total_donated, _id, medals { name, description, alt_description, asset_key, date_awarded } } }";
    return API.postQuery(baseUrl, userQuery);
  }
}
