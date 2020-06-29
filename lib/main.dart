import 'package:demo_6_listview/detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:connectivity/connectivity.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'listview',
      home: Home(),
      theme:ThemeData(
        fontFamily: 'RailWay'
      )
    );
  }
}

class Home extends StatefulWidget {
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {
  //textfield edited
  var _controller = new TextEditingController();
  //check NetWork connection
    Map _source = {ConnectivityResult.none: false};
  MyConnectivity _connectivity = MyConnectivity.instance;

  List dataJson;

  // var url = "https://jsonplaceholder.typicode.com/photos";
  // var urlSearch = "https://restcountries.eu/rest/v2/name/";
  static var name = '';
  var urlSearchLINK = '';
  var url = "https://restcountries.eu/rest/v2/all";
  @override
  void initState() {
    super.initState();
    urlSearchLINK='https://restcountries.eu/rest/v2/all';
    print('init link: $urlSearchLINK');
    data();
    //check internet connection
    _connectivity.initialise();
    _connectivity.myStream.listen((source) {
      setState(() => _source = source);
    });
  }

  @override
  void dispose() {
    _connectivity.disposeStream();
    super.dispose();
  }

  Future<String> data() async {
    print('access future fun');
    setState(() {
       urlSearchLINK ='https://restcountries.eu/rest/v2/all';
       if(_controller.text.length>=1){
         setState(() {
           name = _controller.text;
      urlSearchLINK = 'https://restcountries.eu/rest/v2/name/' + name;
      print('future urlSearch: $urlSearchLINK');
         });
       }
    });
    /* setState(() {
      name = _controller.text;
      urlSearchLINK = 'https://restcountries.eu/rest/v2/name/' + name;
      print('future urlSearch: $urlSearchLINK');
    });
    if (_controller.text == null) {
      print('controller text == null');
      setState(() {
        urlSearchLINK = 'https://restcountries.eu/rest/v2/all';
      });
  } */
  http.Response hasil = await http.get(Uri.encodeFull(urlSearchLINK),
          headers: {"Accept": "application/json"});
      this.setState(() {
        dataJson = json.decode(hasil.body);
      });
  }
 

  @override
  Widget build(BuildContext context) {
    String string;
    switch (_source.keys.toList()[0]) {
      case ConnectivityResult.none:
        string = "Offline";
        break;
      case ConnectivityResult.mobile:
        string = "Mobile: Online";
        break;
      case ConnectivityResult.wifi:
        string = "WiFi: Online";
    }
    return Scaffold(
        /* appBar: AppBar(
        title: Text('Listview'),
      ), */
        body: SafeArea(
      child: new ListView(
        children: <Widget>[
          SizedBox(height: 15),
          /* Padding(
            padding: const EdgeInsets.symmetric(horizontal:15.0),
            child:Text(string),
          ), */
          Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              width: MediaQuery.of(context).size.width - 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Colors.grey.withOpacity(.4),
                    width: 1,
                  )),
              child: TextField(
                  // onSubmitted: _onSubmit(),
                  // onChanged: _onChange(),
                  // focusNode: _focusNode(),
                  onChanged: (text) {
                    if(_controller.text.length == 0 ){
                      print('text length = 0');
                      setState(() {
                        urlSearchLINK='https://restcountries.eu/rest/v2/all';
                      });
                      print('urlSearch when text length == 0');
                    }
                    setState(() {
                      urlSearchLINK =
                          'https://restcountries.eu/rest/v2/name/' + _controller.text;
                      print('after URL: $urlSearchLINK');
                      if(_controller.text.isEmpty){
                        setState(() {
                          urlSearchLINK = 'https://restcountries.eu/rest/v2/all';
                        });
                      }
                    });
                    data();
                  },
                  //auto focus alway open soft keyboard when init page
                  controller: _controller,
                  keyboardType: TextInputType.text,
                  textAlign: TextAlign.center,
                  // maxLength: 20,
                  autocorrect: false,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                          icon: Icon(Icons.arrow_drop_down), onPressed: () {}),
                      // helperText: 'Search Recipe',
                      hintText: 'Search Country here',
                      hintMaxLines: 1,
                      hintStyle: TextStyle(
                          color: Colors.grey.withOpacity(.4), fontSize: 15)))),
          Container(
            height: MediaQuery.of(context).size.height - 100,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              itemCount: dataJson == null ? 0 : dataJson.length,
              // itemCount: 10,
              itemBuilder: (context, i) {
                return Card(
                  child: ListTile(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>DetailPage(
                        name:dataJson[i]['name'],
                        capital:dataJson[i]['capital'],
                        region:dataJson[i]['region'],
                        subregion:dataJson[i]['subregion'],
                        flag:dataJson[i]['flag'],
                        demonym:dataJson[i]['demonym'],
                        nativeName:dataJson[i]['nativeName'],
                        cioc:dataJson[i]['cioc'], 
                         numericCode:dataJson[i]['numericCode'],
                         currencies:dataJson[i]['currencies'][0]['code'].toString(),
                         currencies2:dataJson[i]['currencies'][0]['name'].toString(),
                         currencies3:dataJson[i]['currencies'][0]['symbol'].toString(),
                         language:dataJson[i]['languages'][0]['iso639_1'].toString(),
                         language1:dataJson[i]['languages'][0]['iso639_2'].toString(),
                         language2:dataJson[i]['languages'][0]['name'].toString(),
                         language3:dataJson[i]['languages'][0]['nativeName'].toString(),
                         /* border:dataJson[i]['borders'][0]..toString(),
                         border2:dataJson[i]['borders'][0][1].toString(),
                         border3:dataJson[i]['borders'][0][2].toString(), */
                         population:dataJson[i]['population'],
                          /*   timezones:dataJson[i]['timezones'],
                           area:dataJson[i]['area'],
                         */
                        
                      )));
                    },
                    title: Text(dataJson[i]['name'],
                        style: TextStyle(
                          fontSize: 20.0,
                          decorationStyle: TextDecorationStyle.wavy,
                          decorationColor: Colors.blue[900],
                          decorationThickness: 0.5,
                        )),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Capital: ${dataJson[i]['capital']}'),
                        /* Text('Population: ' +
                            dataJson[i]['population'].toString()), */
                        Text('Region : ' + dataJson[i]['region'].toString()),
                        /* Text('subregion: ' +
                            dataJson[i]['subregion'].toString()),
                        Text('timezones: ' + dataJson[i]['timezones'][0]),
                        Text('area: ' + dataJson[i]['area'].toString()), */
                      ],
                    ),
                    leading: Hero(
                      tag:dataJson[i]['flag'],
                      child: Container(
                        height: 100,
                        width: 100,
                        child: SvgPicture.network(
                          dataJson[i]['flag'],
                          placeholderBuilder: (context) => Center(
                            child: Container(
                              height: 30,
                              width: 30,
                              child: CircularProgressIndicator(
                                strokeWidth: 1,
                              ),
                            ),
                          ),
                          height: 100.0,
                          width: 50,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    ));
  }
}

class MyConnectivity {
  MyConnectivity._internal();

  static final MyConnectivity _instance = MyConnectivity._internal();

  static MyConnectivity get instance => _instance;

  Connectivity connectivity = Connectivity();

  StreamController controller = StreamController.broadcast();

  Stream get myStream => controller.stream;

  void initialise() async {
    ConnectivityResult result = await connectivity.checkConnectivity();
    _checkStatus(result);
    connectivity.onConnectivityChanged.listen((result) {
      _checkStatus(result);
    });
  }

  void _checkStatus(ConnectivityResult result) async {
    bool isOnline = false;
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isOnline = true;
      } else
        isOnline = false;
    } on SocketException catch (_) {
      isOnline = false;
    }
    controller.sink.add({result: isOnline});
  }

  void disposeStream() => controller.close();
}