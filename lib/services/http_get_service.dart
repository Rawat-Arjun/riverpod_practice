import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:riverpod_practice/modal/comments_modal.dart';

class HttpGetComments {
  static const url = 'https://jsonplaceholder.typicode.com/albums';
  Future<List<Comments>> getComments() async {
    List<Comments> commmentsList = [];
    try {
      final uriParse = Uri.parse(url);
      final res = await http.get(uriParse);
      if (res.statusCode == 200) {
        final resBody = jsonDecode(res.body);
        for (var element in resBody) {
          Comments e = Comments.fromMap(element);
          commmentsList.add(e);
        }
      }
    } catch (e) {
      log(e.toString());
    }
    return commmentsList;
  }
}
