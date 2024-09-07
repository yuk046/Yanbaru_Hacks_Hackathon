import 'package:flutter/material.dart';
import 'package:munimuniohagi/constant/constant.dart';

class AkinatorResultPage extends StatelessWidget {
  const AkinatorResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(Constant.mainBackGround),
      body: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
         children: [
         //ロゴの表示
          Container(
            width: screenSize.width * 0.8,
            child: Image.asset('assets/images/munimuni.png')
          ),
          SizedBox(
            height: screenSize.height * 0.08,
          ),
          //質問の表示 
          Text(
            "Q. 質問の表示",
            style: TextStyle(
              fontSize: 25,
            ),
          ),
          SizedBox(
            height: screenSize.height * 0.05,
          ),

          //選択肢を表示
          Row(
          mainAxisSize: MainAxisSize.min,
           children: [
            choices(screenSize: screenSize),
            choices(screenSize: screenSize),
           ],
          )
        ],),
      )
    );
  }
}

class choices extends StatelessWidget {
  const choices({
    super.key,
    required this.screenSize,
  });

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('動作の確認'),
              );
            });
        },
        child: Container(
          width: screenSize.width * 0.4,
          height: screenSize.width * 0.4,
          decoration: BoxDecoration(
            color: Color(0xffEFE3FF),
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment(0.0, 0.0),
          child: Text(
            "選択肢",
            style: TextStyle(
              fontSize: 15
            ),
          ),
        ),
      ),
    );
  }
}
