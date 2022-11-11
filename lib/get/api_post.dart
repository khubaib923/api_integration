import 'dart:convert';

import 'package:api_http/model/PostModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 List<PostModel>postData=[];

 Future<List<PostModel>>getPostData()async{
   var response=await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
   if(response.statusCode==200){
     postData.clear();
     var decodedData=jsonDecode(response.body);
     for(Map i in decodedData){
       postData.add(PostModel.fromJson(i));
     }
     return postData;
   }
   else{
    return postData;
   }
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: getPostData(),
          builder: (context,AsyncSnapshot<List<PostModel>>snapshot){
            if(!snapshot.hasData){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            else{
              return ListView.builder(
                  itemCount: postData.length,
                  itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.all(5),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                               Text(index.toString()),
                              const Text("Title",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                              const SizedBox(height: 5,),
                              Text(snapshot.requireData[index].title!),
                              const SizedBox(height: 10,),
                              const Text("Description",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                              const SizedBox(height: 5,),
                              Text(snapshot.requireData[index].body!),

                            ],
                          ),
                        ),
                      ),
                    );
                  }
              );
            }

          }
      ),
    );
  }
}
