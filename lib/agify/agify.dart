import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http ;
import 'modl.dart';

class agif1 extends StatefulWidget {
  const agif1({super.key});

  @override
  State<agif1> createState() => _agif1State();
}

class _agif1State extends State<agif1> {
  
  Future<Agify> agify1() async{
    var result = await http.get(
      Uri.parse("https://api.agify.io?name=meelad"));
    return Agify.fromJson(jsonDecode(result.body));
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FutureBuilder(
              future: agify1(),
              builder: (BuildContext context , snapshot){
                if(snapshot.hasData){
                  return Column(
                    children: [
                      Text(snapshot.data!.name.toString()),
                      Text(snapshot.data!.count.toString()),
                      Text(snapshot.data!.age.toString()),
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
