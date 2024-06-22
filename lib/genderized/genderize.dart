import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'modal.dart';

class gender extends StatefulWidget {
  const gender({super.key});

  @override
  State<gender> createState() => _genderState();
}

class _genderState extends State<gender> {
  
  Future<Genderized> gend() async {
    var result = await http.get(
      Uri.parse("https://api.genderize.io?name=luc"));
    return Genderized.fromJson(jsonDecode(result.body));
  }
  
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FutureBuilder(
              future: gend(),
              builder:(BuildContext context , snapshot){
                if (snapshot.hasData){
                  return Column(
                    children: [
                      Text(snapshot.data!.count.toString()),
                      Text(snapshot.data!.name.toString()),
                      Text(snapshot.data!.gender.toString()),
                      Text(snapshot.data!.probability.toString()),
                    ],
                  );
                } else if(snapshot.hasError){
                  return Text("${snapshot.error}");
                }  return CircularProgressIndicator();
              }
          )
        ],
      ),
    );
  }
}
