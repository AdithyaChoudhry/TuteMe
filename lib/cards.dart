import 'package:flutter/material.dart';
import 'package:tute_me/details.dart';

class MyCards extends StatelessWidget{
  final List child;

  const MyCards({Key? key, required this.child}) : super(key: key);

  //Mycards({required this.child});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => Details(child: child)));
      },
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 1)],
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width*0.3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    image: DecorationImage(
                      image: NetworkImage(child[2]),
                      fit: BoxFit.fill,
                    ),
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width:MediaQuery.of(context).size.width*0.35,
                            child: Text(child[0],
                              style: TextStyle(fontSize: 20,),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                          SizedBox(
                            height: 70,
                            width:MediaQuery.of(context).size.width*0.5,
                            child: Text(child[1],
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              style: TextStyle(fontSize: 13,),),
                          ),

                          SizedBox(
                            width:200,
                            child: Text("Price: Rs."+child[3],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 18, color: Colors.pink),),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          height: 150,
        ),
      );
  }
}