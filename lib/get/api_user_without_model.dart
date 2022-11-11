import 'dart:convert';

import 'package:api_http/get/api_user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserScreenWithoutModel extends StatefulWidget {
  const UserScreenWithoutModel({Key? key}) : super(key: key);

  @override
  State<UserScreenWithoutModel> createState() => _UserScreenWithoutModelState();
}

class _UserScreenWithoutModelState extends State<UserScreenWithoutModel> {
  List<UsersModel>userData=[];
  Future<List<UsersModel>>getUsersData()async{
    final response=await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    userData.clear();
    if(response.statusCode==200){
      var decodedData=jsonDecode(response.body);
      for(Map i in decodedData){
        userData.add(UsersModel(name: i["name"], userName:i["username"], email: i["email"], longitute:i["address"]["geo"]["lng"]));
      }
      return userData;
    }
    else{
      return userData;
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
        future: getUsersData(),
        builder: (context,AsyncSnapshot<List<UsersModel>> snapshot){
          if(!snapshot.hasData){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          else{
            return ListView.builder(
                itemCount: userData.length,
                itemBuilder:(context,index){
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ReusableRow(title: "Name", value: snapshot.requireData[index].name),
                          const SizedBox(height: 5,),
                          ReusableRow(title: "username", value: snapshot.requireData[index].userName),
                          const SizedBox(height: 5,),
                          ReusableRow(title: "email", value: snapshot.requireData[index].email),
                          const SizedBox(height: 5,),
                          ReusableRow(title: "Address", value: snapshot.requireData[index].longitute),
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

class UsersModel{
  String name;
  String userName;
  String email;
  String longitute;
  UsersModel({required this.name,required this.userName,required this.email,required this.longitute});
}