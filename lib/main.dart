import 'package:flutter/material.dart';
import 'Styles/styles.dart';
import 'HomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiz app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({Key? key}) : super(key: key);
  final _key = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body:Container(
        decoration: BoxDecoration(
          gradient: Styles.g1
        ),
        child: Container(
          padding: EdgeInsets.all(10),
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: _key,
                  child: Column(
                children: [
                  TextFormField(
                    controller: _name ,
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Please enter write name';
                      }
                     RegExp regx = RegExp(r'^[a-zA-Z ]+$');
                     bool valid = regx.hasMatch(value);
                     if(valid){
                       return null;
                     }
                     else{
                       return "please Enter right name";
                     }
                    },
                    decoration: InputDecoration(
                      labelText: "Enter name",
                      labelStyle: TextStyle(color: Colors.blue),
                      hintText: " e.g santosh",
                      hintStyle: TextStyle(
                        color: Colors.grey.shade400
                      ),
                      filled: true,
                      fillColor:Colors.white ,
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueAccent)
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.cyanAccent)
                      )
                    ),
                    
                  ),
                  ElevatedButton(
                    style:ElevatedButton.styleFrom(
                      elevation: 0.5,
                    )
                  ,onPressed: (){
                    if(_key.currentState!.validate()){
                      String name = _name.text;
                      _name.clear();
                      FocusScope.of(context).unfocus();
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen(name: name)));
                    }
                  }, child: Text('Submit'))
                ],
              ))
            ],
          )
        ),
      )
    );
  }
}



