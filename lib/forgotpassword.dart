import 'package:flutter/material.dart';
import 'package:tute_me/login.dart';
import 'package:tute_me/resetpassword.dart';

class ForgotPassword extends StatefulWidget{
  const ForgotPassword({Key?key}):super(key:key);

  @override
  _ForgotPasswordState createState() =>_ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword>{
  @override
  Widget build(BuildContext context){
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/loginresale.jpeg'),fit: BoxFit.fill)),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          elevation: 0,
        ),
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            /*Container(
              padding: EdgeInsets.only(top: 50,left:150,),
              CircleAvatar(
                //padding: EdgeInsets.only(top: 50,left:150,),
                radius: 40,
                backgroundColor: Colors.transparent,
                backgroundImage: NetworkImage("https://library.kissclipart.com/20181217/vbe/kissclipart-recycled-icon-vector-clipart-recycling-symbol-376f83bf8521c3ee.png"),
                child: IconButton(
                  onPressed: (){},
                  icon: Icon(null),
                ),
              ),
            ),*/
            Container(

              padding: EdgeInsets.only(left:35,top:140),
              child: Text('𝐅𝐨𝐫𝐠𝐨𝐭 𝐏𝐚𝐬𝐬𝐰𝐨𝐫𝐝',
                style: TextStyle(color: Colors.black,fontSize: 30,),
              ),
            ),

            Container(

              padding: EdgeInsets.only(left:35,top:150),
              /*child: Text('Sign-Up',
                style: TextStyle(color: Colors.black,fontFamily: "Font2",fontSize: 30,),
              ),*/
            ),

            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height*0.25,
                    left: 35,
                    right: 35),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        hintText: 'E-mail',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        hintText: 'OTP',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    /*TextField(
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        hintText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),*/
                    //SizedBox(height:30,),
                    SizedBox(height:10,),

                    /*Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(

                            padding: EdgeInsets.only(top:10),
                            child: Text('Or',
                              style: TextStyle(color: Colors.black,fontSize: 20),
                            ),
                          ),
                          SizedBox(height:10,),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Colors.transparent,
                                  backgroundImage: NetworkImage(
                                      "https://www.freepnglogos.com/uploads/google-logo-png/google-logo-png-suite-everything-you-need-know-about-google-newest-0.png"
                                  ),
                                  child: IconButton(
                                    onPressed: (){},
                                    icon: Icon(null),
                                  ),
                                ),

                                CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Colors.transparent,
                                  backgroundImage: NetworkImage(
                                      "https://www.freepnglogos.com/uploads/facebook-logo-13.png"
                                  ),
                                  child: IconButton(
                                    onPressed: (){},
                                    icon: const Icon(null),
                                  ),
                                ),
                              ]
                          ),
                          SizedBox(height: 20),
                        ]
                    )*/
                  ],

                ),

              ),

            )

          ],

          //child: floatingActionButton: FloatingActionButton(onPressed: none),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context,'resetpassword'),
          backgroundColor: Colors.black,
          child: const Icon(Icons.arrow_forward),
        ),
      ),
    );
  }
}