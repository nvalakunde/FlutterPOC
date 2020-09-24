import 'package:flutter/material.dart';
import 'package:flutter_poc/responsivescreen/responsive.dart';

class RepeatWidget extends StatefulWidget {
  _RepeatWidgetState createState() => new _RepeatWidgetState();
}

class _RepeatWidgetState extends State<RepeatWidget> {
  List<String> textData = ["A", "B", "C", "D"];
  TextEditingController txtControll = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: txtControll,
                    ),
                  ),
                  RaisedButton(
                    onPressed: () {
                      setState(() {
                        textData.add(txtControll.text);
                      });
                    },
                    child: Text("Add"),
                  ),
                ],
              ),
              ListView(
                shrinkWrap: true,
                children: List.generate(textData.length, (index) {
                  return Container(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Card(
                            elevation: 5,
                            child: Center(
                              child: Text(
                                textData[index],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: setWidth(15),),
                        RaisedButton(
                          onPressed: () {
                            setState(() {
                              textData.remove(textData[index]);
                            });
                          },
                          child: Text("Delete"),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ],
          ),
        ));
  }
}
