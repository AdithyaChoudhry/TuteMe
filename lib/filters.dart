import 'package:flutter/material.dart';
import 'package:tute_me/map.dart';
import 'package:tute_me/profile.dart';
class Filters extends StatefulWidget {
  const Filters({Key? key}) : super(key: key);

  @override
  _FiltersState createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  var _subjectController = TextEditingController();
  var _areaController = TextEditingController();
  final List<dynamic> _appliedFilters = [];
  List<bool> _modeCheck = List.filled(2, false);
  List<bool> _typeCheck = List.filled(2, false);
  List<bool> _priceCheck = List.filled(5, false);
  List<bool> _classCheck = List.filled(12, false);
  List<dynamic> items = [];
  List<dynamic> areaItems = [];
  List<dynamic> areaItemsCheckbox = [];
  List<dynamic> itemsCheckbox = [];
  List<dynamic> _allSubjects = ["math","science","english","history","civics","economics"];
  List<dynamic> _allArea = ["Alapakkam", "Alwarpet", "Alwarthirunagar", "Ambattur", "Aminjikarai", "Anna Nagar", "Annanur", "Arumbakkam", "Ashok Nagar", "Avadi", "Ayanavaram", "Besant Nagar", "Basin Bridge", "Chepauk", "Chetput", "Chintadripet", "Chitlapakkam", "Choolai", "Choolaimedu", "Chrompet", "Egmore", "Ekkaduthangal", "Eranavur", "Ennore", "Foreshore Estate", "Fort St. George", "George Town", "Gopalapuram", "Government Estate", "Guindy", "Guduvancheri", "IIT Madras", "Injambakkam", "ICF", "Iyyapanthangal", "Jafferkhanpet", "Karapakkam", "Kattivakkam", "Kattupakkam", "Kazhipattur", "K.K. Nagar", "Keelkattalai", "Kattivakkam", "Kilpauk", "Kodambakkam", "Kodungaiyur", "Kolathur", "Korattur", "Korukkupet", "Kottivakkam", "Kotturpuram", "Kottur", "Kovilambakkam", "Koyambedu", "Kundrathur", "Madhavaram", "Madhavaram Milk Colony", "Madipakkam", "Madambakkam", "Maduravoyal", "Manali", "Manali New Town", "Manapakkam", "Mandaveli", "Mangadu", "Mannady", "Mathur", "Medavakkam", "Meenambakkam", "MGR Nagar", "Minjur", "Mogappair", "MKB Nagar", "Mount Road", "Moolakadai", "Moulivakkam", "Mugalivakkam", "Mudichur", "Mylapore", "Nandanam", "Nanganallur", "Nanmangalam", "Neelankarai", "Nemilichery", "Nesapakkam", "Nolambur", "Noombal", "Nungambakkam", "Otteri", "Padi", "Pakkam", "Palavakkam", "Pallavaram", "Pallikaranai", "Pammal", "Park Town", "Parry's Corner", "Pattabiram", "Pattaravakkam", "Pazhavanthangal", "Peerkankaranai", "Perambur", "Peravallur", "Perumbakkam", "Perungalathur", "Perungudi", "Pozhichalur", "Poonamallee", "Porur", "Pudupet", "Pulianthope", "Purasaiwalkam", "Puthagaram", "Puzhal", "Puzhuthivakkam/ Ullagaram", "Raj Bhavan", "Ramavaram", "Red Hills", "Royapettah", "Royapuram", "Saidapet", "Saligramam", "Santhome", "Sembakkam", "Selaiyur", "Shenoy Nagar", "Sholavaram", "Sholinganallur", "Sithalapakkam", "Sowcarpet", "St.Thomas Mount", "Surapet", "Tambaram", "Teynampet", "Tharamani", "T. Nagar", "Thirumangalam", "Thirumullaivoyal", "Thiruneermalai", "Thiruninravur", "Thiruvanmiyur", "Tiruverkadu", "Thiruvotriyur", "Thuraipakkam", "Tirusulam", "Tiruvallikeni", "Tondiarpet", "United India Colony", "Vandalur", "Vadapalani", "Valasaravakkam", "Vallalar Nagar", "Vanagaram", "Velachery", "Velappanchavadi", "Villivakkam", "Virugambakkam", "Vyasarpadi", "Washermanpet", "West Mambalam",];
  List<dynamic> _mode = ["Online", "Offline"];
  List<dynamic> _type = ["Group", "Individual"];
  List<dynamic> _price = ["From 500 to 1000", "From 1000 to 2500", "From 2500 to 5000", "From 5000 to 10000", "More than 10000"];
  bool _subjectPressed = false;
  bool _typePressed = false;
  bool _modePressed = true;
  bool _pricePressed = false;
  bool _classPressed = false;
  bool _areaPressed = false;

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    buildFilterChips();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    itemsCheckbox = List.filled(_allSubjects.length, false);
    areaItemsCheckbox = List.filled(_allArea.length, false);
    items.addAll(_allSubjects);
    areaItems.addAll(_allArea);
  }

  void clearFilters() {
    print(_appliedFilters);
    setState(() {
      _appliedFilters.clear();
      _modeCheck = List.filled(2, false);
      _typeCheck = List.filled(2, false);
      _priceCheck = List.filled(5, false);
      _classCheck = List.filled(12, false);
      itemsCheckbox = List.filled(_allSubjects.length, false);
      areaItemsCheckbox = List.filled(_allArea.length, false);
    });
  }

  Widget buildFilterChips() {
    List<Widget> chips = [];

    for (int i = 0; i < _appliedFilters.length; i++) {
      RawChip actionChip = RawChip(
        selected: true,
        label: Text(_appliedFilters[i],style: TextStyle(fontSize: 15,color: Colors.black),),
        backgroundColor: Colors.white,
        selectedColor: Color.fromARGB(
            225, 39, 211, 241),
        deleteButtonTooltipMessage: "Remove mode",
        deleteIcon: Icon(Icons.close_rounded,size: 15,color: Colors.black,),
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

  void filterSubjectSearchResults(String query) {
    List<dynamic> dummySearchList = <dynamic>[];
    dummySearchList.addAll(_allSubjects);
    if(query.isNotEmpty) {
      List<String> dummyListData = <String>[];
      dummySearchList.forEach((item) {
        if(item.contains(query.substring(0,1).toUpperCase() + query.substring(1))){
          dummyListData.add(item);
        }
        if(item.contains(query.substring(0,1).toUpperCase() + query.substring(1))){
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


  void filterAreaSearchResults(String query) {
    List<dynamic> dummySearchList = <dynamic>[];
    dummySearchList.addAll(_allArea);
    if(query.isNotEmpty) {
      List<String> dummyListData = <String>[];
      dummySearchList.forEach((item) {
        if(item.contains(query.substring(0,1).toUpperCase() + query.substring(1))) {
          dummyListData.add(item);
        }
        if(item.contains(query.substring(0,1).toUpperCase() + query.substring(1))) {
          dummyListData.add(item);
        }
      });
      setState(() {
        areaItems.clear();
        areaItems.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        areaItems.clear();
        areaItems.addAll(_allArea);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Filters", style: TextStyle(fontSize: 25, color: Color.fromARGB(
            225, 39, 211, 241),),),
        leading: Builder(
          builder: (context) =>
              IconButton(
                icon: Icon(Icons.arrow_back_ios_rounded, color: Color.fromARGB(
                    225, 39, 211, 241),),
                onPressed: () => Navigator.pop(context),
              ),
        ),
        actions: [
          TextButton(onPressed: () {
            clearFilters();
          }, child: Text("Clear Filters", style: TextStyle(color: Color.fromARGB(
              225, 39, 211, 241),),)),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Row(
        children: [
          Container(
            child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.3,
                  child: TextButton(onPressed: () {
                    setState(() {
                      _modePressed = true;
                      _subjectPressed = false;
                      _typePressed = false;
                      _pricePressed = false;
                      _classPressed = false;
                      _areaPressed = false;
                    });
                  }, child: Text("Mode", style: TextStyle(color: Color.fromARGB(
                      225, 39, 211, 241),),)),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.3,
                  child: TextButton(onPressed: () {
                    setState(() {
                      _modePressed = false;
                      _subjectPressed = true;
                      _typePressed = false;
                      _pricePressed = false;
                      _classPressed = false;
                      _areaPressed = false;
                    });
                  }, child: Text("Subjects", style: TextStyle(color: Color.fromARGB(
                      225, 39, 211, 241),),)),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.3,
                  child: TextButton(onPressed: () {
                    setState(() {
                      _modePressed = false;
                      _subjectPressed = false;
                      _typePressed = true;
                      _pricePressed = false;
                      _classPressed = false;
                      _areaPressed = false;
                    });
                  }, child: Text("Type", style: TextStyle(color: Color.fromARGB(
                      225, 39, 211, 241),),)),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.3,
                  child: TextButton(onPressed: () {
                    setState(() {
                      _modePressed = false;
                      _subjectPressed = false;
                      _typePressed = false;
                      _pricePressed = true;
                      _classPressed = false;
                      _areaPressed = false;
                    });
                  }, child: Text("Price", style: TextStyle(color: Color.fromARGB(
                      225, 39, 211, 241),),)),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.3,
                  child: TextButton(onPressed: () {
                    setState(() {
                      _modePressed = false;
                      _subjectPressed = false;
                      _typePressed = false;
                      _pricePressed = false;
                      _classPressed = true;
                      _areaPressed = false;
                    });
                  }, child: Text("Class", style: TextStyle(color: Color.fromARGB(
                      225, 39, 211, 241),),)),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.3,
                  child: TextButton(onPressed: () {
                    setState(() {
                      _modePressed = false;
                      _subjectPressed = false;
                      _typePressed = false;
                      _pricePressed = false;
                      _classPressed = false;
                      _areaPressed = true;
                    });
                  }, child: Text("Area", style: TextStyle(color: Color.fromARGB(
                      225, 39, 211, 241),),)),
                ),
                //SizedBox(width: MediaQuery.of(context).size.width*0.3,),
              ],
            ),
          ),
          VerticalDivider(thickness: 0.5,color: Colors.black,),
          SingleChildScrollView(
            child: Column(
              children: [
                _appliedFilters.isNotEmpty ? Container(
                  height: MediaQuery.of(context).size.height*0.08,
                  width: MediaQuery.of(context).size.width*0.65,
                  child: buildFilterChips(),
                ) : Container(),
                _modePressed == true ? Container(
                  child: Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.65,
                        height: MediaQuery.of(context).size.height*0.7,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: _mode.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
                              height: 40,
                              child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      if(_modeCheck[index] == true){
                                        _modeCheck[index] = false;
                                        if(_appliedFilters.contains(_mode[index]))
                                          _appliedFilters.remove(_mode[index]);
                                      }
                                      else {
                                        _modeCheck[index] = true;
                                        if (_appliedFilters.contains(
                                            _mode[index]))
                                          print(_modeCheck[index]);
                                        else
                                          _appliedFilters.add(_mode[index]);
                                      }
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Text('${_mode[index]}', style: TextStyle(color: Color.fromARGB(
                                          225, 39, 211, 241),),),
                                      Spacer(),
                                      Checkbox(value: _modeCheck[index], onChanged: (value) {
                                        setState(() {
                                          if(_modeCheck[index] == true){
                                            _modeCheck[index] = false;
                                            if(_appliedFilters.contains(_mode[index]))
                                              _appliedFilters.remove(_mode[index]);
                                          }
                                          else {
                                            _modeCheck[index] = true;
                                            if (_appliedFilters.contains(
                                                _mode[index]))
                                              print(_modeCheck[index]);
                                            else
                                              _appliedFilters.add(_mode[index]);
                                          }
                                        });
                                      },
                                        activeColor: Color.fromARGB(
                                            225, 39, 211, 241),)
                                    ],
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    shadowColor: Colors.white,
                                    foregroundColor: Color.fromARGB(
                                        225, 39, 211, 241),
                                    backgroundColor: Colors.white,
                                  )
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ) : Container(),
                _subjectPressed == true ? SizedBox(
                  width: MediaQuery.of(context).size.width*0.65,
                  height: MediaQuery.of(context).size.height*0.8,
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          hintText: " search subjects",
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
                        onChanged: (value) {
                          filterSubjectSearchResults(value);
                        },
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        width: MediaQuery.of(context).size.width*0.65,
                        color: Colors.transparent,
                        height: MediaQuery.of(context).size.height*0.72,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
                              height: 40,
                              child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      if(itemsCheckbox[index] == true){
                                        itemsCheckbox[index] = false;
                                        if(_appliedFilters.contains(items[index]))
                                          _appliedFilters.remove(items[index]);
                                      }
                                      else {
                                        itemsCheckbox[index] = true;
                                        if (_appliedFilters.contains(
                                            items[index]))
                                          print(itemsCheckbox[index]);
                                        else
                                          _appliedFilters.add(items[index]);
                                      }
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Text('${items[index]}', style: TextStyle(color: Color.fromARGB(
                                          225, 39, 211, 241),),),
                                      Spacer(),
                                      Checkbox(value: itemsCheckbox[index], onChanged: (value) {
                                        setState(() {
                                          if(itemsCheckbox[index] == true){
                                            itemsCheckbox[index] = false;
                                            if(_appliedFilters.contains(items[index]))
                                              _appliedFilters.remove(items[index]);
                                          }
                                          else {
                                            itemsCheckbox[index] = true;
                                            if (_appliedFilters.contains(
                                                items[index]))
                                              print(itemsCheckbox[index]);
                                            else
                                              _appliedFilters.add(items[index]);
                                          }
                                        });
                                      },
                                        activeColor: Color.fromARGB(
                                            225, 39, 211, 241),)
                                    ],
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    shadowColor: Colors.white,
                                    foregroundColor: Color.fromARGB(
                                        225, 39, 211, 241),
                                    backgroundColor: Colors.white,
                                  )
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ) : Container(),
                _typePressed == true ? Container(
                  child: Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.65,
                        height: MediaQuery.of(context).size.height*0.7,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: _type.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
                              height: 40,
                              child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      if(_typeCheck[index] == true){
                                        _typeCheck[index] = false;
                                        if(_appliedFilters.contains(_type[index]))
                                          _appliedFilters.remove(_type[index]);
                                      }
                                      else {
                                        _typeCheck[index] = true;
                                        if (_appliedFilters.contains(
                                            _type[index]))
                                          print(_typeCheck[index]);
                                        else
                                          _appliedFilters.add(_type[index]);
                                      }
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Text('${_type[index]}', style: TextStyle(color: Color.fromARGB(
                                          225, 39, 211, 241),),),
                                      Spacer(),
                                      Checkbox(value: _typeCheck[index], onChanged: (value) {
                                        setState(() {
                                          if(_typeCheck[index] == true){
                                            _typeCheck[index] = false;
                                            if(_appliedFilters.contains(_type[index]))
                                              _appliedFilters.remove(_type[index]);
                                          }
                                          else {
                                            _typeCheck[index] = true;
                                            if (_appliedFilters.contains(
                                                _type[index]))
                                              print(_typeCheck[index]);
                                            else
                                              _appliedFilters.add(_type[index]);
                                          }
                                        });
                                      },
                                        activeColor: Color.fromARGB(
                                            225, 39, 211, 241),)
                                    ],
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    shadowColor: Colors.white,
                                    foregroundColor: Color.fromARGB(
                                        225, 39, 211, 241),
                                    backgroundColor: Colors.white,
                                  )
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ) : Container(),
                _pricePressed == true ? Container(
                  child: Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.65,
                        height: MediaQuery.of(context).size.height*0.8,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: _price.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
                              height: 40,
                              child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      if(_priceCheck[index] == true){
                                        _priceCheck[index] = false;
                                        if(_appliedFilters.contains(_price[index]))
                                          _appliedFilters.remove(_price[index]);
                                      }
                                      else {
                                        _priceCheck[index] = true;
                                        if (_appliedFilters.contains(
                                            _price[index]))
                                          print(_priceCheck[index]);
                                        else
                                          _appliedFilters.add(_price[index]);
                                      }
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Text('${_price[index]}', style: TextStyle(color: Color.fromARGB(
                                          225, 39, 211, 241),),),
                                      Spacer(),
                                      Checkbox(value: _priceCheck[index], onChanged: (value) {
                                        setState(() {
                                          if(_priceCheck[index] == true){
                                            _priceCheck[index] = false;
                                            if(_appliedFilters.contains(_price[index]))
                                              _appliedFilters.remove(_price[index]);
                                          }
                                          else {
                                            _priceCheck[index] = true;
                                            if (_appliedFilters.contains(
                                                _price[index]))
                                              print(_priceCheck[index]);
                                            else
                                              _appliedFilters.add(_price[index]);
                                          }
                                        });
                                      },
                                        activeColor: Color.fromARGB(
                                            225, 39, 211, 241),)
                                    ],
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    shadowColor: Colors.white,
                                    foregroundColor: Color.fromARGB(
                                        225, 39, 211, 241),
                                    backgroundColor: Colors.white,
                                  )
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ) : Container(),
                _classPressed == true ? Container(
                  child: Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.65,
                        height: MediaQuery.of(context).size.height*0.8,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: 12,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
                              height: 40,
                              child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      if(_classCheck[index] == true){
                                        _classCheck[index] = false;
                                        if(_appliedFilters.contains('Class ${index + 1}'))
                                          _appliedFilters.remove('Class ${index + 1}');
                                      }
                                      else {
                                        _classCheck[index] = true;
                                        if (_appliedFilters.contains(
                                            'Class ${index + 1}'))
                                          print(_classCheck[index]);
                                        else
                                          _appliedFilters.add('Class ${index + 1}');
                                      }
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Text('Class ${index + 1}', style: TextStyle(color: Color.fromARGB(
                                          225, 39, 211, 241),),),
                                      Spacer(),
                                      Checkbox(value: _classCheck[index], onChanged: (value) {
                                        setState(() {
                                          if(_classCheck[index] == true){
                                            _classCheck[index] = false;
                                            if(_appliedFilters.contains('Class ${index + 1}'))
                                              _appliedFilters.remove('Class ${index + 1}');
                                          }
                                          else {
                                            _classCheck[index] = true;
                                            if (_appliedFilters.contains(
                                                'Class ${index + 1}'))
                                              print(_classCheck[index]);
                                            else
                                              _appliedFilters.add('Class ${index + 1}');
                                          }
                                        });
                                      },
                                        activeColor: Color.fromARGB(
                                            225, 39, 211, 241),)
                                    ],
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    shadowColor: Colors.white,
                                    foregroundColor: Color.fromARGB(
                                        225, 39, 211, 241),
                                    backgroundColor: Colors.white,
                                  )
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ) : Container(),
                _areaPressed == true ? Container(
                  child: Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.65,
                        height: MediaQuery.of(context).size.height*0.8,
                        child: Column(
                          children: [
                            TextField(
                              decoration: InputDecoration(
                                hintText: " search area",
                                hintStyle: TextStyle(fontSize: 14),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                              ),
                              style: TextStyle(fontSize: 14,),
                              controller: _areaController,
                              onChanged: (value) {
                                filterAreaSearchResults(value);
                              },
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 10),
                              width: MediaQuery.of(context).size.width*0.65,
                              color: Colors.transparent,
                              height: MediaQuery.of(context).size.height*0.72,
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: areaItems.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.only(bottom: 10),
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
                                    height: 40,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            if(areaItemsCheckbox[index] == true){
                                              areaItemsCheckbox[index] = false;
                                              if(_appliedFilters.contains(areaItems[index]))
                                                _appliedFilters.remove(areaItems[index]);
                                            }
                                            else {
                                              areaItemsCheckbox[index] = true;
                                              if (_appliedFilters.contains(
                                                  areaItems[index]))
                                                print(areaItemsCheckbox[index]);
                                              else
                                                _appliedFilters.add(areaItems[index]);
                                            }
                                          });
                                        },
                                        child: Row(
                                          children: [
                                            Text('${areaItems[index]}', style: TextStyle(color: Color.fromARGB(
                                                225, 39, 211, 241),),),
                                            Spacer(),
                                            Checkbox(value: areaItemsCheckbox[index], onChanged: (value) {
                                              setState(() {
                                                if(areaItemsCheckbox[index] == true){
                                                  areaItemsCheckbox[index] = false;
                                                  if(_appliedFilters.contains(areaItems[index]))
                                                    _appliedFilters.remove(areaItems[index]);
                                                }
                                                else {
                                                  areaItemsCheckbox[index] = true;
                                                  if (_appliedFilters.contains(
                                                      areaItems[index]))
                                                    print(areaItemsCheckbox[index]);
                                                  else
                                                    _appliedFilters.add(areaItems[index]);
                                                }
                                              });
                                            },
                                              activeColor: Color.fromARGB(
                                                  225, 39, 211, 241),
                                            )
                                          ],
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          shadowColor: Colors.white,
                                          foregroundColor: Color.fromARGB(
                                              225, 39, 211, 241),
                                          backgroundColor: Colors.white,
                                        )
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ) : Container(),
              ],
            ),
          ),
        ],
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
