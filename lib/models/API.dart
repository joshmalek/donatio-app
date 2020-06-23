import 'package:http/http.dart' as http;

const baseUrl =
    'http://10.0.2.2:4000/graphql?query={users{firstName,lastName,email,_id,experience,total_donated,medals{name,description,img_url}}}';

class API {
  static Future getUsers() {
    print(baseUrl);
    //var url = baseUrl + "{users{id,firstName,lastName,email}}";
    return http.get(baseUrl);
  }
}
