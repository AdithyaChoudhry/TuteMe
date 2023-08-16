import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tute_me/profile.dart';
import 'package:tute_me/map.dart';
import 'package:tute_me/review.dart';
import 'package:tute_me/viewreviews.dart';


class Details extends StatefulWidget {
  final child;
  final id;
  const Details({Key? key, required this.child, this.id}) : super(key: key);

  @override
  DetailsState createState() => DetailsState();
}

class DetailsState extends State<Details> {
  PageController? pageViewController;


  Widget buildClassChip() {
    List<Widget> buttons = [];
    widget.child['classes'].forEach((k, v){
      print(k);
      Card ClassChip = Card(
        color: Colors.white70,
        elevation: 5,
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(k),
        ),);
      buttons.add(ClassChip);
      buttons.add(SizedBox(width: MediaQuery.of(context).size.width*0.01,));
    });
    return ListView(
      scrollDirection: Axis.horizontal,
      children: buttons,
    );
  }

  Widget buildSubjectChip() {
    List<Widget> buttons = [];
    widget.child['subjects'].forEach((k, v){
      print(k);
      Card SubjectChip = Card(
        color: Colors.white70,
        elevation: 5,
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(k),
        ),);
      buttons.add(SubjectChip);
      buttons.add(SizedBox(width: MediaQuery.of(context).size.width*0.01,));
    });
    return ListView(
      scrollDirection: Axis.horizontal,
      children: buttons,
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(
          232, 18, 215, 241),
      appBar: AppBar(
        title: Text(widget.child['first_name']+" "+widget.child['last_name'],style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),),
        leading: Builder(
          builder: (context) =>
              IconButton(
                icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.white,),
                onPressed: () => Navigator.pop(context),
              ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                padding: EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height*0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(-0.7, 0),
                          child: Container(
                            height: MediaQuery.of(context).size.height*0.4,
                            width: MediaQuery.of(context).size.width*0.90,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color: Colors.transparent,
                            ),
                            child: Stack(
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                                  child: PageView(
                                    controller: pageViewController ??=
                                        PageController(initialPage: 0),
                                    scrollDirection: Axis.horizontal,
                                    children:[
                                      Image.asset(
                                        'assets/gajju.jpg',
                                        fit: BoxFit.fill,
                                      ),
                                      Image.asset(
                                        'assets/gajju.jpg',
                                        fit: BoxFit.fill,
                                      ),
                                      Image.asset(
                                        'assets/gajju.jpg',
                                        fit: BoxFit.fill,
                                      ),
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional(0, 1),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                    child: SmoothPageIndicator(
                                      controller: pageViewController ??=
                                          PageController(initialPage: 0),
                                      count: 3,
                                      axisDirection: Axis.horizontal,
                                      onDotClicked: (i) {
                                        pageViewController!.animateToPage(
                                          i,
                                          duration: Duration(milliseconds: 500),
                                          curve: Curves.ease,
                                        );
                                      },
                                      effect: ExpandingDotsEffect(
                                        expansionFactor: 2,
                                        spacing: 8,
                                        radius: 8,
                                        dotWidth: 8,
                                        dotHeight: 8,
                                        dotColor: Color(0xFF9E9E9E),
                                        activeDotColor: Color(0xFF3F51B5),
                                        paintStyle: PaintingStyle.fill,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                        Align(
                          alignment: Alignment.centerLeft,
                          //padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.05,top:MediaQuery.of(context).size.height*0.3),
                          child: Text(widget.child['first_name']+" "+widget.child['last_name'],
                            style: TextStyle(color: Colors.black,fontSize: 26,fontWeight: FontWeight.bold),
                          ),
                        ),
                        Divider(
                          thickness: 1,
                          color: Colors.black,
                        ),
                        Row(
                          children: [
                            RatingBarIndicator(
                              rating: 5,
                              itemBuilder: (context, index) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              itemCount: 5,
                              itemSize: 20.0,
                              direction: Axis.horizontal,
                            ),
                            Text("  |"),
                            TextButton(
                                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MyReview(id: widget.id))),
                                child: Text("Reviews", style: TextStyle(fontStyle: FontStyle.italic, color: Color.fromARGB(
                                    225, 39, 211, 241),),)),
                            Spacer(),
                            IconButton(
                                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Review(child: widget.child,id: widget.id,))),
                                icon: Icon(Icons.rate_review_rounded)
                            ),
                          ],
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Classes",
                            style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                        Container(
                          height: MediaQuery.of(context).size.height*0.05,
                          child: buildClassChip(),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Subjects",
                            style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                        Container(
                          height: MediaQuery.of(context).size.height*0.05,
                          child: buildSubjectChip(),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Mode",
                            style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                        widget.child['mode'].length == 2?
                        Text(widget.child['mode']['online'].toString()+", "+widget.child['mode']['offline'].toString(),
                          style: TextStyle(fontSize: 14,),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ):widget.child['mode']['online'] != null?
                        Text(widget.child['mode']['online'].toString(),
                          style: TextStyle(fontSize: 14,),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ):
                        Text(widget.child['mode']['offline'].toString(),
                          style: TextStyle(fontSize: 14,),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Divider(
                          thickness: 1,
                          color: Colors.black,
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text("type",
                            style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                        widget.child['type'].length == 2?
                        Text(widget.child['type']['individual'].toString()+", "+widget.child['type']['group'].toString(),
                          style: TextStyle(fontSize: 14,),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ):widget.child['type']['individual'] != null?
                        Text(widget.child['type']['individual'].toString(),
                          style: TextStyle(fontSize: 14,),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ):
                        Text(widget.child['type']['group'].toString(),
                          style: TextStyle(fontSize: 14,),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Divider(
                          thickness: 1,
                          color: Colors.black,
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Fee",
                            style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                        Text("${widget.child['fee']}",
                          style: TextStyle(fontSize: 14,),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Divider(
                          thickness: 1,
                          color: Colors.black,
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text("About Myself",
                            style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                        Container(
                          height: MediaQuery.of(context).size.height*0.1,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black,),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: Text(widget.child['about'],
                              style: TextStyle(fontSize: 14,),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height*0.1,),
                      ],
                    ),
                  ),
                ),
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
