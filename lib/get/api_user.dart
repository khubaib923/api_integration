import 'dart:convert';

import 'package:api_http/model/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  List<UserModel>userList=[];
  Future<List<UserModel>>getUserList()async{
    final response=await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    userList.clear();
    if(response.statusCode==200){
      var decodedData=jsonDecode(response.body);
      for(Map i in decodedData){
        userList.add(UserModel.fromJson(i));
      }
      return userList;
    }
    else{
      return userList;
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Api Course"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getUserList(),
        builder: (context,AsyncSnapshot<List<UserModel>> snapshot){
          if(!snapshot.hasData){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          else{
            return ListView.builder(
                itemCount: userList.length,
                itemBuilder: (context,index){
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ReusableRow(title: "Name", value: snapshot.requireData[index].name!),
                          const SizedBox(height: 5,),
                          ReusableRow(title: "username", value: snapshot.requireData[index].username!),
                          const SizedBox(height: 5,),
                          ReusableRow(title: "email", value: snapshot.requireData[index].email!),
                          const SizedBox(height: 5,),
                          ReusableRow(title: "Address", value: snapshot.requireData[index].address!.geo!.lat!),
                          const SizedBox(height: 5,),
                        ],
                      ),
                    ),
                  );
                }
            );
          }
        },
      ),

    );
  }

}

class ReusableRow extends StatelessWidget {
  final String title;
  final String value;
  const ReusableRow({Key? key,required this.title,required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,style: const TextStyle(fontWeight: FontWeight.bold),),
        Text(value,style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}

