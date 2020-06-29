import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Detail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:DetailPage(),
      theme:ThemeData(
        fontFamily: 'Nunito'
      )
    );
  }
}

class DetailPage extends StatefulWidget {
  final String name;
  final String capital;
  final String region;
  final String subregion;
  final String flag;
  final String languages;
  final String cioc; 
  final String demonym;
  final String nativeName;
  final String numericCode;
  final String currencies;
  final String currencies2;
  final String currencies3;
  final int population;
  final String language;
  final String language1;
  final String language2;
  final String language3;
  final String border;
  final String border2;
  final String border3;
  const DetailPage({Key key, this.name, this.capital, this.region, this.subregion, this.flag,
   this.languages, this.cioc, this.demonym, this.nativeName,this.numericCode,
   this.currencies,this.currencies2,this.currencies3,this.population,
   this.language,this.language1,this.language2,this.language3,
   this.border,
   this.border2,
   this.border3,
   }) : super(key: key);
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text(widget.name),
        actions: <Widget>[
          CircleAvatar(
          backgroundColor: Colors.transparent,
          child: SvgPicture.network(
                        widget.flag,
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
        ],
      ),
      body:Padding(
        padding:EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Name: ${widget.name}'),
            SizedBox(
              height: 5,
            ),
            Text('Native Name: ${widget.nativeName}'),
            SizedBox(
              height: 5,
            ),
            Text('Capital: ${widget.capital}'),
            SizedBox(
              height: 5,
            ),
            Text('Region: ${widget.region}'),
            SizedBox(
              height: 5,
            ),
            Text('SubRegion: ${widget.subregion}'),
            SizedBox(
              height: 15,
            ),
            // Text('flag: ${widget.flag}'),
            Hero(
              tag:widget.flag,
              child: Center(
                child: SvgPicture.network(
                              widget.flag,
                              placeholderBuilder: (context) => Center(
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 1,
                                  ),
                                ),
                              ),
                              height: 200.0,
                              width: 100,
                            ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text('Cioc: ${widget.cioc}'),
            SizedBox(
              height: 5,
            ),
            Text('numericCode: ${widget.numericCode}'.toString()),
            SizedBox(
              height: 5,
            ),
            Text('Population: ${widget.population}'.toString()),
            SizedBox(
              height: 5,
            ),
            Text('Currency: ',style:TextStyle(color:Colors.blue)),
            Container(
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('-Code: ${widget.currencies}'),
                  Text('-Name: ${widget.currencies2}'),
                  Text('-Symbol: ${widget.currencies3}'),
                ],
              )
            ),
            Text('Language',style:TextStyle(color:Colors.blue)),
            Container(
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('-iso639_1: ${widget.language}'),
                  Text('-iso639_2: ${widget.language1}'),
                  Text('-name: ${widget.language2}'),
                  Text('-nativeName: ${widget.language3}'),
                ],
              )
            ),
            /* Text('Borders'),
            Container(
              child:Column(
                children: <Widget>[
                  Text('${widget.border}'),
                  Text('${widget.border2}'),
                  Text('${widget.border3}'),
                  
                ],
              )
            ) */
          ],
        ),
      )
    );
  }
}