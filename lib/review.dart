import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Review extends StatefulWidget {
  final id;
  final child;
  const Review({Key? key,required this.child, this.id}) : super(key: key);

  @override
  State<Review> createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  TextEditingController _ratingController=TextEditingController();
  double rating=0;
  double rating1=0;
  double rating2=0;
  double rating3=0;
  double rating4=0;
  final _database = FirebaseDatabase.instance.reference();

  void add_review() async{
    _database.child('Reviews/${widget.id}/userReviews').update({
      "user3":_ratingController.text,
    });
  }

  void _onLoading() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          backgroundColor: Colors.white,
          title: Center(child: Text("Loading",style: TextStyle(fontSize: 30,color: Colors.lightBlue),)),
          actions: <Widget>[
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                  CircularProgressIndicator(),
                  SizedBox(height: MediaQuery.of(context).size.height*0.05,)
                ],
              ),
            ),
          ],
        );
      },
    );
    new Future.delayed(new Duration(seconds: 3), () {
      Navigator.pop(context); //pop dialog
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Feedback for: "+widget.child["first_name"]+" "+widget.child["last_name"],
          style: TextStyle(fontSize: 24, color: Color.fromARGB(
              225, 39, 211, 241), fontWeight: FontWeight.bold),),
        leading: Builder(
          builder: (context) =>
              IconButton(
                icon: Icon(Icons.arrow_back_ios_rounded, color: Color.fromARGB(
                    225, 39, 211, 241),),
                onPressed: () => Navigator.pop(context),
              ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                //padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.05,top:MediaQuery.of(context).size.height*0.3),
                child: Text("Teacher Communication",
                  style: TextStyle(color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              //SizedBox(height: MediaQuery.of(context).size.height*0.02,),
              RatingBar.builder(
                  initialRating: 5,
                  minRating:1 ,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 20,
                  itemPadding: EdgeInsets.all(8.0),
                  updateOnDrag: true,
                  itemBuilder: (context,_)=>
                      Icon(Icons.star,color: Color.fromARGB(
                          225, 39, 211, 241),),onRatingUpdate:(rating)=>setState(() {
                this.rating1=rating; })
              ),
              //Text('Your Rating: $rating1', style: TextStyle(fontSize: 20),),
              SizedBox(height: MediaQuery.of(context).size.height*0.005),
              Align(
                alignment: Alignment.centerLeft,
                //padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.05,top:MediaQuery.of(context).size.height*0.3),
                child: Text("Punctuality",
                  style: TextStyle(color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              RatingBar.builder(
                  initialRating: 5,
                  minRating:1 ,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 20,
                  itemPadding: EdgeInsets.all(8.0),
                  updateOnDrag: true,
                  itemBuilder: (context,_)=>
                      Icon(Icons.star,color: Color.fromARGB(
                          225, 39, 211, 241),),onRatingUpdate:(rating)=>setState(() {
                this.rating2=rating; })
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.005),
              Align(
                alignment: Alignment.centerLeft,
                //padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.05,top:MediaQuery.of(context).size.height*0.3),
                child: Text("Doubt Session",
                  style: TextStyle(color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              RatingBar.builder(
                  initialRating: 5,
                  minRating:1 ,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 20,
                  itemPadding: EdgeInsets.all(8.0),
                  updateOnDrag: true,
                  itemBuilder: (context,_)=>
                      Icon(Icons.star,color: Color.fromARGB(
                          225, 39, 211, 241),),onRatingUpdate:(rating)=>setState(() {
                this.rating3=rating; })
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.005),
              Align(
                alignment: Alignment.centerLeft,
                //padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.05,top:MediaQuery.of(context).size.height*0.3),
                child: Text("Delivery of structured lecture",
                  style: TextStyle(color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              RatingBar.builder(
                  initialRating: 5,
                  minRating:1 ,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 20,
                  itemPadding: EdgeInsets.all(8.0),
                  updateOnDrag: true,
                  itemBuilder: (context,_)=>
                      Icon(Icons.star,color: Color.fromARGB(
                          225, 39, 211, 241),),onRatingUpdate:(rating)=>setState(() {
                this.rating4=rating; })
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.005),
              Align(
                alignment: Alignment.centerLeft,
                //padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.05,top:MediaQuery.of(context).size.height*0.3),
                child: Text("Choose your Overall rating",
                  style: TextStyle(color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              RatingBar.builder(
                  initialRating: 5,
                  minRating:1 ,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 20,
                  itemPadding: EdgeInsets.all(8.0),
                  updateOnDrag: true,
                  itemBuilder: (context,_)=>
                      Icon(Icons.star,color: Color.fromARGB(
                          225, 39, 211, 241),),onRatingUpdate:(rating)=>setState(() {
                this.rating=rating; })
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.005),
              Align(
                alignment: Alignment.centerLeft,
                //padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.05,top:MediaQuery.of(context).size.height*0.3),
                child: Text("Write your review",
                  style: TextStyle(color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              //SizedBox(height: MediaQuery.of(context).size.height*0.02,),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Write your review here",
                    hintStyle: TextStyle(fontSize: 14),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color.fromARGB(
                          225, 39, 211, 241),),
                    ),
                  ),
                  style: TextStyle(fontSize: 14,),
                  maxLines: 3,
                  controller: _ratingController,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
              SizedBox(
                width: 120,
                height: 40,
                child: ElevatedButton(
                    onPressed: () {
                      add_review();
                      _onLoading();
                      _ratingController.clear();
                      Future.delayed(Duration(seconds: 3), ()
                      {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) =>
                              AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(8.0))),
                                title: Icon(
                                  Icons.check_circle, size: MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.125,
                                  color: Color.fromARGB(
                                      225, 39, 211, 241),
                                  shadows: [BoxShadow(
                                    color: Colors.black38,
                                    spreadRadius: 1,
                                    blurRadius: 10,
                                    offset: Offset(0, 4),
                                  )
                                  ],
                                ),
                                actions: <Widget>[
                                  Column(
                                    children: [
                                      Text('Rating Added Successfully !',
                                        style: TextStyle(fontSize: 16,
                                            fontWeight: FontWeight
                                                .bold),
                                        textAlign: TextAlign.center,),
                                      Row(
                                        children: [
                                          Spacer(),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text("Click here",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: 'poppins',
                                                  color: Color.fromARGB(
                                                      225, 39, 211, 241),),)
                                          ),
                                          Text("to continue",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'poppins'),),
                                          Spacer(),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                        );
                      });
                    },
                    style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(
                            225, 39, 211, 241),),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                side: BorderSide(color: Color.fromARGB(
                                    225, 39, 211, 241),)
                            )
                        )
                    ),
                    child: Text("Rate", style: TextStyle(fontSize: 14, color: Colors.white),)
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


