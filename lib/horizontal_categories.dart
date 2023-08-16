import 'package:flutter/material.dart';
import 'package:tute_me/details.dart';

class Horizontal_Categories extends StatelessWidget{
  final List child;

  const Horizontal_Categories({Key? key, required this.child}) : super(key: key);

  //Mycards({required this.child});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.all(5),
          width: MediaQuery.of(context).size.width*0.3,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white, boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 2)],),
          child: Column(
            children: [
              Spacer(),
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.black12,
                //backgroundImage: NetworkImage("https://www.pinclipart.com/picdir/middle/569-5697162_school-transparent-background-books-clipart-png-download.png"),
                backgroundImage: AssetImage('assets/iconbg.png'),
                child: IconButton(
                  icon: Icon(Icons.auto_stories_rounded),
                  color: Colors.black,
                  onPressed: () => Navigator.pushNamed(context,'books'),
                ),
              ),
              Text("𝘉𝘰𝘰𝘬𝘴"),
              Spacer(),
            ],
          ),
        ),
        SizedBox(width: MediaQuery.of(context).size.width*0.02),
      ],
    );
  }
}