import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'getlistmodal.dart';

class getlistapi extends StatefulWidget {
  const getlistapi({super.key});

  @override
  State<getlistapi> createState() => _getlistapiState();
}

class _getlistapiState extends State<getlistapi> {
  Future<List<Data>> fetchdata() async {
    var res = await http.get(Uri.parse(
        "https://datausa.io/api/data?drilldowns=Nation&measures=Population"));
    var data = jsonDecode(res.body)["data"];
    return (data as List).map((obj) => Data.fromJson(obj)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FutureBuilder(
              future: fetchdata(),
              builder: (BuildContext context, snapshot) {
                if (snapshot.hasData) {
                  List<Data> list = snapshot.data!;
                  return Container(
                    height: 800,
                    child: ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (context, int index) {
                          return ListTile(
                            leading: Text(list[index].year.toString()),
                            title: Column(
                              children: [
                                Text(list[index].population.toString()),
                                Text(list[index].iDNation.toString()),
                              ],
                            ),
                          );
                        }),
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return CircularProgressIndicator();
              })
        ],
      ),
    );
  }
}
