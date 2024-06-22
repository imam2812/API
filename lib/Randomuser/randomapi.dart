import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'modal.dart';

class random extends StatefulWidget {
  const random({super.key});


  @override
  State<random> createState() => _randomState();
}

class _randomState extends State<random> {
  
  Future<List<Result>> fetch() async{
    var res = await http.get(Uri.parse("https://randomuser.me/api/"));
    var data = jsonDecode(res.body)["results"];
     return (data as List).map((obj) => Result.fromJson(obj)).toList();
  }
  
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FutureBuilder(
              future: fetch(),
              builder: (BuildContext context, snapshot){
                List<Result> list = snapshot.data!;
                if(snapshot.hasData){
                  return Container(
                    height: 800,
                    child: ListView.builder(
                      itemCount: list.length,
                        itemBuilder: (BuildContext context, int index){
                        return ListTile(
                          leading: Text(list[index].name!.title!.toString()),
                          title: Column(
                            children: [
                              Text(list[index].gender!.toString()),
                              Text(list[index].dob!.age!.toString()),
                              Text(list[index].dob!.date!.toString()),
                            ],
                          ),
                        );
                        }
                    ),
                  );
                }
                else if (snapshot.hasError){
                  return Text("${snapshot.error}");
                } return CircularProgressIndicator();
              }
          )
        ],
      ),
    );
  }
}
