import 'package:flutter/material.dart';
import 'package:tute_me/login.dart';
import 'package:tute_me/homepage.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyRegister extends StatefulWidget{
  const MyRegister({Key?key}):super(key:key);

  @override
  _MyRegisterState createState() =>_MyRegisterState();
}

class _MyRegisterState extends State<MyRegister>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        //decoration: BoxDecoration(
        //image: DecorationImage(
        //image: AssetImage('assets/loginresale.jpeg'),fit: BoxFit.fill)),
        child: Stack(
          children: [
            /*Container(
              margin: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.25, top:MediaQuery.of(context).size.height*0.13),
              child: SizedBox(
                width: MediaQuery.of(context).size.width*0.5,
                height: MediaQuery.of(context).size.height*0.12,
                child: SvgPicture.asset("assets/Re-Sale Logo.svg"),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.05,top:MediaQuery.of(context).size.height*0.3),
              child: Text('Sign Up',
                style: TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.05,top:MediaQuery.of(context).size.height*0.35),
              child: Text('Get started by filling the details below',
                style: TextStyle(color: Colors.grey.shade500,fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),*/
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                  //top: MediaQuery.of(context).size.height*0.3,
                    left: MediaQuery.of(context).size.width*0.05,
                    right: MediaQuery.of(context).size.width*0.05),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.08),
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width*0.6,
                          height: MediaQuery.of(context).size.height*0.12,
                          child: Center(child: Text("𝕋𝕦𝕥𝕖-𝕄𝔼", style: TextStyle(fontSize: 60, color: Color.fromARGB(232, 18, 241, 222)),))//SvgPicture.asset("assets/Re-Sale Logo.svg"),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                    Align(
                      alignment: Alignment.centerLeft,
                      //padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.05,top:MediaQuery.of(context).size.height*0.3),
                      child: Text('Sign Up',
                        style: TextStyle(color: Colors.black,fontSize: 22,fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                    Align(
                      alignment: Alignment.centerLeft,
                      //padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.05,top:MediaQuery.of(context).size.height*0.35),
                      child: Text('Get started by filling the details below',
                        style: TextStyle(color: Colors.grey.shade500,fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Name*',
                        style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                    TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                        fillColor: Colors.black12,
                        filled: true,
                        hintText: 'Enter full name',
                        hintStyle: TextStyle(fontSize: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Email*',
                        style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                    TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                        fillColor: Colors.black12,
                        filled: true,
                        hintText: 'Enter Edu Email',
                        hintStyle: TextStyle(fontSize: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.02),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Password*',
                        style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                    TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                        fillColor: Colors.black12,
                        filled: true,
                        hintText: 'Enter Password',
                        hintStyle: TextStyle(fontSize: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.02),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Confirm Password*',
                        style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                    TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                        fillColor: Colors.black12,
                        filled: true,
                        hintText: 'Confirm Password',
                        hintStyle: TextStyle(fontSize: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height:MediaQuery.of(context).size.height*0.02,),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: 120,
                            height: 40,
                            child: ElevatedButton(
                                onPressed: () => Navigator.push(context,MaterialPageRoute(builder: (context) => HomePage())),

                                style: ButtonStyle(
                                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                    backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(232, 18, 241, 222)),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(25.0),
                                            side: BorderSide(color: Color.fromARGB(232, 18, 241, 222))
                                        )
                                    )
                                ),
                                child: Text("Sign up", style: TextStyle(fontSize: 14),)
                            ),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Already have an account?", style: TextStyle(color: Colors.grey.shade500,fontSize: 15, fontWeight: FontWeight.bold),),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                    primary: Color.fromARGB(232, 18, 241, 222),
                                  ),
                                  onPressed: () => Navigator.push(context,MaterialPageRoute(builder: (context) => HomePage())),
                                  child: Text('Log In'),
                                ),
                              ]
                          ),
                        ]
                    )
                  ],

                ),
              ),
            )
          ],
          //child: floatingActionButton: FloatingActionButton(onPressed: none),
        ),
      ),
      floatingActionButton: FloatingActionButton(

        onPressed: () => Navigator.push(context,MaterialPageRoute(builder: (context) => MyLogin())),

        backgroundColor: Colors.black,
        child: const Icon(Icons.arrow_back),
      ),
    );
  }
}