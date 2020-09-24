import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget showMaterialDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) => new AlertDialog(
      title: new Text("Material Dialog"),
      content: new Text("Default Dialog!"),
      actions: <Widget>[
        FlatButton(
          child: Text('Close me!'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    ),
  );
}

Widget showCupertinoDialog(BuildContext context) {
   showDialog(
    context: context,
    builder: (_) => new CupertinoAlertDialog(
      title: new Text("Cupertino Dialog"),
      content: new Text("iOS Dialog!"),
      actions: <Widget>[
        FlatButton(
          child: Text('Close me!'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    ),
  );
}
