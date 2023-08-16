import 'package:flutter/material.dart';
import 'package:tute_me/cards.dart';

class Cycles extends StatefulWidget {
  const Cycles({Key? key}) : super(key: key);

  @override
  _CyclesState createState() => _CyclesState();
}

class _CyclesState extends State<Cycles> {
  final List _posts = [
    ["Montra MadRock 3.0","In pristine condition","https://s3.ap-south-1.amazonaws.com/choosemybicycle/images/reviews/montra-madrock-27-5-2018.jpg","22,999","Anand","123456798"],
    ["Trek Speed","Rarely used","https://thecyclesportexperience.files.wordpress.com/2019/08/mes1.jpg","Rs.69,000"],
    ["FireFox Tarmak","Upgrading to new bike!!","https://s3.ap-south-1.amazonaws.com/choosemybicycle/images/reviews/firefox-tarmak.jpg","29,999","Anand","123456798"],
    ["Btwin","As good as new","https://coresites-cdn-adm.imgix.net/rcuk/wp-content/uploads/2016/03/01-IMG_5564.jpg?fit=crop","33,999","Anand","123456798"],
    ["Cosmic","Brand new out of the box used for 2 weeks, Leaving city so selling","https://m.media-amazon.com/images/I/61fWTAlCKmL._SX425_.jpg","33,000","Anand","123456798"],
    ["Hercules Roadeo A250","29 inch lightly used bike","https://rukminim1.flixcart.com/image/416/416/jm0wscw0/cycle/w/z/p/a250-26-disc-new-1fg325g0589000a-18-hercules-roadeo-original-imaf9ywyk3fthfdu.jpeg?q=70","14,999","Anand","123456798"],
    ["Hero sprint","PRO eclipse road bike for sale","https://m.media-amazon.com/images/I/81GNO7xmtlL._SX466_.jpg","25,000","Anand","123456798"],
    ["Cervelo","Too expensive for u to afford","https://images.immediate.co.uk/production/volatile/sites/21/2019/03/curve-belgie-disc-campagnolo-record-2-1533564775426-2wylv1a2xlaj-bfa6d18.jpg","76,000","Anand","123456798"],
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/loginresale.jpeg'), fit: BoxFit.fill)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: Builder(
            builder: (context) =>
                IconButton(
                  icon: Icon(Icons.menu, color: Colors.black,),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
          ),
          backgroundColor: Colors.transparent,
          /*leading: IconButton(
            icon: Icon(Icons.menu, color: Colors.black),
            onPressed: () => Navigator.pushNamed(context, 'login'),
          ),*/
          elevation: 0,
        ),
        drawer: Drawer(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/loginresale.jpeg'),fit: BoxFit.fill)),
            child: ListView(
              children: [
                SizedBox(height: 90,),
                //DrawerHeader(child: Text(""),/*child: Center(child: Text("LOGO",style: TextStyle(fontSize: 30,),)),*/),
                ListTile(
                  leading: Icon(Icons.book_rounded, color: Colors.black,),
                  title: Text("𝘉𝘰𝘰𝘬𝘴",style: TextStyle(fontSize: 20),),
                  onTap: () => Navigator.pushNamed(context,'books'),
                ),
                ListTile(
                  leading: Icon(Icons.directions_bike_rounded, color: Colors.black,),
                  title: Text("𝘉𝘪𝘬𝘦𝘴/𝘊𝘺𝘤𝘭𝘦𝘴",style: TextStyle(fontSize: 20),),
                  onTap: () => Navigator.pushNamed(context,'cycles'),
                ),
                ListTile(
                  leading: Icon(Icons.bookmark, color: Colors.black,),
                  title: Text("𝘏𝘰𝘮𝘦𝘸𝘰𝘳𝘬",style: TextStyle(fontSize: 20),),
                  onTap: () => Navigator.pushNamed(context,'login'),
                ),
                ListTile(
                  leading: Icon(Icons.calculate_rounded, color: Colors.black,),
                  title: Text("𝘊𝘢𝘭𝘤𝘶𝘭𝘢𝘵𝘰𝘳𝘴",style: TextStyle(fontSize: 20),),
                  onTap: () => Navigator.pushNamed(context,'login'),
                ),
                ListTile(
                  leading: Icon(Icons.arrow_back_ios_new, color: Colors.black,),
                  title: Text("𝘓𝘰𝘨𝘪𝘯",style: TextStyle(fontSize: 20),),
                  onTap: () => Navigator.pushNamed(context,'login'),
                ),
              ],
            ),
          ),
        ),
        body: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.width*0.1,
              ),
              Container(
                color: Colors.white30,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 25,

                    child: Text("Cycles", style: TextStyle( fontSize: 20),textAlign: TextAlign.left,),
                  ),
                ),
              ),
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
      ),
    );
  }
}