
import 'dart:async';
import 'package:custom_marker/marker_icon.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:label_marker/label_marker.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:tute_me/homepage.dart';
import 'package:tute_me/profile.dart';

class Map extends StatefulWidget {
  const Map({Key? key}) : super(key: key);

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  List<dynamic> _allArea = ["Alapakkam", "Alwarpet", "Alwarthirunagar", "Ambattur", "Aminjikarai", "Anna Nagar", "Annanur", "Arumbakkam", "Ashok Nagar", "Avadi", "Ayanavaram", "Besant Nagar", "Basin Bridge", "Chepauk", "Chetput", "Chintadripet", "Chitlapakkam", "Choolai", "Choolaimedu", "Chrompet", "Egmore", "Ekkaduthangal", "Eranavur", "Ennore", "Foreshore Estate", "Fort St. George", "George Town", "Gopalapuram", "Government Estate", "Guindy", "Guduvancheri", "IIT Madras", "Injambakkam", "ICF", "Iyyapanthangal", "Jafferkhanpet", "Karapakkam", "Kattivakkam", "Kattupakkam", "Kazhipattur", "K.K. Nagar", "Keelkattalai", "Kattivakkam", "Kilpauk", "Kodambakkam", "Kodungaiyur", "Kolathur", "Korattur", "Korukkupet", "Kottivakkam", "Kotturpuram", "Kottur", "Kovilambakkam", "Koyambedu", "Kundrathur", "Madhavaram", "Madhavaram Milk Colony", "Madipakkam", "Madambakkam", "Maduravoyal", "Manali", "Manali New Town", "Manapakkam", "Mandaveli", "Mangadu", "Mannady", "Mathur", "Medavakkam", "Meenambakkam", "MGR Nagar", "Minjur", "Mogappair", "MKB Nagar", "Mount Road", "Moolakadai", "Moulivakkam", "Mugalivakkam", "Mudichur", "Mylapore", "Nandanam", "Nanganallur", "Nanmangalam", "Neelankarai", "Nemilichery", "Nesapakkam", "Nolambur", "Noombal", "Nungambakkam", "Otteri", "Padi", "Pakkam", "Palavakkam", "Pallavaram", "Pallikaranai", "Pammal", "Park Town", "Parry's Corner", "Pattabiram", "Pattaravakkam", "Pazhavanthangal", "Peerkankaranai", "Perambur", "Peravallur", "Perumbakkam", "Perungalathur", "Perungudi", "Pozhichalur", "Poonamallee", "Porur", "Pudupet", "Pulianthope", "Purasaiwalkam", "Puthagaram", "Puzhal", "Puzhuthivakkam/ Ullagaram", "Raj Bhavan", "Ramavaram", "Red Hills", "Royapettah", "Royapuram", "Saidapet", "Saligramam", "Santhome", "Sembakkam", "Selaiyur", "Shenoy Nagar", "Sholavaram", "Sholinganallur", "Sithalapakkam", "Sowcarpet", "St.Thomas Mount", "Surapet", "Tambaram", "Teynampet", "Tharamani", "T. Nagar", "Thirumangalam", "Thirumullaivoyal", "Thiruneermalai", "Thiruninravur", "Thiruvanmiyur", "Tiruverkadu", "Thiruvotriyur", "Thuraipakkam", "Tirusulam", "Tiruvallikeni", "Tondiarpet", "United India Colony", "Vandalur", "Vadapalani", "Valasaravakkam", "Vallalar Nagar", "Vanagaram", "Velachery", "Velappanchavadi", "Villivakkam", "Virugambakkam", "Vyasarpadi", "Washermanpet", "West Mambalam",];
  late final Completer<GoogleMapController> _controller = Completer();
  List<dynamic> areaItems = [];
  bool _showSubjectList = false;
  var _searchText;
  var _cardImage;
  dynamic location;
  var _isSelected = false;
  var _cardName;
  var _cardData;
  dynamic data = [];
  var searchText = TextEditingController();

  final _database = FirebaseDatabase.instance.reference();
  late StreamSubscription _dataStream;

  MapType currentMapType = MapType.normal;
  late CameraPosition _kGoogle = CameraPosition(
    target: LatLng(20.42796133580664, 80.885749655962),
    zoom: 14.4746,
  );

  void _onMapTypeChanged() {
    setState(() {
      currentMapType = currentMapType == MapType.normal ? MapType.satellite : MapType.normal;
    });
  }

  final Set<Marker> markers = Set();

  Set<Marker> getmarkers() {
    print(data);
    for (dynamic items in data) {
      setState(() {
        markers.add(Marker(
          markerId: MarkerId(items[0]),
          position: LatLng(items[3], items[4]),
          infoWindow: InfoWindow(
            onTap: () {
              setState(() {
                _cardImage = items[2];
                _cardName = items[0];
                _cardData = items[1];
                _isSelected = true;
              });
            },
            title: items[0],
            snippet: items[1],
          ),
          icon: BitmapDescriptor.defaultMarker,
          onTap: () {
            setState(() {
              _cardImage = items[2];
              _cardName = items[0];
              _cardData = items[1];
              _isSelected = true;
            });
          }, //Icon for Marker
        ));
      });
    }
    print(markers);
    return markers;
  }

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission().then((value){
    }).onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("ERROR"+error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }

  void mylocationMarker() async{
    dynamic value = await getUserCurrentLocation();
    markers.addLabelMarker(LabelMarker(
      label: "ME",
      markerId: MarkerId("My Location"),
      position: LatLng(value.latitude, value.longitude),
      backgroundColor: Colors.blue,
      visible: true,
    ));
  }

  Future<void> _getlocation() async{
    var addresses = await Geocoder.local.findAddressesFromQuery(searchText.text);
    var first = addresses.first;
    location = first.coordinates.toMap();
    print(first.coordinates.toMap());
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

  Future<Set<Marker>> _activateListeners() async {
    _dataStream = _database.child('Teachers').onValue.listen((event) {
      //getmarkers();
      final dynamic teacher = event.snapshot.value;
      setState(() {
        teacher.forEach((k, v){
          print([v['first_name'],v['coordinates']['latitude'],v['coordinates']['longitude']]);
          data.add([v['first_name'],v['last_name'],"assets/gajju.jpg",v['coordinates']['latitude'],v['coordinates']['longitude']]);
        });
      });
    });
    print(data);
    for (dynamic items in data) {
      setState(() {
        markers.add(Marker(
          markerId: MarkerId(items[0]),
          position: LatLng(items[3], items[4]),
          infoWindow: InfoWindow(
            onTap: () {
              setState(() {
                _cardImage = items[2];
                _cardName = items[0];
                _cardData = items[1];
                _isSelected = true;
              });
            },
            title: items[0],
            snippet: items[1],
          ),
          icon: BitmapDescriptor.defaultMarker,
          onTap: () {
            setState(() {
              _cardImage = items[2];
              _cardName = items[0];
              _cardData = items[1];
              _isSelected = true;
            });
          }, //Icon for Marker
        ));
      });
    }
    print(markers);
    return markers;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _activateListeners();
    areaItems.addAll(_allArea);
    //_mylocation();
  }

  void _mylocation() async{
    dynamic value = await getUserCurrentLocation();
    print(value);
    _kGoogle = CameraPosition(
      target: LatLng(value.latitude, value.longitude),
      zoom: 14.4746,
    );
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    _dataStream.cancel();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    _mylocation();
    mylocationMarker();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
                colors: [
                  const Color(0xFF00E1FF),
                  const Color(0xFF00FFEA),
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
        ),
        title: Text("Map", style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),),
        leading: Builder(
          builder: (context) =>
              IconButton(
                icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.white,),
                onPressed: () => Navigator.pop(context),
              ),
        ),
        actions: [
          IconButton(onPressed: _onMapTypeChanged, icon: Icon(Icons.map_rounded,),)
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(
        children: [
          FutureBuilder(
              future: _activateListeners(),
              builder: (BuildContext ctx, AsyncSnapshot<dynamic> snapshot) =>
              snapshot.hasData
                  ?
              GoogleMap(
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                initialCameraPosition: _kGoogle,
                mapType: currentMapType,
                myLocationEnabled: true,
                compassEnabled: true,
                markers: snapshot.data,
              ): const Center(
                // render the loading indicator
                child: CircularProgressIndicator(),)
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 8.0),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
                      width: MediaQuery.of(context).size.width*0.8,
                      child: Column(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width*1,
                            height: _showSubjectList ? MediaQuery.of(context).size.height*0.3 : MediaQuery.of(context).size.height*0.065,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  TextField(
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      icon: Icon(Icons.search_rounded, color: Colors.tealAccent,),
                                      hintText: " search area",
                                      hintStyle: TextStyle(fontSize: 14),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.tealAccent),
                                      ),
                                    ),
                                    style: TextStyle(fontSize: 14,),
                                    controller: searchText,
                                    onChanged: (value) {
                                      _showSubjectList = true;
                                      filterAreaSearchResults(value);
                                    },
                                    onSubmitted: (value) async{
                                      await _getlocation();
                                      GoogleMapController controller = await _controller.future;
                                      controller.animateCamera(CameraUpdate.newCameraPosition(
                                          CameraPosition(
                                            target: LatLng(location['latitude'], location['longitude']),
                                            zoom: 14,
                                          )
                                      ));
                                      setState(() {
                                        _showSubjectList = false;
                                        searchText.clear();
                                      });
                                    },
                                  ),
                                  _showSubjectList ? Container(
                                    margin: EdgeInsets.only(bottom: 10),
                                    width: MediaQuery.of(context).size.width*0.65,
                                    color: Colors.transparent,
                                    height: MediaQuery.of(context).size.height*0.42,
                                    child: ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      itemCount: areaItems.length,
                                      itemBuilder: (context, index) {
                                        return SizedBox(
                                          height: 40,
                                          child: TextButton(
                                            onPressed: () {
                                              searchText.text = areaItems[index];
                                            },
                                            child: ListTile(
                                              leading: Text(areaItems[index]),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ): Container(),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )/*Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 8.0),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
                    width: MediaQuery.of(context).size.width*0.8,
                    child: TextField(
                      controller: searchText,
                      onTap: () {
                        setState(() {_isSelected = false; });
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(Icons.search_rounded),
                        hintText: "Search area",
                      ),
                      onChanged: (value) {
                        setState(() {
                          _searchText = value;
                          print(_searchText);
                        });
                      },
                      onSubmitted: (value) {
                        setState(() async {
                          await _getlocation();
                          GoogleMapController controller = await _controller.future;
                          controller.animateCamera(CameraUpdate.newCameraPosition(
                            // on below line we have given positions of Location 5
                              CameraPosition(
                                target: LatLng(location['latitude'], location['longitude']),
                                zoom: 14,
                              )
                          ));
                        });
                      },
                    ),
                  ),*/
                ),
                _isSelected ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      alignment: Alignment.topCenter,
                      //padding: EdgeInsets.all(10),
                      height: MediaQuery.of(context).size.height*0.12,
                      width: MediaQuery.of(context).size.width*0.9,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white,),
                      child: TextButton(
                        onPressed: (){},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          foregroundColor: Colors.black,
                        ),
                        child: Row(
                          children: [
                            Image.asset(_cardImage),
                            SizedBox(width: MediaQuery.of(context).size.width*0.02,),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(_cardName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,),),
                                  Text(_cardData, style: TextStyle(fontWeight: FontWeight.bold,),),
                                ],
                              ),
                            ),
                            IconButton(onPressed: () {setState(() {_isSelected = false;});}, icon: Icon(Icons.close), iconSize: 20,)
                          ],
                        ),
                      ),
                    ),
                  ),
                ) : Container(),
              ],
            ),
          ),

        ],
      ),
      /*floatingActionButton: FloatingActionButton(
        child: Icon(Icons.map_rounded, size: 20),
        onPressed: _onMapTypeChanged,
      ),*/
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
                      Navigator.pop(context);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    },
                    hoverColor: Colors.black,
                    color: Colors.white,
                    highlightColor: Colors.black12,
                    tooltip: "Home",
                    icon: Icon(Icons.home_outlined),
                    iconSize: 35,
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {},//=> Navigator.push(context, MaterialPageRoute(builder: (context) => Map())),
                    hoverColor: Colors.black,
                    color: Colors.white,
                    highlightColor: Colors.black12,
                    tooltip: "Locate",
                    icon: Icon(Icons.location_on_rounded,),
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