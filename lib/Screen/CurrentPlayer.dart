import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
class CurrentPlayer extends StatefulWidget {
  @override
  _CurrentPlayerState createState() => _CurrentPlayerState();
}

class _CurrentPlayerState extends State<CurrentPlayer> with TickerProviderStateMixin{
   AnimationController controller;
    String get timerString {
    Duration duration = controller.duration * controller.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 30),
    );
 
   
  }
  @override
  Widget build(BuildContext context) {
     SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("ISANJA", style:TextStyle(color: Colors.white))),
        backgroundColor: Colors.green.shade800,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.notifications),
          )
        ],
      ),
    
      body: ListView(
        children:<Widget>[
            Stack(
              children: <Widget>[
                Container(
                  child: 
                Image.asset("assets/board.png")
                
                ),
                Positioned(left:310, child:
                Column(children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top:8.0),
                        child: Text("ISANJA POINT", style: TextStyle(color:Colors.white),),
                      ),
                    ],
                  ),
                   Row(
                    children: <Widget>[
                      Text("23", style: TextStyle(color:Colors.white),textAlign: TextAlign.center,),
                    ],
                  )
                ],)
                )
              ],
              
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Timer",style: TextStyle(color: Colors.green.shade800, fontSize: 20),),
                ],
              ),
            ),
          
              Container(
                height: 90,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Align(
                        alignment: FractionalOffset.center,
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Stack(
                            children: <Widget>[
                              Positioned.fill(
                                child: AnimatedBuilder(
                                  animation: controller,
                                  builder: (BuildContext context, Widget child) {
                                    return CustomPaint(
                                     
                                        painter: TimerPainter(
                                      animation: controller,
                                      backgroundColor: Colors.green,
                                      color: Colors.grey
                                    ));
                                  },
                                ),
                              ),
                              Align(
                                alignment: FractionalOffset.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                   
                                    AnimatedBuilder(
                                        animation: controller,
                                        builder: (BuildContext context, Widget child) {
                                          return Text(
                                            timerString,
                                            style: TextStyle(color:Colors.green, fontSize: 20),

                                          
                                          );
                                        }),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
               SizedBox(height:30),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          
                      children: <Widget>[
//                       Column(children:<Widget>[
// Text("sssssssssss, ", style: TextStyle(color:Colors.white),)
//                       ]),
            //           Column(
            //             crossAxisAlignment: CrossAxisAlignment.center,
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: <Widget>[
            //               Container(
            //   margin: EdgeInsets.all(8.0),
            //   child: Row(
            //   //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children: <Widget>[
            //               FloatingActionButton(
            //                 child: AnimatedBuilder(
            //                   animation: controller,
            //                   builder: (BuildContext context, Widget child) {
            //                     return Icon(controller.isAnimating
            //                         ? Icons.pause
            //                         : Icons.play_arrow);

            //                     // Icon(isPlaying
            //                     // ? Icons.pause
            //                     // : Icons.play_arrow);
            //                   },
            //                 ),
            //                 onPressed: () {
            //                   // setState(() => isPlaying = !isPlaying);

            //                   if (controller.isAnimating) {
            //                     controller.stop(canceled: true);
            //                   } else {
            //                     controller.reverse(
            //                         from: controller.value == 0.0
            //                             ? 1.0
            //                             : controller.value);
            //                   }
            //                 },
            //               )
            //     ],
            //   ),
            // ),
            //             ],
            //           ),
           
                       GestureDetector(
                         onTap: (){
                           _showVersionDialog(context);
                         },
                         child: Padding(
                          padding: const EdgeInsets.only(left:0.0),
                          child: Container(
                           // height: 40,
                            width: 120,
                             decoration: BoxDecoration(
                                color: Colors.brown,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(width: 0.5)),
                    child: Column(
                          children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset("assets/GameCard.JPG")
                                //Text("Game Card", style: TextStyle(color:Colors.white),),
                              ),
                          ],
                    ),
                          ),
                      ),
                       ),
                    

                        GestureDetector(
                          onTap: (){
                            _showWildCardDialog(context);
                          },
                          child: Padding(
                          padding: const EdgeInsets.only(left:0.0),
                          child: Container(
                           
                           // height: 40,
                            width: 120,
                             decoration: BoxDecoration(
                                color: Colors.green.shade800,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(width: 0.5)),
                    child: Column(
                          children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset("assets/WildCard.JPG")
                                //Text("Game Card", style: TextStyle(color:Colors.white),),
                              ),
                          ],
                    ),
                          ),
                      ),
                        )
                      ],
                    ),
                  ),
           
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                // Padding(
                //   padding: const EdgeInsets.only(right:8.0),
                //   child: Container(
                //     height:200,
                    
                //      decoration: BoxDecoration(
                //             border: Border.all(
                //           width: 0.5,
                //         )),
                //       child: Text("Game Card"),
                //   )
                // ),
              ],
            )
        ]
         
      ),
     bottomNavigationBar: BottomAppBar(
        color: Colors.green.shade800,
        child:Container(
         decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
      
      ),
          height: 170,
          child: 
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                //first column
              
                Padding(
                  padding: const EdgeInsets.only(left:15.0, top: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:<Widget>[
                    Row(children: <Widget>[
                      Text("Current Player", style: TextStyle(color:Colors.grey, fontWeight: FontWeight.bold),)
                    ],),
                    SizedBox(height:5),
                      Row(children: <Widget>[
                      Text("John Doe", style: TextStyle(color:Colors.white),)
                    ],),
                     SizedBox(height:5),
                      Row(children: <Widget>[
                      Text("Team", style: TextStyle(color:Colors.grey,fontWeight: FontWeight.bold),)
                    ],),
                     SizedBox(height:5),
                      Row(children: <Widget>[
                      Text("Team Blue", style: TextStyle(color:Colors.white),)
                    ],)
                  ]),
                ),
                 //second column
                 SizedBox(width:15),
                Padding(
                 padding: const EdgeInsets.only(left:15.0, top: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                    children:<Widget>[
                      Row(children: <Widget>[
                        Text("Wild Card", style: TextStyle(color:Colors.grey, fontWeight: FontWeight.bold),)
                      ],),
                      SizedBox(height:5),
                        Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                        Text("1", style: TextStyle(color:Colors.white),textAlign: TextAlign.center,)
                      ],),
                       SizedBox(height:5),
                        Row(children: <Widget>[
                        Text("Game Card", style: TextStyle(color:Colors.grey,fontWeight: FontWeight.bold),)
                      ],),
                       SizedBox(height:5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                        Text("22", style: TextStyle(color:Colors.white),)
                      ],)
                  ]),
                ),
                //3rd column
        
      
              ],),
              SizedBox(height:20),
              Padding(
                padding: const EdgeInsets.only(left:70.0),
                child: Row(children: <Widget>[
                  Text("Next Player:", style: TextStyle(color:Colors.white, fontSize: 14),),
                  SizedBox(width:5),
                   Text("John Doe", style: TextStyle(color:Colors.white, fontSize: 14),),
                     SizedBox(width:10),
                   Text("(Yellow team)", style: TextStyle(color:Colors.white, fontSize: 14),),

                    
                ],),
              )
            ],
          ),
          
          ),
          
     ),
    );
  }
  _showVersionDialog(context) {
 
   showDialog<String>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      String title = "Isanja Game Card";

      return 
      Stack(
        children: <Widget>[
          // Positioned(left: 50, child: Icon(Icons.close, size: 20,),),
          CupertinoAlertDialog(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(title),
                      SizedBox(width:20),
                    GestureDetector(onTap: (){
                      Navigator.pop(context);
                    },   child: Icon(Icons.close))
                     
                    ],
                  ),
                  content:    Padding(
                              padding: const EdgeInsets.only(left:0.0),
                              child: Container(
                               
                                height: 130,
                               width: 250,
                                 decoration: BoxDecoration(
                                    color: Colors.green.shade800,
                                            borderRadius: BorderRadius.circular(8),
                                            border: Border.all(width: 0.5)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                   mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                  children: <Widget>[
                                Text("TENI MAKANAKI ", style: TextStyle(color:Colors.white),),
                               
                                  ],
                                ),
                                SizedBox(height:5),
                                Row(
                               
                                  children: <Widget>[
                                Text("UBA ", style: TextStyle(color:Colors.white),),
                               
                                  ],
                                ),
                                 SizedBox(height:5),
                                 Row(
                                  children: <Widget>[
                                Text("LAGOS ", style: TextStyle(color:Colors.white),),
                               
                                  ],
                                ),
                                 SizedBox(height:5),
                                 Row(
                                  children: <Widget>[
                                Text("BUHARI ", style: TextStyle(color:Colors.white),),
                               
                                  ],
                                ),
                                 SizedBox(height:5),
                                 Row(
                                  children: <Widget>[
                                Text("TENI MAKANAKI ", style: TextStyle(color:Colors.white),),
                              
                                  ],
                                ),
                                ],),
                              Column(children: <Widget>[
                               Row(
                                  children: <Widget>[
                                Text("2pts ", style: TextStyle(color:Colors.white),),
                                  ],
                                ),
                                  SizedBox(height:5),
                                 Row(
                                  children: <Widget>[
                                Text("2pts ", style: TextStyle(color:Colors.white),),
                                  ],
                                ),
                                  SizedBox(height:5),
                                 Row(
                                  children: <Widget>[
                                Text("2pts ", style: TextStyle(color:Colors.white),),
                                  ],
                                ),
                                  SizedBox(height:5),
                                 Row(
                                  children: <Widget>[
                                Text("2pts ", style: TextStyle(color:Colors.white),),
                                  ],
                                ),
                                  SizedBox(height:5),
                                 Row(
                                  children: <Widget>[
                                Text("2pts ", style: TextStyle(color:Colors.white),),
                              
                                  ],
                                  
                                ),
                              ],)
                               
                              
                              ],
                            ),
                          ),
                              ),
                            ),
                  // actions: <Widget>[
                   
                  // ],
                ),
        ],
      );
        
    },
  );
}
  _showWildCardDialog(context) {
 
   showDialog<String>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      String title = "Wild Card";

      return 
      Stack(
        children: <Widget>[
          // Positioned(left: 50, child: Icon(Icons.close, size: 20,),),
          CupertinoAlertDialog(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(title),
                      SizedBox(width:20),
                    GestureDetector(onTap: (){
                      Navigator.pop(context);
                    },   child: Icon(Icons.close))
                     
                    ],
                  ),
                  content:    Padding(
                              padding: const EdgeInsets.only(left:0.0),
                              child: Container(
                               
                                height: 130,
                               width: 250,
                                 decoration: BoxDecoration(
                                    color: Colors.green.shade800,
                                            borderRadius: BorderRadius.circular(8),
                                            border: Border.all(width: 0.5)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                   mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                  children: <Widget>[
                                Text("Double Point Score", style: TextStyle(color:Colors.white),),
                               
                                  ],
                                ),
                                SizedBox(height:5),
                                Row(
                               
                                  children: <Widget>[
                                Text("Hint  ", style: TextStyle(color:Colors.black, fontWeight: FontWeight.bold),),
                               
                                  ],
                                ),
                                 SizedBox(height:5),
                                 Row(
                                  children: <Widget>[
                                Text("Double your team next score", style: TextStyle(color:Colors.white),),
                               
                                  ],
                                ),
                                
                               
                                ],),
                              
                               
                              
                              ],
                            ),
                          ),
                              ),
                            ),
                  // actions: <Widget>[
                   
                  // ],
                ),
        ],
      );
        
    },
  );
}
}
class CustomListTile extends StatelessWidget {
  IconData icon;
  String text;
  Function onTap;

  CustomListTile(this.icon, this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15.0, bottom: 6),
      child: Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade400)),
        ),
        child: InkWell(
          splashColor: Colors.green.shade900,
          onTap: onTap,
          child: Container(
            height: 40.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(icon, color: Colors.green),
                    Padding(
                      padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                      child: Text(
                        text,
                        style:
                            TextStyle(fontSize: 14.0, fontFamily: 'Monseratti', color: Colors.green.shade800),
                      ),
                    )
                  ],
                ),
                Icon(Icons.arrow_right, color: Colors.green,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class TimerPainter extends CustomPainter {
  TimerPainter({
    this.animation,
    this.backgroundColor,
    this.color,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final Color backgroundColor, color;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 5.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
    paint.color = color;
    double progress = (1.0 - animation.value) * 2 * math.pi;
    canvas.drawArc(Offset.zero & size, math.pi * 1.5, -progress, false, paint);
  }

  @override
  bool shouldRepaint(TimerPainter old) {
    return animation.value != old.animation.value ||
        color != old.color ||
        backgroundColor != old.backgroundColor;
  }
}