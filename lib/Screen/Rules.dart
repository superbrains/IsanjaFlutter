import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:isanja/Screen/RawText.dart'as rules;

class Rules extends StatefulWidget {
  @override
  _RulesState createState() => _RulesState();
}

class _RulesState extends State<Rules> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("RULES & REGULATION", style:TextStyle(color: Colors.white))),
        backgroundColor: Colors.green.shade800,
       
      ),
      body: ListView(children: <Widget>[
          HtmlWidget(rules.regHtml)
      ],),
    );
  }
}