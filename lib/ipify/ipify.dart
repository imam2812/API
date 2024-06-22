import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'modal.dart';

class ipi extends StatefulWidget {
  const ipi({super.key});

  @override
  State<ipi> createState() => _ipiState();
}

class _ipiState extends State<ipi> {
  
  Future<Ipify> ipify1() async{
    var result = await http.get(
      Uri.parse("https://api.ipify.org?format=json"));
    return (Ipify.fromJson(jsonDecode(result.body)));
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FutureBuilder(
              future: ipify1(), 
              builder: (BuildContext context , snapshot){
                if (snapshot.hasData){
                  return Column(
                    children: [
                      Text(snapshot.data!.ip.toString())
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
