import 'dart:convert';
import 'package:basic_api_riverpod/data/model/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

class NetworkCaller {
  static String endPoint = 'https://reqres.in/api/users?page=2';

  Future<List<UserModel>> getData() async {
    Response response = await get(Uri.parse(endPoint));
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['data'];
      return result.map((e) => UserModel.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
final userProvider = Provider<NetworkCaller>((ref)=>NetworkCaller());