import 'package:flutter/material.dart';

class MarketPlace extends StatefulWidget {
  @override
  _MarketPlaceState createState() => _MarketPlaceState();
}

class _MarketPlaceState extends State<MarketPlace> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text("MARKET PLACE", style: TextStyle(color: Colors.white))),
        backgroundColor: Colors.green.shade800,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.notifications),
          )
        ],
      ),
      body: ListView(children:<Widget>[
           Container(
             child: ListView.builder(
                      // controller: featuredScrollController,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: ScrollPhysics(),
                      itemCount:8,
                        
                      itemBuilder: (BuildContext context, int index) {
                       

                      
                        return _buildMarketCard(
                          "assets/GameCard.JPG", 
                          "ISANJA GAME CARD",
                          "SPECIAL CARD",
                          "EDITION FOOTBALL"
                         );
                     
                      }),
           ),
      ]),
    );
  }

  _buildMarketCard(
    String img,
    String title,
    String type,
    String edition
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: <Widget>[
        //first row
        Row(
       
          crossAxisAlignment: CrossAxisAlignment.start,

          children: <Widget>[
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  // height: 40,
                  width: 150,
                  decoration: BoxDecoration(
                      color: Colors.brown,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(width: 0.5)),
                  child: Column(
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(img)
                          //Text("Game Card", style: TextStyle(color:Colors.white),),
                          ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(width:20, ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                 SizedBox(height:5, ),
                Row(children: <Widget>[
                    Text(title, style: TextStyle(fontWeight:FontWeight.bold),)
                ],),
                 SizedBox(height:5, ),
                 Row(children: <Widget>[
                   Text(type)
                ],),
                 SizedBox(height:5, ),
                 Row(children: <Widget>[
                   Text(edition)
                ],),
                 Row(children: <Widget>[
                 Container(
                 width: 200,
                child: RaisedButton(
                  elevation: 10.0,
                  onPressed: () {
                  },
                  //  padding: EdgeInsets.all(10.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),

                  color: Colors.green.shade800,
                  child: Text(
                    'Buy',
                    style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 1.5,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'BalooPaaji2',
                    ),
                  ),
                ),
              ),
                ],)
              ],
            )
          ],
        ),
       
      ]),
    );
  }
}
