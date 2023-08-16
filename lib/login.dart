import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tute_me/register.dart';
import 'package:tute_me/homepage.dart';
import 'package:tute_me/teacherprofile.dart';
String dropdownvalue = 'Teacher';
var items = [
  'Teacher',
  'student'
];
class newvalue {
  static const String FirstItem = 'Teacher';
  static const String SecondItem = 'Student';


  static const List<String> choices = <String>[
    FirstItem,
    SecondItem,

  ];
}

void choiceAction(String choice) {
  if (choice == newvalue.FirstItem) {



  } else if (choice == newvalue.SecondItem) {

  }
}
class MyLogin extends StatefulWidget{
  const MyLogin({Key?key}): super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
                          child: Center(child: Text("𝕋𝕦𝕥𝕖-𝕄𝔼", style: TextStyle(fontSize: 60, color: Color.fromARGB(
                              232, 18, 215, 241),),))//SvgPicture.asset("assets/Re-Sale Logo.svg"),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                    Align(
                      alignment: Alignment.centerLeft,
                      //padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.05,top:MediaQuery.of(context).size.height*0.3),
                      child: Text('Log In',
                        style: TextStyle(color: Colors.black,fontSize: 22,fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                    Align(
                      alignment: Alignment.centerLeft,
                      //padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.05,top:MediaQuery.of(context).size.height*0.35),
                      child: Text('Welcome back, Log In to continue',
                        style: TextStyle(color: Colors.grey.shade500,fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Email',
                        style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                    TextField(
                      decoration: InputDecoration(
                        fillColor: Colors.black12,
                        filled: true,
                        hintText: 'Email-ID',
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
                      child: Text('Password',
                        style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                    TextField(
                      decoration: InputDecoration(
                        fillColor: Colors.black12,
                        filled: true,
                        hintText: 'Password',
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
                            child:  ElevatedButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                                minimumSize: MaterialStateProperty.all(Size(20, 20)),
                                backgroundColor:
                                MaterialStateProperty.all(Color.fromARGB(
                                    232, 18, 215, 241),),
                                // elevation: MaterialStateProperty.all(3),
                                shadowColor:
                                MaterialStateProperty.all(Color.fromARGB(
                                    232, 18, 215, 241),),
                              ), //Elevated Button Background
                              onPressed: (){

                                if (dropdownvalue == "Teacher"){

                                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyProfile2()));
                                }
                                else {
                                  Navigator.push(context,MaterialPageRoute(builder: (context) => HomePage(child: "Student",)));
                                }
                              }, //make onPressed callback empty
                              child:DropdownButton(
                                style: TextStyle(color: Colors.white), //Dropdown font color
                                dropdownColor: Color.fromARGB(
                                    232, 18, 215, 241), //dropdown menu background color
                                icon: Icon(Icons.arrow_forward_ios_sharp, color:Colors.white), //dropdown indicator icon
                                underline: Container(), //make underline empty
                                value: dropdownvalue,
                                onChanged: (value){
                                  setState(() {
                                    dropdownvalue = value.toString();
                                  });
                                },
                                items: items.map((itemone){
                                  return DropdownMenuItem(
                                      value: itemone,
                                      child: Text(itemone)
                                  );
                                }).toList(),
                              ),

                            ),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Don't have an account?", style: TextStyle(color: Colors.grey.shade500,fontSize: 15, fontWeight: FontWeight.bold),),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                    primary: Color.fromARGB(232, 18, 241, 222),
                                  ),
                                  onPressed: () => Navigator.push(context,MaterialPageRoute(builder: (context) => const MyRegister())),
                                  child: Text('Sign Up', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
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

        onPressed: () => Navigator.push(context,MaterialPageRoute(builder: (context) => HomePage(child: "Student",))),

        backgroundColor: Color.fromARGB(
            232, 18, 215, 241),
        child: const Icon(Icons.house_rounded),
      ),
    );
  }
}

