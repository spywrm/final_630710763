import 'dart:convert';
import 'dart:html';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'CONTRY.dart';

const apiBaseUrl = 'http://103.74.252.66:8888/vote';

class Newhomepage extends StatefulWidget {
  const Newhomepage({Key? key}) : super(key: key);

  @override
  State<Newhomepage> createState() => _NewhomepageState();
}

class _NewhomepageState extends State<Newhomepage> {
  List<Country>? list = [];

  @override
  void initState() {
    runapi();
    super.initState();
  }

  void runapi() async {
    var response = await http.get(Uri.parse(apiBaseUrl));
    var output = jsonDecode(response.body);
    print(response.body);
    output['data'].forEach((item) {
      dynamic group = item['group'];
      dynamic team = item['team'];
      dynamic flagImage = item['flagImage'];
      dynamic id = item['id'];
      dynamic voteCount = item['voteCount'];
      var c = new Country(
          id: id,
          team: team,
          group: group,
          flagImage: flagImage,
          voteCount: voteCount);
      setState(() {
        list!.add(c);
      });
    });
  }

  Widget Mybox(int index) {
    return Container(
      alignment: Alignment.center,
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black45,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 70,
                    height: 90,
                    color: Colors.blueGrey,
                  ),
                ),
                Text("${list![index].team}",style: TextStyle(fontSize: 17)),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("${list![index].voteCount}"),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: list!.length,
        itemBuilder: (context, index) {
          return Mybox(index);
        },
      ),
    );
  }
}
