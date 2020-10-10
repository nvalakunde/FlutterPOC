import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_poc/CSS/Colors.dart';
import 'package:signature/signature.dart';

class SignaturePad extends StatefulWidget {
  @override
  _SignaturePadState createState() => _SignaturePadState();
}

class _SignaturePadState extends State<SignaturePad> {
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 5,
    penColor: themeColorYellow,
    exportBackgroundColor: themeColorBlue,
  );
  var data;
  @override
  void initState() {
    super.initState();
    _controller.addListener(() => {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Signature Pad Example"),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 30,
            child: Center(
              child: Text('Signature Canvas'),
            ),
          ),
          //SIGNATURE CANVAS
          Signature(
            controller: _controller,
            height: 300,
            backgroundColor: Colors.lightBlueAccent,
          ),
          //OK AND CLEAR BUTTONS
          Container(
            decoration: const BoxDecoration(color: Colors.black),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                //SHOW EXPORTED IMAGE IN NEW ROUTE
                IconButton(
                  icon: const Icon(Icons.check),
                  color: Colors.blue,
                  onPressed: () async {
                    if (_controller.isNotEmpty) {

                      setState(() {
                        
                      });
                      data = await _controller.toPngBytes();
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (BuildContext context) {
                      //       return Scaffold(
                      //         appBar: AppBar(),
                      //         body: Center(
                      //             child: Container(
                      //                 color: Colors.grey[300],
                      //                 child: Image.memory(data))),
                      //       );
                      //     },
                      //   ),
                      // );
                    }
                  },
                ),
                //CLEAR CANVAS
                IconButton(
                  icon: const Icon(Icons.clear),
                  color: Colors.blue,
                  onPressed: () {
                    setState(() => _controller.clear());
                  },
                ),
              ],
            ),
          ),
           
          data!=null?
          Column(
            children: [
              Container(
            height: 30,
            child: Center(
              child: Text('Created Signature'),
            ),
          ),
              Center(
                child: Container(
                  color: Colors.grey[300],
                  child: Image.memory(data),
                ),
              ),
            ],
          ):Container(),
        ],
      ),
    );
  }
}
