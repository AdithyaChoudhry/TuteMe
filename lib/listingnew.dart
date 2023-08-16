import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:tute_me/map.dart';
import 'package:tute_me/profile.dart';
import 'package:geocoder/geocoder.dart';
import 'package:flutter/services.dart';
import 'package:validators/validators.dart';

class Listing extends StatefulWidget {
  const Listing({Key? key}) : super(key: key);

  @override
  _ListingState createState() => _ListingState();
}

class _ListingState extends State<Listing> {

  final _database = FirebaseDatabase.instance.reference();
  final _formKey = GlobalKey<FormState>();
  bool _showTypeButtons = false;
  bool _showModeButtons = false;
  bool _showSubjectList = false;
  bool _showChipButtons = false;
  bool _chipClassMade = false;
  bool _chipSubjectMade = false;
  bool _chipModeMade = false;
  bool _chipTypeMade = false;
  bool _loadingWidget = false;
  List<String> _values = [];
  List<bool> _selected = [];
  List<bool> _selectedMode = [];
  List<bool> _selectedType = [];
  List<dynamic> _subjects = [];
  List<dynamic> _mode = [];
  List<dynamic> _type = [];
  var subject_map = {};
  var class_map = {};
  var mode_map = {};
  var type_map = {};
  dynamic _latitude;
  dynamic _longitude;
  dynamic _modeValue;
  dynamic _typeValue;
  final _first_nameController = TextEditingController();
  final _last_nameController = TextEditingController();
  final _subjectController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _pincodeController = TextEditingController();
  final _aboutController = TextEditingController();
  final _feeController = TextEditingController();
  final _emailController = TextEditingController();
  List _searchResult = [];
  List<dynamic> _allSubjects = ["math","science","english","history","civics","economics"];
  List<dynamic> items = [];
  List<dynamic> _modes = ['Online','Offline'];
  List<dynamic> _types = ['Group','Individual'];

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    if(_values.length > 0)
      _chipClassMade = true;
    else
      _chipClassMade = false;
    if(_subjects.length > 0)
      _chipSubjectMade = true;
    else
      _chipSubjectMade = false;
    if(_mode.length > 0)
      _chipModeMade = true;
    else
      _chipModeMade = false;
    if(_type.length > 0)
      _chipTypeMade = true;
    else
      _chipTypeMade = false;
  }

  @override
  void initState() {
    items.addAll(_allSubjects);
    super.initState();

    _first_nameController.addListener(_printLatestValue);
    _last_nameController.addListener(_printLatestValue);
    _addressController.addListener(_printLatestValue);
    _phoneController.addListener(_printLatestValue);
    _subjectController.addListener(_printLatestValue);
    _cityController.addListener(_printLatestValue);
    _stateController.addListener(_printLatestValue);
    _pincodeController.addListener(_printLatestValue);
    _aboutController.addListener(_printLatestValue);
    _feeController.addListener(_printLatestValue);
    _emailController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    _first_nameController.dispose();
    _last_nameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _subjectController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _pincodeController.dispose();
    _aboutController.dispose();
    _feeController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _getSubjects() {
    print(_subjects);
    _subjects.forEach((subject) => subject_map[subject] = subject);
  }

  void _getMode() {
    print(_mode);
    _mode.forEach((mode) => mode_map[mode.toString().toLowerCase()] = mode);
  }

  void _getType() {
    print(_type);
    _type.forEach((type) => type_map[type.toString().toLowerCase()] = type);
  }

  void _getClasses() {
    print(_values);
    _values.forEach((classes) => class_map[classes] = classes);
  }

  void filterSearchResults(String query) {
    List<dynamic> dummySearchList = <dynamic>[];
    dummySearchList.addAll(_allSubjects);
    if(query.isNotEmpty) {
      List<String> dummyListData = <String>[];
      dummySearchList.forEach((item) {
        if(item.contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
        if(item.contains(query.toUpperCase())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(_allSubjects);
      });
    }
  }

  void _printLatestValue() {
    print('Address field: ${_addressController.text}');
    print('Name field: ${_first_nameController.text}'+'${_last_nameController.text}');
    print('Phone field: ${_phoneController.text}');
    print('Subject field: ${_subjectController.text}');
    print('City field: ${_cityController.text}');
    print('State field: ${_stateController.text}');
    print('Pincode field: ${_pincodeController.text}');
    print('About field: ${_aboutController.text}');
    print('Fee field: ${_feeController.text}');
    print('Email field: ${_emailController.text}');
    //subjectSearch();
    print(_values);
    print(_subjects);
    print(_mode);
    print(_type);
  }

  Future<bool> _getlocation() async{
    var addresses = await Geocoder.local.findAddressesFromQuery(_addressController.text+_cityController.text+_stateController.text);
    var first = addresses.first;
    var location = first.coordinates.toMap();
    setState(() {
      _latitude = location['latitude'];
      _longitude = location['longitude'];
    });
    print(first.coordinates.toMap());
    return true;
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

  void subjectSearch() {
    _allSubjects.forEach((item) {
      //print("test");
      print(_subjectController.text);
      if(item.contains(_subjectController.text.toLowerCase()) == true){
        _searchResult.add(item);
        //print(_searchResult);
      }
    });
  }

  void clearAllText(){
    _first_nameController.clear();
    _last_nameController.clear();
    _addressController.clear();
    _phoneController.clear();
    _subjectController.clear();
    _cityController.clear();
    _stateController.clear();
    _pincodeController.clear();
    _aboutController.clear();
    _feeController.clear();
    _emailController.clear();
    setState(() {
      _showTypeButtons = false;
      _showModeButtons = false;
      _showSubjectList = false;
      _showChipButtons = false;
      _chipClassMade = false;
      _chipSubjectMade = false;
      _chipModeMade = false;
      _chipTypeMade = false;
      _loadingWidget = false;
      _values = [];
      _selected = [];
      _selectedMode = [];
      _selectedType = [];
      _subjects = [];
      _mode = [];
      _type = [];
      subject_map = {};
      class_map = {};
      mode_map = {};
      type_map = {};
    });
  }

  Widget buildClassChips() {
    List<Widget> chips = [];

    for (int i = 0; i < _values.length; i++) {
      RawChip actionChip = RawChip(
        selected: _selected[i],
        label: Text(_values[i],style: TextStyle(fontSize: 15,color: Colors.black),),
        backgroundColor: Colors.white,
        selectedColor: Colors.lightBlue,
        deleteButtonTooltipMessage: "Remove class",
        deleteIcon: Icon(Icons.close_rounded,size: 15,color: Colors.black,),
        onPressed: () {
          setState(() {
            _selected[i] = !_selected[i];
            _chipClassMade = true;
          });
        },
        onDeleted: () {
          _values.removeAt(i);
          _selected.removeAt(i);

          setState(() {
            _values = _values;
            _selected = _selected;
          });
        },
        showCheckmark: false,
      );
      chips.add(actionChip);
      chips.add(SizedBox(width: MediaQuery.of(context).size.width*0.01,));
    }

    return ListView(
      scrollDirection: Axis.horizontal,
      children: chips,
    );
  }

  Widget buildSubjectChips() {
    List<Widget> chips = [];

    for (int i = 0; i < _subjects.length; i++) {
      RawChip actionChip = RawChip(
        selected: true,
        label: Text(_subjects[i],style: TextStyle(fontSize: 15,color: Colors.black),),
        backgroundColor: Colors.white,
        selectedColor: Colors.lightBlue,
        deleteButtonTooltipMessage: "Remove class",
        deleteIcon: Icon(Icons.close_rounded,size: 15,color: Colors.black,),
        onPressed: () {
          setState(() {
            _chipClassMade = true;
          });
        },
        onDeleted: () {
          setState(() {
            _subjects.removeAt(i);
          });
        },
        showCheckmark: false,
      );
      chips.add(actionChip);
      chips.add(SizedBox(width: MediaQuery.of(context).size.width*0.01,));
    }

    return ListView(
      scrollDirection: Axis.horizontal,
      children: chips,
    );
  }

  Widget buildModeChips() {
    List<Widget> chips = [];

    for (int i = 0; i < _mode.length; i++) {
      RawChip actionChip = RawChip(
        selected: true,
        label: Text(_mode[i],style: TextStyle(fontSize: 15,color: Colors.black),),
        backgroundColor: Colors.white,
        selectedColor: Colors.lightBlue,
        deleteButtonTooltipMessage: "Remove mode",
        deleteIcon: Icon(Icons.close_rounded,size: 15,color: Colors.black,),
        onPressed: () {
          setState(() {
            _chipModeMade = true;
          });
        },
        onDeleted: () {
          setState(() {
            _mode.removeAt(i);
          });
        },
        showCheckmark: false,
      );
      chips.add(actionChip);
      chips.add(SizedBox(width: MediaQuery.of(context).size.width*0.01,));
    }

    return ListView(
      scrollDirection: Axis.horizontal,
      children: chips,
    );
  }

  Widget buildTypeChips() {
    List<Widget> chips = [];

    for (int i = 0; i < _type.length; i++) {
      RawChip actionChip = RawChip(
        selected: true,
        label: Text(_type[i],style: TextStyle(fontSize: 15,color: Colors.black),),
        backgroundColor: Colors.white,
        selectedColor: Colors.lightBlue,
        deleteButtonTooltipMessage: "Remove mode",
        deleteIcon: Icon(Icons.close_rounded,size: 15,color: Colors.black,),
        onPressed: () {
          setState(() {
            _chipTypeMade = true;
          });
        },
        onDeleted: () {
          setState(() {
            _type.removeAt(i);
          });
        },
        showCheckmark: false,
      );
      chips.add(actionChip);
      chips.add(SizedBox(width: MediaQuery.of(context).size.width*0.01,));
    }

    return ListView(
      scrollDirection: Axis.horizontal,
      children: chips,
    );
  }

  Widget buildClassButtons() {
    List<Widget> buttons = [];

    for (int i = 1; i < 13; i++) {
      TextButton buttonChip = TextButton(
          style: ButtonStyle(enableFeedback: true,),
          onPressed: () {
            setState(() {
              if (_values.contains('class $i') == false) {
                _values.add('class $i');
                _selected.add(true);
              }
            });
          },
          child: Text("class $i", style: TextStyle(fontSize: 15,color: Colors.lightBlue),)
      );
      buttons.add(buttonChip);
      buttons.add(SizedBox(width: MediaQuery.of(context).size.width*0.01,));
    }
    return ListView(
      scrollDirection: Axis.horizontal,
      children: buttons,
    );
  }

  Widget buildModeButtons() {
    List<Widget> buttons = [];

    for (int i = 0; i < 2; i++) {
      TextButton buttonChip = TextButton(
          style: ButtonStyle(enableFeedback: true,),
          onPressed: () {
            setState(() {
              if (_mode.contains(_modes[i]) == false) {
                _mode.add(_modes[i]);
                _selectedMode.add(true);
              }
            });
          },
          child: Text(_modes[i], style: TextStyle(fontSize: 15,color: Colors.lightBlue),)
      );
      buttons.add(buttonChip);
      buttons.add(SizedBox(width: MediaQuery.of(context).size.width*0.01,));
    }
    return ListView(
      scrollDirection: Axis.horizontal,
      children: buttons,
    );
  }

  Widget buildTypeButtons() {
    List<Widget> buttons = [];

    for (int i = 0; i < 2; i++) {
      TextButton buttonChip = TextButton(
          style: ButtonStyle(enableFeedback: true,),
          onPressed: () {
            setState(() {
              if (_type.contains(_types[i]) == false) {
                _type.add(_types[i]);
                _selectedType.add(true);
              }
            });
          },
          child: Text(_types[i], style: TextStyle(fontSize: 15,color: Colors.lightBlue),)
      );
      buttons.add(buttonChip);
      buttons.add(SizedBox(width: MediaQuery.of(context).size.width*0.01,));
    }
    return ListView(
      scrollDirection: Axis.horizontal,
      children: buttons,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Add a Tutor", style: TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),),
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
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                  Align(
                    alignment: Alignment.centerLeft,
                    //padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.05,top:MediaQuery.of(context).size.height*0.3),
                    child: Text("Name",
                      style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: "first name",
                      hintStyle: TextStyle(fontSize: 14),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                    style: TextStyle(fontSize: 14,),
                    controller: _first_nameController,
                    validator: (first_name) {
                      final nameRegExp = new RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
                      if (_first_nameController.text.isNotEmpty && nameRegExp.hasMatch(_first_nameController.text) == false)
                        return null;
                      else
                        return 'Enter a valid last name';
                    },
                    //maxLines: 3,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: "last name",
                      hintStyle: TextStyle(fontSize: 14),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                    style: TextStyle(fontSize: 14,),
                    controller: _last_nameController,
                    validator: (last_name) {
                      final nameRegExp = new RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
                      if (_last_nameController.text.isNotEmpty && nameRegExp.hasMatch(_last_nameController.text) == false)
                        return null;
                      else
                        return 'Enter a valid last name';
                    },
                    //maxLines: 3,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                  Align(
                    alignment: Alignment.centerLeft,
                    //padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.05,top:MediaQuery.of(context).size.height*0.3),
                    child: Text("Email",
                      style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),
                    ),
                  ),
                  //SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "email",
                      hintStyle: TextStyle(fontSize: 14),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                    style: TextStyle(fontSize: 14,),
                    controller: _emailController,
                    validator: (email) {
                      final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                      if(emailRegExp.hasMatch(email!))
                        return null;
                      else
                        return "Enter a valid email Id";
                    },
                    //maxLines: 3,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                  Align(
                    alignment: Alignment.centerLeft,
                    //padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.05,top:MediaQuery.of(context).size.height*0.3),
                    child: Text("Address",
                      style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),
                    ),
                  ),
                  //SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: "address",
                      hintStyle: TextStyle(fontSize: 14),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                    style: TextStyle(fontSize: 14,),
                    controller: _addressController,
                    validator: (address) {
                      if (address!.isEmpty)
                        return 'Enter a valid address';
                      else
                        return null;
                    },
                    //maxLines: 3,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: "city/area",
                      hintStyle: TextStyle(fontSize: 14),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                    style: TextStyle(fontSize: 14,),
                    controller: _cityController,
                    validator: (city) {
                      if (city!.isEmpty)
                        return 'Enter a valid city';
                      else
                        return null;
                    },
                    //maxLines: 3,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: "state",
                      hintStyle: TextStyle(fontSize: 14),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                    style: TextStyle(fontSize: 14,),
                    controller: _stateController,
                    validator: (state) {
                      if (state!.isEmpty)
                        return 'Enter a valid state';
                      else
                        return null;
                    },
                    //maxLines: 3,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter. digitsOnly],
                    decoration: InputDecoration(
                      hintText: "pincode",
                      hintStyle: TextStyle(fontSize: 14),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                    style: TextStyle(fontSize: 14,),
                    controller: _pincodeController,
                    validator: (pincode) {
                      final pincodeRegExp = RegExp(r"^\+?0[0-9]{10}$");
                      if(pincodeRegExp.hasMatch(pincode!) || pincode.isEmpty || pincode.length != 6)
                        return "Enter a valid pincode";
                      else
                        return null;
                    },
                    //maxLines: 3,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                  Align(
                    alignment: Alignment.centerLeft,
                    //padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.05,top:MediaQuery.of(context).size.height*0.3),
                    child: Text("Mode",
                      style: TextStyle(color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  _chipModeMade ? Container(
                    height: MediaQuery.of(context).size.height*0.08,
                    child: buildModeChips(),
                  ) : Container(),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "mode",
                      hintStyle: TextStyle(fontSize: 14),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                    style: TextStyle(fontSize: 14,),
                    onTap: () {
                      setState(() {
                        _showModeButtons = true;
                        _chipModeMade = true;
                      });
                    },
                    onSubmitted: (value) {
                      setState(() { _showModeButtons = false;});
                    },
                  ),
                  _showModeButtons ? Container(
                    height: MediaQuery.of(context).size.height*0.08,
                    child: buildModeButtons(),
                  ) : Container(),
                  SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                  Align(
                    alignment: Alignment.centerLeft,
                    //padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.05,top:MediaQuery.of(context).size.height*0.3),
                    child: Text("Type",
                      style: TextStyle(color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  _chipTypeMade ? Container(
                    height: MediaQuery.of(context).size.height*0.08,
                    child: buildTypeChips(),
                  ) : Container(),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "type",
                      hintStyle: TextStyle(fontSize: 14),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                    style: TextStyle(fontSize: 14,),
                    onTap: () {
                      setState(() {
                        _showTypeButtons = true;
                        _chipTypeMade = true;
                      });
                    },
                    onSubmitted: (value) {
                      setState(() { _showTypeButtons = false;});
                    },
                  ),
                  _showTypeButtons ? Container(
                    height: MediaQuery.of(context).size.height*0.08,
                    child: buildTypeButtons(),
                  ) : Container(),
                  SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                  Align(
                    alignment: Alignment.centerLeft,
                    //padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.05,top:MediaQuery.of(context).size.height*0.3),
                    child: Text("Phone number",
                      style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter. digitsOnly],
                    decoration: InputDecoration(
                      hintText: "ph no",
                      hintStyle: TextStyle(fontSize: 14),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                    style: TextStyle(fontSize: 14,),
                    controller: _phoneController,
                    validator: (ph_no) {
                      final numberExp = RegExp(r"^\+?0[0-9]{10}$");
                      if((numberExp.hasMatch(ph_no!) || ph_no.isEmpty) || ph_no.length != 10)
                        return "Enter a valid phone number";
                      else
                        return null;
                    },
                    //maxLines: 3,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                  Align(
                    alignment: Alignment.centerLeft,
                    //padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.05,top:MediaQuery.of(context).size.height*0.3),
                    child: Text("Classes",
                      style: TextStyle(color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  _chipClassMade ? Container(
                    height: MediaQuery.of(context).size.height*0.08,
                    child: buildClassChips(),
                  ) : Container(),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "class",
                      hintStyle: TextStyle(fontSize: 14),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                    style: TextStyle(fontSize: 14,),
                    onTap: () {
                      setState(() {
                        _showChipButtons = true;
                        _chipClassMade = true;
                      });
                    },
                    onSubmitted: (value) {
                      setState(() { _showChipButtons = false;});
                    },
                  ),
                  _showChipButtons ? Container(
                    height: MediaQuery.of(context).size.height*0.08,
                    child: buildClassButtons(),
                  ) : Container(),
                  SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                  Align(
                    alignment: Alignment.centerLeft,
                    //padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.05,top:MediaQuery.of(context).size.height*0.3),
                    child: Text("Subjects",
                      style: TextStyle(color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  _chipSubjectMade ? Container(
                    height: MediaQuery.of(context).size.height*0.08,
                    child: buildSubjectChips(),
                  ) : Container(),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "subjects",
                      hintStyle: TextStyle(fontSize: 14),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                    style: TextStyle(fontSize: 14,),
                    controller: _subjectController,
                    onTap: () {
                      setState(() {
                        _showSubjectList = true;
                      });
                    },
                    onChanged: (value) {
                      filterSearchResults(value);
                    },
                    onSubmitted: (value) {
                      setState(() {
                        _showSubjectList = false;
                      });
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                  _showSubjectList ?
                  Container(
                    color: Colors.transparent,
                    height: MediaQuery.of(context).size.height*0.3,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
                          width: MediaQuery.of(context).size.width*06,
                          height: 40,
                          child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  if(_subjects.contains(items[index]) == false)
                                    _subjects.add(items[index]);
                                  print(_subjects);
                                  _chipSubjectMade = true;
                                });
                              },
                              child: Text('${items[index]}'),
                              style: ButtonStyle(
                                foregroundColor: MaterialStateProperty.all<Color>(Colors.lightBlue),
                                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                              )
                          ),
                        );
                      },
                    ),
                  ) : Container(),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("About",
                      style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: "about yourself",
                      hintStyle: TextStyle(fontSize: 14),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                    style: TextStyle(fontSize: 14,),
                    controller: _aboutController,
                    maxLines: 3,
                    validator: (about) {
                      if(about!.isNotEmpty)
                        return null;
                      else
                        return "Enter a valid about";
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Fee",
                      style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter. digitsOnly],
                    decoration: InputDecoration(
                      hintText: "fee",
                      hintStyle: TextStyle(fontSize: 14),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                    style: TextStyle(fontSize: 14,),
                    controller: _feeController,
                    validator: (fee) {
                      final numberExp = RegExp(r"^\+?0[0-9]{10}$");
                      if(numberExp.hasMatch(fee!) || fee.isEmpty)
                        return "Enter a valid fee";
                      else
                        return null;
                    },
                    //maxLines: 3,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                  SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                  SizedBox(
                    width: 120,
                    height: 40,
                    child: ElevatedButton(
                        onPressed: () {
                          if(_formKey.currentState!.validate()){
                            print(_values);
                            setState(() {
                              Future.wait([_getlocation()]);
                              print(_latitude+_longitude);
                              _loadingWidget = true;
                              _onLoading();
                              _getSubjects();
                              _getClasses();
                              _getMode();
                              _getType();
                              Future.delayed(Duration(seconds: 3), () {
                                _database.child('Teachers').child(
                                    _phoneController.text).set({
                                  'first_name': _first_nameController.text,
                                  'last_name': _last_nameController.text,
                                  'coordinates': {
                                    'latitude': _latitude,
                                    'longitude': _longitude,
                                  },
                                  'subjects': subject_map,
                                  'classes': class_map,
                                  'fee': _feeController.text,
                                  'about': _aboutController.text,
                                  'address': {
                                    'area': _cityController.text,
                                    'main': _addressController.text,
                                    'pincode': _pincodeController.text,
                                    'state': _stateController.text,
                                  },
                                  'mode': mode_map,
                                  'email_id': _emailController.text,
                                  'rating': 3.5,
                                  'type': type_map,
                                });
                                _database.child('Teachers_ID').child(
                                    _phoneController.text).set(
                                    _phoneController.text);
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
                                          color: Colors.lightBlue,
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
                                              Text('Tutor Added Successfully !',
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
                                                            color: Colors
                                                                .lightBlue),)
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
                            });
                          }
                        },
                        style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlue),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    side: BorderSide(color: Colors.lightBlue)
                                )
                            )
                        ),
                        child: Text("Add", style: TextStyle(fontSize: 14),)
                    ),
                  ),
                ]
            ),
          ),
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