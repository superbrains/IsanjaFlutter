import 'package:flutter/material.dart';
import 'package:isanja/Class/CategoryClass.dart';
import 'package:isanja/Class/WordClass.dart';
import 'package:isanja/Service/WordServ.dart';
import 'package:shimmer/shimmer.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:isanja/global.dart' as global;

class WordDatabase extends StatefulWidget {
  @override
  _WordDatabaseState createState() => _WordDatabaseState();
}

class _WordDatabaseState extends State<WordDatabase> {
  List<WordClass> filteredWord = new List<WordClass>();
  TextEditingController wordController = new TextEditingController();
  TextEditingController pointController = new TextEditingController();
  List<CategoryClass> filteredCategories = List();
  bool searching = true;
  int categoryId;
  String categoryName;
  ProgressDialog pr;
  final _formKey = GlobalKey<FormState>();
  bool formValid = true;
  getWordFromServer() async {
    var res = await WordService.getAllWords();
    setState(() {
      filteredWord = res;
      searching = false;
    });
  }

  Future<bool> simpledialog(str) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
            title: Text('Message'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  str,
                  style: TextStyle(fontSize: 10, color: Colors.green.shade600),
                ),
                SizedBox(
                  height: 10.0,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return WordDatabase();
                    }));
                  },
                  child: Container(
                    height: 40.0,
                    child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.green.shade900,
                        color: Colors.green.shade600,
                        elevation: 7.0,
                        child: Center(
                          child: Text(
                            'OK',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'MontSerrat'),
                          ),
                        )),
                  ),
                ),
              ],
            )));
  }

  Future<bool> simpledialog2(str) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
            title: Text('Message'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  str,
                  style: TextStyle(fontSize: 10, color: Colors.green.shade600),
                ),
                SizedBox(
                  height: 10.0,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 40.0,
                    child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.green.shade900,
                        color: Colors.green.shade600,
                        elevation: 7.0,
                        child: Center(
                          child: Text(
                            'OK',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'MontSerrat'),
                          ),
                        )),
                  ),
                ),
              ],
            )));
  }
//This is this
  getWordList() {
    if (searching) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 30),
              child: Container(
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    // Opacity(
                    //     opacity: 0.5,
                    //     child: Image.asset('assets/img/bg.png')
                    // ),

                    Shimmer.fromColors(
                      period: Duration(milliseconds: 1500),
                      baseColor: Colors.white,
                      highlightColor: Colors.green.shade600,
                      child: Container(
                        padding: EdgeInsets.all(16.0),
                        child: Image(
                            image: AssetImage("assets/Logo.png"),
                            width: 200,
                            height: 220),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    } else if (filteredWord.length == 0 || filteredWord.length == null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 30),
            child: Center(
              child: Text(
                'Unavailable',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'BalooPaaji2',
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return ListView.builder(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          // controller: myServiceScrollController,

          // itemExtent: 5,
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(10.0),
          itemCount: filteredWord.length,
          itemBuilder: (BuildContext context, int index) {
            return _buildWordCard(
                filteredWord[index].word,
                filteredWord[index].category.category,
                filteredWord[index].points,
                index);
          });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWordFromServer();
    setState(() {
      filteredCategories = global.categories;
    });
  }

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: true);
    pr.style(
        message: 'Processing...',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: Container(
            padding: EdgeInsets.all(8.0), child: CircularProgressIndicator()),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));
    Widget carousel = new Container(
        // height: 200,
        child: Container(
      decoration: BoxDecoration(
          color: Colors.green.shade800,
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(20.0),
            bottomLeft: Radius.circular(20.0),
          )),
      //  color: Colors.blue.shade900,
      height: 110,
      child: Column(children: <Widget>[
        Container(
          // color: Colors.blue.shade900,
          child: Material(
            color: Colors.green.shade800,
            elevation: 7.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Text('ISANJA WORDS',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'BalooPaaji2',
                          color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
        Container(
          color: Colors.green.shade800,
          child: Padding(
            padding: EdgeInsets.only(left: 15.0, right: 15.0),
            child: Material(
              elevation: 7.0,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              child: TextField(
                //  controller: _searchController,
                decoration: InputDecoration(
                  border: InputBorder.none,

                  //prefixIcon: Icon(Icons.search, color: Colors.red, size: 30.0, ),
                  contentPadding:
                      EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
                  hintText: 'Search by keyword...',
                ),

                onChanged: (string) {
                  setState(() {
                    filteredWord = filteredWord
                        .where((u) => (u.category.category
                                .toLowerCase()
                                .contains(string.toLowerCase()) ||
                            (u.word
                                    .toLowerCase()
                                    .contains(string.toLowerCase()) ||
                                (u.points
                                    .toString()
                                    .toLowerCase()
                                    .contains(string.toLowerCase())))))
                        .toList();
                  });
                },
              ),
            ),
          ),
        ),
      ]),
    ));
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child:
                Text("WORD DATABASE", style: TextStyle(color: Colors.white))),
        backgroundColor: Colors.green.shade800,
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              creteWordDialog();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.add),
            ),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(child: carousel),
          Expanded(
            child: ListView(
                children: <Widget>[SizedBox(height: 30), getWordList()]),
          ),
        ],
      ),
    );
  }

  _buildWordCard(String word, String category, double points, int index
      // String description
      ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          elevation: 10.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  //first row
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Word",
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Cateegory",
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Point :",
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Descriptions :",
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        word,
                        style: TextStyle(color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      Text(
                        category,
                        style: TextStyle(color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      Text(
                        points.toString(),
                        style: TextStyle(color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      //  Container(
                      //    width: MediaQuery.of(context).size.width-127,

                      //    child: Text(description, style: TextStyle(color: Colors.grey),textAlign: TextAlign.center,)),
                    ],
                  ),
                ]),
          ),
        ),
      ),
    );
  }

  void creteWordDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return ListView(
          children: <Widget>[
            AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Text("Create Category",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'BalooPaaji2',
                          color: Colors.green.shade600)),
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.green.shade600),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              content: Stack(
                children: <Widget>[
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                          // height: 200,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text("Enter Word"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8, right: 15.0),
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "Fill Required Space";
                                      }
                                      return null;
                                    },
                                    // keyboardType: TextInputType.number,
                                    textInputAction: TextInputAction.done,
                                    style: new TextStyle(color: Colors.black),
                                    cursorColor: Colors.black,
                                    controller: wordController,
                                    decoration: InputDecoration(
                                      hintText: 'Word',
                                      contentPadding: EdgeInsets.fromLTRB(
                                          8.0, 10.0, 20.0, 10.0),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text("Points"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8, right: 15.0),
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "Fill Required Space";
                                      }
                                      return null;
                                    },
                                    // keyboardType: TextInputType.number,
                                    textInputAction: TextInputAction.done,
                                    style: new TextStyle(color: Colors.black),
                                    cursorColor: Colors.black,
                                    keyboardType: TextInputType.number,
                                    controller: pointController,
                                    decoration: InputDecoration(
                                      hintText: 'Points',
                                      contentPadding: EdgeInsets.fromLTRB(
                                          8.0, 10.0, 20.0, 10.0),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text("Select Category"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8, right: 15.0),
                                  child: SearchableDropdown.single(
                                    underline: Padding(
                                      padding: EdgeInsets.all(5),
                                    ),
                                    items: filteredCategories
                                        .map((value) => DropdownMenuItem(
                                              child: Text(value.category),
                                              value: value.id,
                                            ))
                                        .toList(),
                                    onChanged: (int value) {
                                      categoryId = value;
                                    },
                                    isExpanded: false,
                                    hint: Text('Select  Category'),
                                  ),
                                ),
                                SizedBox(height: 20),
                                GestureDetector(
                                  onTap: () async {
                                    if (_formKey.currentState.validate()) {
                                      setState(() {
                                        formValid = true;
                                      });
                                      pr.show();

                                      // call api
                                      var res = await WordService.postWord(
                                          wordController.text,
                                          double.parse(pointController.text),
                                          categoryId);

                                      if (res > 1) {
                                        pr.hide();
                                        return simpledialog(
                                            "Category  Created");
                                      } else {
                                        pr.hide();
                                        simpledialog2("Error");
                                      }
                                    }
                                  },
                                  child: Center(
                                    child: Container(
                                      width: 180,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: Colors.green.shade900,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      child: Center(
                                          child: Text("Create",
                                              style: TextStyle(
                                                  color: Colors.white))),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
