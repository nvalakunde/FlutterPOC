import 'package:flutter/material.dart';

class NavigateDrawerUI extends StatefulWidget {
  @override
  _NavigateDrawerUIState createState() => _NavigateDrawerUIState();
}

class _NavigateDrawerUIState extends State {
  final PageController ctrl = PageController(initialPage: 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("NavigateDrawerUI"),
        
      ),
      body: PageView(
          // scrollDirection: Axis.vertical,
          controller: ctrl,
          
          children: [
            Container(
              color: Colors.green,
              child: Text("Page 1"),
            ),
            Container(
              color: Colors.blue,
              child: Text("Page 2"),
            ),
            Container(
              color: Colors.orange,
              child: Text("Page 3"),
            ),
            Container(
              color: Colors.red,
              child: Text("Page 4"),
            ),
          ]),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: PageView(
              // scrollDirection: Axis.vertical,
              // controller: ctrl,
              children: [
            Container(
              color: Colors.green,
              child: Text("Page 1"),
            ),
            Container(
              color: Colors.blue,
              child: Text("Page 2"),
            ),
            Container(
              color: Colors.orange,
              child: Text("Page 3"),
            ),
            Container(
              color: Colors.red,
              child: Text("Page 4"),
            )
          ])),
    );
  }
}
