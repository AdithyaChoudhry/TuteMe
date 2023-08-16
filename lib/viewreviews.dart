import 'dart:async';
import 'dart:math';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tute_me/favourites.dart';
import 'package:tute_me/map.dart';
import 'package:tute_me/favourites_expanded.dart';
import 'package:tute_me/listingnew.dart';
import 'package:tute_me/profile.dart';
import 'package:tute_me/student_register.dart';

class MyReview extends StatefulWidget {
  final id;
  const MyReview({Key? key, required this.id}) : super(key: key);

  @override
  _MyReviewState createState() => _MyReviewState();
}

class _MyReviewState extends State<MyReview>{
  final _database = FirebaseDatabase.instance.reference();
  dynamic _data;
  final _categories = [];
  late StreamSubscription _dataStream;

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  Future<List> _get_reviews() async{
    _dataStream = _database.child('Reviews/${widget.id}/userReviews').onValue.listen((event) {
      //getmarkers();
      final dynamic _data = event.snapshot.value;
        _data.forEach((k, v) {
          print(_categories);
            if (_categories.contains([k, v]) == false) {
              _categories.add([k, v]);
            }
      });
    });
    return _categories;
  }

  Widget projectWidget() {
    return FutureBuilder(
      builder: (context, projectSnap) {
        if (projectSnap.connectionState == ConnectionState.none &&
            projectSnap.hasData == null) {
          //print('project snapshot data is: ${projectSnap.data}');
          return  Center(
            // render the loading indicator
            child: CircularProgressIndicator(),);
        }
        return ListView.builder(
          itemCount: projectSnap.data!.length,
          itemBuilder: (context, index) {
            return Container(
              height: 120,
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10),
                color: Color.fromARGB(
                    91, 39, 211, 241),
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                      child: Text(projectSnap.data![index][0].toString(), style: TextStyle(fontSize: 20),)),
                  Divider(thickness: 1,),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text(projectSnap.data![index][1].toString())),
                ],
              ),
            );
          },
        );
      },
      future: _get_reviews(),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text("Reviews", style: TextStyle(fontSize: 30, color: Color.fromARGB(
            225, 39, 211, 241),),),
        centerTitle: true,
        leading: Builder(builder: (context) =>
            IconButton(
              icon: Icon(Icons.arrow_back_ios_rounded, color: Color.fromARGB(
                  225, 39, 211, 241),),
              onPressed: () {
                Navigator.pop(context);
              },
            ),

        ),
      ),
      body: projectWidget(),
      bottomNavigationBar: BottomAppBar(
        color: Colors.tealAccent,
        child: Container(
          margin: EdgeInsets.only(bottom: 5),
          decoration: BoxDecoration(
            gradient: new LinearGradient(
              colors: [
                const Color(0xFF00E1FF),
                const Color(0xFF00FFEA),
              ],
            ),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Stack(
            children: [
              Row(
                children: [
                  Spacer(),
                  IconButton(
                    onPressed: () {
                    },
                    hoverColor: Colors.black,
                    color: Colors.white,
                    highlightColor: Colors.black12,
                    tooltip: "Home",
                    icon: Icon(Icons.home_rounded),
                    iconSize: 35,
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Map())),
                    hoverColor: Colors.black,
                    color: Colors.white,
                    highlightColor: Colors.black12,
                    tooltip: "Locate",
                    icon: Icon(Icons.location_on_outlined,),
                    iconSize: 35,
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MyProfile())),
                    hoverColor: Colors.black,
                    color: Colors.white,
                    highlightColor: Colors.black12,
                    tooltip: "Account",
                    icon: Icon(Icons.person_outline_rounded,),
                    iconSize: 35,
                  ),
                  Spacer(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
