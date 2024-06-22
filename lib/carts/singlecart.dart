import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'modal.dart';

class singlecar extends StatefulWidget {
  final int id;
  const singlecar({super.key, required this.id});

  @override
  State<singlecar> createState() => _singlecarState();
}

class _singlecarState extends State<singlecar> {
  
  Future<Carts> fetch() async{
    var id = widget.id;
    var result = await http.get(Uri.parse("https://fakestoreapi.com/carts/$id"));
    return Carts.fromJson(jsonDecode(result.body));
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FutureBuilder(
              future: fetch(),
              builder: (BuildContext Context , snapshot){
                if(snapshot.hasData){
                  return ListTile(
                    leading: Column(
                      children: [
                        Text(snapshot.data!.id.toString()),
                        Text(snapshot.data!.date.toString()),
                      ],
                    ),
                    title: Column(
                      children: [
                        Text(snapshot.data!.iV.toString()),
                        Text(snapshot.data!.userId.toString()),
                        Text(snapshot.data!.products.toString()),
                      ],
                    ),
                  );
                } else if(snapshot.hasError){
                  return Text("${snapshot.error}");
                } return CircularProgressIndicator();
              }
              )
        ],
      ),
    );
  }
}
