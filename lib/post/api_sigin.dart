import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  
  void createAccount(String email,String password)async{
    final response=await http.post(Uri.parse("https://reqres.in/api/login"),body: {
      "email":email,
      "password":password
    });
    if(response.statusCode==200){
      var data=jsonDecode(response.body);
      print(data["token"]);
    }
    else{
      print("something went wrong");
    }
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Retailo"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
            ),
            const SizedBox(height: 20,),
            TextField(
              controller: passwordController,
            ),
            const SizedBox(height: 20,),
            ElevatedButton(onPressed: (){
              createAccount(emailController.text.trim(), passwordController.text.trim());
            }, child: const Text("Create Account"))
          ],
        ),
      ),
    );
  }
}
