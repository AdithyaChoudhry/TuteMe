
import 'package:flutter/material.dart';
import 'package:tute_me/cards.dart';
import 'package:tute_me/homepage.dart';
import 'package:tute_me/profile.dart';
import 'package:tute_me/listingnew.dart';

class Books extends StatefulWidget {
  const Books({Key? key}) : super(key: key);

  @override
  _BooksState createState() => _BooksState();
}

class _BooksState extends State<Books> {
  final List _posts = [
    ["Kaichou wa Maid-Sama!","For Sale!!","https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1342630688l/15758313.jpg","300","Anand","123456798"],
    ["Da Vinci Code","Dan Brown","https://m.media-amazon.com/images/I/5171w-4D2FL.jpg","500","Anand","123456798"],
    ["IKIGAI","Japanese","https://images-na.ssl-images-amazon.com/images/I/81l3rZK4lnL.jpg","400","Anand","123456798"],
    ["Harry Potter and The Chamber of Secrets","JK Rowling","https://images-na.ssl-images-amazon.com/images/I/91HHqVTAJQL.jpg","700","Anand","123456798"],
    ["Rich Dad, Poor Dad","Robert T Kiyosaki","https://images-na.ssl-images-amazon.com/images/I/81bsw6fnUiL.jpg","1000","Anand","123456798"],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Text Books", style: TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),),
        leading: Builder(
          builder: (context) =>
              IconButton(
                icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.black,),
                onPressed: () => Navigator.pop(context),
              ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: _posts.length,
                  physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  itemBuilder: (context, index){
                    return MyCards(child: _posts[index]);
                  }
              ),

            ),
          ]
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.redAccent,
        child: Container(
          margin: EdgeInsets.only(bottom: 5),
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.transparent,
          ),
          child: Stack(
            children: [
              Row(
                children: [
                  Spacer(),
                  IconButton(
                    onPressed: () {},
                    hoverColor: Colors.black,
                    color: Colors.white,
                    highlightColor: Colors.black12,
                    tooltip: "Cart",
                    icon: Icon(Icons.shopping_bag_rounded),
                    iconSize: 35,
                  ),
                  Spacer(),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Listing()));
                      },
                    hoverColor: Colors.black,
                    color: Colors.white,
                    highlightColor: Colors.black12,
                    tooltip: "Sell",
                    icon: Icon(Icons.turned_in_not_rounded,),
                    iconSize: 35,
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {},
                    hoverColor: Colors.black,
                    color: Colors.white,
                    highlightColor: Colors.black12,
                    tooltip: "Chat",
                    icon: Icon(Icons.textsms_outlined,),
                    iconSize: 35,
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MyProfile()));
                    },
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