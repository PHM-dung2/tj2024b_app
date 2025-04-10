
import 'package:flutter/material.dart';

class Write extends StatefulWidget{
  @override
  _WriteState createState() {
    return _WriteState();
  }
}

class _WriteState extends State< Write >{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: Text("비품 등록 페이지"),),
    );
  }
}