import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class post2 extends StatefulWidget {
  const post2({super.key});

  @override
  State<post2> createState() => _post2State();
}

class _post2State extends State<post2> {

  Future<bool> ? _success ;
  
  Future <bool>  adcat(String dogname , String desc) async {
    var result = await http.post(Uri.parse("http://catodotest.elevadosoftwares.com/Category/InsertCategory"),
    headers: <String,String> {
      'Content-Type ' : 'application/json; charset=utf-8'
        },
        body: jsonEncode(<String,dynamic>{
          "categoryId": 0,
          "category": dogname,
          "description": desc,
          "createdBy": 1
        }
        )
    );
    return jsonDecode(result.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
          //  child: (_success == null ? buildColumn() : buildFuturebuilder()),
          )
        ],
      ),
    );
  }



}
