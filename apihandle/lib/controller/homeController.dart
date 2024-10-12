import 'dart:convert';

import 'package:apihandle/model/userModel.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  var userData = [].obs;



  //for json placeholder api calling with model
  Future getUsers() async {
    var baseUrl = 'https://jsonplaceholder.typicode.com/users';
    var url = Uri.parse(baseUrl);
    var response = await http.get(url);
    var responseBody = jsonDecode(response.body);

    for (var user in responseBody) {
      userData.add(UserModel.fromJson(user));
    }
    return userData;
  }

  //handling with crud crud.com
  getCrudUser() async {
    String baseURl =
        'https://crudcrud.com/api/9278735d5b7947e6957fe53df44ddf53/users';
    var url = Uri.parse(baseURl);
    var response = await http.get(url);
    var responseBody = jsonDecode(response.body);
    return responseBody;
  }

  postUser() {
    String baseURl =
        'https://crudcrud.com/api/9278735d5b7947e6957fe53df44ddf53/users';
    var url = Uri.parse(baseURl);
    var body = jsonEncode({'name': "Saad Ehsan", 'email': 'saad@gmail.com'});
    var header = {'Content-Type': 'application/json'};

    var response = http.post(url, body: body, headers: header);
    print(response);
    print("added");
    update();
  }


  updateUser(id) async {
    String baseURl =
        'https://crudcrud.com/api/9278735d5b7947e6957fe53df44ddf53/users/$id';
    var url = Uri.parse(baseURl);
    var body = jsonEncode({'name': "New Saad Ehsan", 'email': 'ehsan@gmail.com'});
    var header = {'Content-Type': 'application/json'};

    var response = await http.put(url, body: body, headers: header);
    print(response);
    print("Updated");
    update();
  }

  deleteUser(id) async {
    String baseURl =
        'https://crudcrud.com/api/9278735d5b7947e6957fe53df44ddf53/users/$id';
    var url = Uri.parse(baseURl);
    var response = await http.delete(url);
    print(response);
    print("deleted");
    update();
  }
}
