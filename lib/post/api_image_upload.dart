import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ImageUploadScreen extends StatefulWidget {
  const ImageUploadScreen({Key? key}) : super(key: key);

  @override
  State<ImageUploadScreen> createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  File? pickedImage;
  bool loading=false;

  Future<void>pickerImages()async{
   XFile? picked = await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 30);
   if(picked!=null){
    setState(() {
      pickedImage=File(picked.path);
    });
   }
   else{
     if(kDebugMode){
       print("image is not picking");
     }
   }
  }

  Future<void>uploadImages()async{
    setState(() {
      loading=true;
    });
    var stream=http.ByteStream(pickedImage!.openRead());
    stream.cast();
    var length=await pickedImage!.length();
    var uri=Uri.parse("https://fakestoreapi.com/products");
    var request=http.MultipartRequest("POST",uri);
    request.fields["title"]="khubaib";
    var multiPort=http.MultipartFile(
      "image",
       stream,
       length
    );
    request.files.add(multiPort);

    var response=await request.send();
    if(response.statusCode==200){
      setState(() {
        loading=false;
      });
      if(kDebugMode){
        print("image uploaded");
      }
      else{
        setState(() {
          loading=false;
        });
        if(kDebugMode){
          print("not uploaded");
        }
      }
    }


    
    
  }
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: loading,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Upload Images"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 120),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              pickedImage==null?GestureDetector(
                  onTap: (){
                    pickerImages();

                  },
                  child: const Text("Picked Image")):
            SizedBox(
              height: 100,
              width: 100,
              child:Image.file(pickedImage!,fit: BoxFit.cover,) ,),
              const SizedBox(height: 60,),
              pickedImage==null?ElevatedButton(onPressed: (){},style:ElevatedButton.styleFrom(primary: Colors.grey) , child: const Text("uploads"),):ElevatedButton(onPressed: (){

              }, child: GestureDetector(
                  onTap: (){
                    uploadImages();

                  },
                  child: const Text("Upload")))



            ],
          ),
        ),
      ),
    );
  }
}
