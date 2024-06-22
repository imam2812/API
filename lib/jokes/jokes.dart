import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'modal.dart';

class joke1 extends StatefulWidget {
  const joke1({super.key});

  @override
  State<joke1> createState() => _joke1State();
}

class _joke1State extends State<joke1> {

  Future<Jokes> joke() async{
    var result = await http.get(
      Uri.parse("https://official-joke-api.appspot.com/random_joke"));
    return
      Jokes.fromJson(jsonDecode(result.body));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FutureBuilder(
              future: joke(),
              builder: (BuildContext context , snapshot ){
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Text(snapshot.data!.type.toString()),
                      Text(snapshot.data!.setup.toString()),
                      Text(snapshot.data!.punchline.toString()),
                      Text(snapshot.data!.type.toString()),
                    ],
                  );
                } if (snapshot.hasError){
                  return Text("${snapshot.error}");
                } return CircularProgressIndicator();
              }
          )
        ],
      ),
    );
  }
}
