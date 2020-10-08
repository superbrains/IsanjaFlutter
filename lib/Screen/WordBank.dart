import 'package:flutter/material.dart';
import 'package:isanja/Class/CategoryClass.dart';
import 'package:isanja/Service/CategoryService.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shimmer/shimmer.dart';

class WordBank extends StatefulWidget {
  @override
  _WordBankState createState() => _WordBankState();
}

class _WordBankState extends State<WordBank> {

TextEditingController  categoryController =  new TextEditingController();
List<CategoryClass> filteredCategory = new List <CategoryClass>();

 bool formValid = true;
 bool searching = true;
 ProgressDialog pr;
 final _formKey = GlobalKey<FormState>();
 
getCategoryFromServer()async{
  var resp = await CategoryService.getAllCategory();
  setState(() {
    filteredCategory = resp;
    searching =  false;
  });
}


@override
void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryFromServer();
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
                      return WordBank();
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return WordBank();
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
 getCategoryList() {
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
    } else if (filteredCategory.length == 0 || filteredCategory.length == null) {
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
          itemCount: filteredCategory.length,
          itemBuilder: (BuildContext context, int index) {
            return _buildWordCard(
               filteredCategory[index].category,
                index);
          });
    }
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
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("WORD BANK", style:TextStyle(color: Colors.white))),
        backgroundColor: Colors.green.shade800,
        actions: <Widget>[
          GestureDetector(
            onTap: (){
              _creteCategoryDialog();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.add),
            ),
          )
        ],
      ),
      body:ListView(children:<Widget>[
          getCategoryList()
      ]) ,
    );
  }
   _buildWordCard(
    String title,
    int index
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape:  RoundedRectangleBorder(
       borderRadius: BorderRadius.circular(10.0)),
        elevation: 10.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: <Widget>[
            //first row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
               Text(title, style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.center,)
              ],
            ),
            SizedBox(height:10)
           
          ]),
        ),
      ),
    );
  }
  _creteCategoryDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Text("Create Category",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'BalooPaaji2',
                      color: Colors.green.shade600)),
              IconButton(
                icon: Icon(
                  Icons.close,
                  color: Colors.green.shade600
                ),
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
                              child: Text("Enter Category"),
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
                                controller: categoryController,
                                decoration: InputDecoration(
                                  hintText: 'Category',
                                  contentPadding: EdgeInsets.fromLTRB(
                                      8.0, 10.0, 20.0, 10.0),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                ),
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
                                  var res = await CategoryService.postCategory(categoryController.text);
                                  if(res >1){
                                    pr.hide();
                                      return simpledialog(
                                  "Category  Created");
                                       
                                  }
                               else{
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
        );
      },
    );
    
  }
}