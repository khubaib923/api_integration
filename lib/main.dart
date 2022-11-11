import 'package:api_http/get/api_photo.dart';
import 'package:api_http/get/api_product.dart';
import 'package:api_http/get/api_user.dart';
import 'package:api_http/get/api_user_without_model.dart';
import 'package:api_http/post/api_image_upload.dart';
import 'package:api_http/post/api_sigin.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: ImageUploadScreen()
    );
  }
}

