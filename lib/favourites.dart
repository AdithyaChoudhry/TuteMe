import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tute_me/details.dart';
import 'package:firebase_database/firebase_database.dart';

class MyFavourites extends StatefulWidget{
  final child;

  const MyFavourites({Key? key, required this.child}) : super(key: key);

  @override
  State<MyFavourites> createState() => _MyFavouritesState();
}

class _MyFavouritesState extends State<MyFavourites> {
  final _database = FirebaseDatabase.instance.reference();


  Future<dynamic> _get_details() async {
    dynamic _data = await _database.child('Teachers/${widget.child}').get();
    print(_data.value);
    return _data;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _get_details();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _get_details(),
        builder: (BuildContext ctx, AsyncSnapshot<dynamic> snapshot) =>
        snapshot.hasData
            ? Column(
          children: [
            Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.175,
              child: MaterialButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => Details(child: snapshot.data.value, id: widget.child)));
                },
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(color: Colors.black12,
                          blurRadius: 10,
                          spreadRadius: 2)
                    ],
                    color: Color.fromARGB(
                        91, 39, 211, 241),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: MediaQuery
                              .of(context)
                              .size
                              .height,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            image: DecorationImage(
                              image: AssetImage("assets/gajju.jpg"),
                              //NetworkImage(child[2]),
                              fit: BoxFit.fill,
                            ),
                            color: Colors.transparent,
                          ),
                        ),
                      ),
                      Container(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.35,
                                      child: Text(
                                        snapshot.data.value['first_name'] + " " +
                                            snapshot.data.value['last_name'],
                                        style: TextStyle(fontSize: 20,),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    SizedBox(height: MediaQuery.of(context).size.height * 0.005,),
                                    Row(
                                      children: [
                                        RatingBarIndicator(
                                          rating: snapshot.data.value['rating'].toDouble(),
                                          itemBuilder: (context, index) =>
                                              Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                          itemCount: 5,
                                          itemSize: 15.0,
                                          direction: Axis.horizontal,
                                        ),
                                        Text("/ 300 reviews",
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false,
                                          style: TextStyle(fontSize: 10,),),
                                      ],
                                    ),
                                    SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.5,
                                      child: Text(snapshot.data.value['about'].toString(),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                        style: TextStyle(fontSize: 12,),),
                                    ),
                                    SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.5,
                                      child: Text("Rs. "+snapshot.data.value['fee'].toString(),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                        style: TextStyle(fontSize: 15,),),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  height: 150,
                ),
              ),
            ),
          ],
        )
            : const Center(
          // render the loading indicator
          child: CircularProgressIndicator(),)
    );
  }
}
