import 'dart:convert';
import 'package:api/carts/singlecart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http ;
import 'modal.dart';

class car extends StatefulWidget {
  const car({super.key});

  @override
  State<car> createState() => _carState();
}

class _carState extends State<car> {
  
  Future<List<Carts>> fetch() async{
    var result = await http.get(Uri.parse("https://fakestoreapi.com/carts"));
    var time = jsonDecode(result.body);
    return (time as List).map((e) => Carts.fromJson(e)).toList();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FutureBuilder(
              future: fetch(),
              builder: (BuildContext Context , snapshot){
                if (snapshot.hasData){
                  List<Carts> list = snapshot.data!;
                  return Container(
                    height: 800,
                    child: ListView.builder(
                      itemCount: list.length,
                        itemBuilder: (Context , int index){
                        return GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> singlecar(id: list[index].id!)));
                          },
                          child: ListTile(
                            leading: Column(
                              children: [
                                Text(list[index].id.toString()),
                                Text(list[index].date.toString())
                              ],
                            ),
                            title: Column(
                              children: [
                                Text(list[index].iV.toString()),
                                Text(list[index].userId.toString()),
                                Text(list[index].products.toString()),
                              ],
                            ),
                          ),
                        );
                        }
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
