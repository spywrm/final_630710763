
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

const apiBaseUrl = 'https://cpsu-test-api.herokuapp.com';
const apiGetFoods = '$apiBaseUrl/foods';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  void a()async{
    var response = await http.get(Uri.parse(apiGetFoods));
    var output = jsonDecode(response.body);
    print(response.statusCode);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(onPressed: a, child: Text("ss")),
    );
  }
}
