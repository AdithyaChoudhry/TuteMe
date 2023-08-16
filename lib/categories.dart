import 'package:flutter/material.dart';
import 'package:tute_me/details.dart';

class MyCategories extends StatelessWidget{
  final List child;

  const MyCategories({Key? key, required this.child}) : super(key: key);

  //Mycards({required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MaterialButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Details(child: child)));
          },
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              /*image: DecorationImage(
                  image: NetworkImage("https://images.unsplash.com/photo-1503455637927-730bce8583c0?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxjb2xsZWN0aW9uLXBhZ2V8M3w4NzU1OTYwfHxlbnwwfHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=60"),
                  fit: BoxFit.fill,
                ),*/
              color: Colors.black12,
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
                        image: AssetImage(child[0]),//NetworkImage(child[2]),
                        fit: BoxFit.fill,
                      ),
                      color: Colors.transparent,
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
                              child: Text(child[1],
                                style: TextStyle(fontSize: 20,),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                            SizedBox(
                              height: 70,
                              width:MediaQuery.of(context).size.width*0.5,
                              child: Text(child[2],
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                style: TextStyle(fontSize: 13,),),
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
        ),
        MaterialButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Details(child: child)));
          },
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              /*image: DecorationImage(
                  image: NetworkImage("https://images.unsplash.com/photo-1503455637927-730bce8583c0?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxjb2xsZWN0aW9uLXBhZ2V8M3w4NzU1OTYwfHxlbnwwfHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=60"),
                  fit: BoxFit.fill,
                ),*/
              color: Colors.black12,
            ),
            child: Row(
              children: [
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
                              child: Text(child[4],
                                style: TextStyle(fontSize: 20,),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                            SizedBox(
                              height: 70,
                              width:MediaQuery.of(context).size.width*0.5,
                              child: Text(child[5],
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                style: TextStyle(fontSize: 13,),),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 150,
                    width: MediaQuery.of(context).size.width*0.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      image: DecorationImage(
                        image: AssetImage(child[3]),//NetworkImage(child[2]),
                        fit: BoxFit.fill,
                      ),
                      color: Colors.transparent,
                    ),
                  ),
                ),
              ],
            ),
            height: 150,
          ),
        ),
      ],
    );
  }
}