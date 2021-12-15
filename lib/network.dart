import 'dart:convert';

import 'package:breaking_bad/breaking_bad_model.dart';
import 'package:http/http.dart';

class ApiNetwork {
  final String url = "https://breakingbadapi.com/api/characters";

  Future<List<BreakingBadApi>> breakingBadApi() async {
    final response = await get(Uri.parse(url));
    if (response.statusCode == 200) {
      return breakingBadApiFromJson(response.body);
    } else {
      throw {Exception("Failed to get data from $url")};
    }
  }
}
