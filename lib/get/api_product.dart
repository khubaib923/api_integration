import 'dart:convert';

import 'package:api_http/model/ProductModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {

  Future<ProductModel?>getProductData() async{
    final response=await http.get(Uri.parse("https://webhook.site/11d16af8-4c74-4690-923a-086b1b38f6af"));
    if(response.statusCode==200){
      var decodedData=jsonDecode(response.body);
      return ProductModel.fromJson(decodedData);
    }
    else{
      return null;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Api course"),
        centerTitle: true,
      ),
      body: FutureBuilder<ProductModel?>(
        future: getProductData(),
        builder: (context,snapshot){
          if(!snapshot.hasData){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          else{
            return ListView.builder(
                itemCount: snapshot.requireData!.data!.length,
                itemBuilder: (context,index){
                  return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.requireData!.data![index].products!.length,
                      itemBuilder: (context,indexx){
                       return ListView.builder(
                         physics: const NeverScrollableScrollPhysics(),
                         shrinkWrap: true,
                         itemCount: snapshot.requireData!.data![index].products![indexx].images!.length,
                           itemBuilder:(context,position){
                           return ListTile(
                             title: Text(snapshot.requireData!.data![index].name.toString()),
                             subtitle: Text(snapshot.requireData!.data![index].products![indexx].title.toString()),
                             leading: CircleAvatar(
                               backgroundImage: NetworkImage(snapshot.requireData!.data![index].products![indexx].images![position].url!),
                             ),
                           );

                           }
                       );
                      }
                  );

                }
            );
          }
        },
      ),
    );
  }
}
