import 'dart:convert';

import 'package:http/http.dart' as http;

var sportslink =
    'https://opentdb.com/api.php?amount=20&category=21&type=multiple';
var computerScience = "https://opentdb.com/api.php?amount=20&category=18";

var history = "https://opentdb.com/api.php?amount=20&category=23";

getQuizData() async {
  var res = await http.get(Uri.parse(sportslink));
  if (res.statusCode == 200) {
    var data = jsonDecode(res.body.toString());
    return data;
  }
}
