import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class ResultPage extends StatelessWidget {
  const ResultPage({Key? key, required this.name, required this.result})
      : super(key: key);
  final String name;
  final int result;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Result page"),
        ),
        body: SizedBox(
          height: MediaQuery
              .of(context)
              .size
              .height,
          width: MediaQuery
              .of(context)
              .size
              .width,
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomLeft,
                    colors: [Colors.white70, Colors.lightBlue.shade800])
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("$name", style: GoogleFonts.poppins(
                fontSize: 20,
                color: Colors.blue
              ),),
              SizedBox(height: MediaQuery.of(context).size.height/3,),
              Text("Score in quize is: $result", style:GoogleFonts.poppins(
                fontSize:25,
                color: Colors.green,
                fontWeight:FontWeight.w500
              ))
            ],
          ),
        ),

      ),
      ),
    );
  }
}
