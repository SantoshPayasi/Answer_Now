import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizzer_app/Result_Page.dart';

import 'Models/questions.dart';
import 'Styles/styles.dart';

class HomeScreen extends StatefulWidget {
  final String name;

  const HomeScreen({Key? key, required this.name}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomePageState();
}

class _HomePageState extends State<HomeScreen> {
  int QuestionNo = 0;
  int score = 0;
  bool isnotcompleted = true;

  List<Widget> WidgetBar = [];

  @override
  void checkAnswer(submittedAns) {
    print(submittedAns);
    if (submittedAns == Question[QuestionNo]["answer"]) {
      // print(score);
      setState(() {
        score += 1;
        WidgetBar.add(TrueTag());
        if (QuestionNo == Question.length - 1) {
          QuestionNo = 0;
          isnotcompleted = false;
          return;
        } else {
          QuestionNo += 1;
          if (kDebugMode) {
            print("question no is $QuestionNo");
            print("Score is $score");
          }
        }
      });
    } else {
      setState(() {
        WidgetBar.add(FalseTag());
        if (QuestionNo == Question.length - 1) {
          QuestionNo = 0;
          isnotcompleted = false;
          return;
        } else {
          QuestionNo += 1;
          if (kDebugMode) {
            print("question no is $QuestionNo");
            print("Score is $score");
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String name = widget.name;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Quiz app",
      home: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(gradient: Styles.g1),
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(bottom: 10, top: 50),
                height: MediaQuery.of(context).size.height / 1.5,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hello, $name",
                        style: GoogleFonts.lato(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.lightBlue)),
                    Container(
                        margin: const EdgeInsets.only(top: 10),
                        height: MediaQuery.of(context).size.height - 320,
                        alignment: Alignment.center,
                        child: Text(
                          "Q.No${QuestionNo + 1} : ${Question[QuestionNo]["question"]}",
                          style: GoogleFonts.openSans(
                              fontSize: 20,
                              letterSpacing: 2,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ))
                  ],
                ),
              ),
              Expanded(
                child: SizedBox(
                    child: isnotcompleted
                        ? Column(
                            children: [
                              Container(
                                  margin: const EdgeInsets.only(
                                      left: 10, right: 10, bottom: 10),
                                  width: MediaQuery.of(context).size.width,
                                  height: 50,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.green),
                                      onPressed: () {
                                        if (isnotcompleted) {
                                          checkAnswer(true);
                                        }
                                      },
                                      child: const Text("True"))),
                              Container(
                                  height: 50,
                                  margin:
                                      const EdgeInsets.only(left: 10, right: 10),
                                  width: MediaQuery.of(context).size.width,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red),
                                      onPressed: () {
                                        if (isnotcompleted) {
                                          checkAnswer(false);
                                        }
                                      },
                                      child: const Text("False"))),
                            ],
                          )
                        : Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 90,
                              padding: EdgeInsets.all(20),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red),
                                  onPressed: () async {
                                    await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ResultPage(
                                                name: name, result: score)));
                                    setState(() {
                                      isnotcompleted = true;
                                      WidgetBar.clear();
                                    });
                                  },
                                  child: Text(
                                    "See results",
                                    style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ),
                          )),
              ),
              SizedBox(
                height: 15,
                child: Row(
                  children: WidgetBar,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TrueTag extends StatelessWidget {
  const TrueTag({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
          height: 15,
          width: 15,
          child: const Icon(Icons.check_box_outlined, color: Colors.green,),
          ),
      const SizedBox(
        width: 10,
      )
    ]);
  }
}

class FalseTag extends StatelessWidget {
  const FalseTag({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(height: 15, width: 15, child:Icon(Icons.disabled_by_default_outlined, color:Colors.red)),
      SizedBox(
        width: 10,
      )
    ]);
  }
}
