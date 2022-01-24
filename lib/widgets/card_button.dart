import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_task/pages/user/user_page.dart';

class CardButton extends StatelessWidget {
  CardButton(
      {Key? key, required this.prefix, required this.text, required this.subtext, required this.onTap})
      : super(key: key);

  Widget prefix;
  String text;
  String subtext;
  Function onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
          margin: EdgeInsets.only(top: 10, left: 10, right: 10),
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          child: Row(
            children: [
            prefix,
            SizedBox(width: 30),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                   Text(text,
                        style:
                            TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                          SizedBox(height: 20),
                  
                   Text(subtext,
                        style:
                            TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
                  
                ],
              ),
            ),
            IconButton(icon: Icon(Icons.person), onPressed: (){
              onTap();
            },)
          ]),
    );
  }
}
