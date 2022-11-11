import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PhotoScreen extends StatefulWidget {
  const PhotoScreen({Key? key}) : super(key: key);

  @override
  State<PhotoScreen> createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
    List<PhotoModel>photoList=[];

Future<List<PhotoModel>>getPhotoData() async{
  final response=await http.get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
  // print(response.statusCode);
  var decodedData=jsonDecode(response.body);
  if(response.statusCode==200){
    photoList.clear();
    // print(decodedData);
    for(Map i in decodedData) {
      PhotoModel photoModel=PhotoModel(id: i['id'], title: i['title'], photoUrl: i['url']);
      photoList.add(photoModel);
      // photoData.add(PhotoModel(id: i["id"], title: i["title"], photoUrl: i["url"]));
    }
      return photoList;
  }
  else{
    return photoList;
  }
}
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getPhotoData(),
        builder: (context,AsyncSnapshot<List<PhotoModel>> snapshot){
          if(!snapshot.hasData){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          else{
            return ListView.builder(
                itemCount: photoList.length,
                itemBuilder: (context,index){
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text("Notes id:${snapshot.requireData[index].id}"),
                        subtitle: Text(snapshot.requireData[index].title),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(snapshot.requireData[index].photoUrl),
                        ),
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

class PhotoModel{
  int id;
  String title;
  String photoUrl;
  PhotoModel({required this.id,required this.title,required this.photoUrl});
}
