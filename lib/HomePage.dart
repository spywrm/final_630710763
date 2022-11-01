import 'dart:convert';
import 'dart:html';
import 'dart:io';
import 'dart:ui';

import 'package:final_630710763/CONTRY.dart';
import 'package:final_630710763/NewPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const apiBaseUrl = 'http://103.74.252.66:8888';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Country>? list = [];
  var Item = 0;
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

  @override
  void initState() {
    runapi();
    super.initState();
  }

  Widget MyBox(index) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black45,
            width: 3,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 80,
                      width: 100,
                      color: Colors.blueGrey,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(list![index].team),
                      Text("GROUP ${list![index].group}"),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: (){
                        final url = Uri.parse('http://103.74.252.66:8888/vote');
                        http.post(url, body: {'id': list![index].voteCount});
                      },
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          width: 90,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            border: Border.all(
                              color: Colors.black45,
                              width: 3,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text("VOTE",style: TextStyle(fontSize: 15)),
                        ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    height: 250,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      border: Border.all(
                        color: Colors.black45,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Stack(
              children: [
                ListView.builder(
                  itemCount: list!.length,
                  itemBuilder: (context, index) {
                    return MyBox(index);
                  },
                ),
                Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: (){
                            final url = Uri.parse('http://103.74.252.66:8888/vote');
                            http.post(url, body: {'id': list![0].id});
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => Newhomepage()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              alignment: Alignment.center,
                              height: 60,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.blueGrey,
                                border: Border.all(
                                  color: Colors.black45,
                                  width: 3,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text("VIEW RESULT",style: TextStyle(fontSize: 17)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],

            ),
          ),
        ],
      ),
    );
  }
}
