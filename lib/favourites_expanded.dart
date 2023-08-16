import 'dart:math';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tute_me/favourites.dart';
import 'package:tute_me/filters.dart';
import 'package:tute_me/map.dart';
import 'package:tute_me/favourites_expanded.dart';
import 'package:tute_me/listingnew.dart';
import 'package:tute_me/profile.dart';
import 'package:tute_me/student_register.dart';

class Favourites_Expanded extends StatefulWidget {
  const Favourites_Expanded({Key? key}) : super(key: key);

  @override
  _Favourites_ExpandedState createState() => _Favourites_ExpandedState();
}

class _Favourites_ExpandedState extends State<Favourites_Expanded> {
  final List _categories = [];
  final _database = FirebaseDatabase.instance.reference();
  dynamic _data;

  @override
  void initState(){
    super.initState();
    _activeListners();
    _get_Teachers_ID();
  }
  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    _get_Teachers_ID();
  }

  void _activeListners(){
    _database.child('Teachers_ID').onValue.listen((event) {
      _get_Teachers_ID();
      //print(teacher);
    });
  }

  void _get_Teachers_ID() async {
    _data = await _database.child('Teachers_ID').get();
    if (_data.exists) {
      _data.value.forEach((k, v) {
        print(k);
        if (_categories.contains(v) == false){
          setState(() {
            _categories.add(v);
          });

          //print(_categories);
        }
      });
    } else {
      print('No data available.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("All teachers", style: TextStyle(fontSize: 25, color: Color.fromARGB(
            225, 39, 211, 241),),),
        leading: Builder(
          builder: (context) =>
              IconButton(
                icon: Icon(Icons.arrow_back_ios_rounded, color:Color.fromARGB(
                    225, 39, 211, 241),),
                onPressed: () => Navigator.pop(context),
              ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height*0.02,),
            Row(
              children: [
                Spacer(),
                Container(
                  height: MediaQuery.of(context).size.height*0.06,
                  width: MediaQuery.of(context).size.width*0.7,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Color.fromARGB(
                      91, 39, 211, 241),),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Icon(Icons.search_rounded),
                      ),
                      Text("Search", style: TextStyle(color: Colors.black, fontSize: 20),),
                    ],
                  ),
                ),
                Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(
                      225, 39, 211, 241), shadowColor: Colors.transparent,foregroundColor: Colors.black),
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Filters())),
                  child: Row(
                    children: [
                      Text("Filters  "),
                      Icon(Icons.file_copy_rounded, size: 15,),
                    ],
                  ),
                ),
                Spacer(),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.005,),
            Expanded(
              child: ListView.builder(
                  itemCount: _categories.length,
                  physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  itemBuilder: (context, index){
                    return MyFavourites(child: _categories[index]);
                  }
              ),
            ),
          ],
        ),
      ),
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