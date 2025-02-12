import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class postapi extends StatefulWidget {
  const postapi({super.key});
  @override
  State<postapi> createState() => _postapiState();
}

class _postapiState extends State<postapi> {

  TextEditingController name = TextEditingController();
  TextEditingController desc = TextEditingController();

  Future<bool>? _success;

 Future<bool> addcat(String catname, String des) async {
   var res = await http.post(
     Uri.parse("http://catodotest.elevadosoftwares.com/Category/InsertCategory"),
     headers: <String,String>{
       'Content-Type':'application/json; charset=utf-8'
     },
     body: jsonEncode(<String,dynamic>{
       "categoryId": 0,
       "category": catname,
       "description": des,
       "createdBy": 1
     }
     )
   );
    return jsonDecode(res.body)["success"];
 }

  @override
  Widget build(BuildContext context)

  {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: (_success == null ? buildColumn() : buildFuturebuilder()),
          )
        ],
      ),
    );
  }

  Column buildColumn(){
   return Column(
     children: [
       TextFormField(
         controller:name ,
         decoration: InputDecoration(
           label: Text("name")
         ),
       ),
       TextFormField(
         controller: desc,
         decoration: InputDecoration(
             label: Text("des")
         ),
       ),
       ElevatedButton(onPressed: (){
         setState(() {
           _success = addcat(name.text, desc.text);
         });
       },
           child: Text("save"))
     ],
   );
  }

  FutureBuilder buildFuturebuilder(){
   return FutureBuilder(
       future: _success,
       builder: (BuildContext context, snapshot){
         if(snapshot.hasData){
           return Text("added successfully");
         } else if(snapshot.hasError){
           return Text("${snapshot.error}");
         } return CircularProgressIndicator();
       }
   );
  }
}
