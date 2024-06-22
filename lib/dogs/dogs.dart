import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http ;

import 'modal.dart';

class dog extends StatefulWidget {
  const dog({super.key});

  @override
  State<dog> createState() => _dogState();
}

class _dogState extends State<dog> {
  
  Future<Dogs> dog1() async {
    var result = await http.get(
      Uri.parse("https://dog.ceo/api/breeds/image/random"));
    return Dogs.fromJson(jsonDecode(result.body));
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FutureBuilder(
              future: dog1(),
              builder: (BuildContext context , snapshot){
                if (snapshot.hasData){
                  return Column(
                    children: [
                      Center(
                        child: Container(
                          height: 300,
                          width: 300,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(snapshot.data!.message!)
                            )
                          ),
                        ),
                      ),
                      Text(snapshot.data!.status.toString()),
                    ],
                  );
                } else if (snapshot.hasError){
                  return Text("${snapshot.error}");
                } return CircularProgressIndicator();
              }
          )
        ],
      ),
    );
  }
}
