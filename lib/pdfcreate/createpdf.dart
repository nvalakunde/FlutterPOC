import 'dart:convert';
import 'dart:io';
import 'package:flutter_poc/CSS/Colors.dart';
import 'package:flutter_poc/CSS/textcss.dart';
import 'package:flutter_poc/pdfcreate/customviewer.dart';
import 'package:flutter_poc/pdfcreate/receipt.dart';
import 'package:flutter_poc/responsivescreen/responsive.dart';
import 'package:flutter_poc/utils/constantData.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as p;

class PDFOperationUI extends StatefulWidget {
  @override
  _PDFOperationUIState createState() => new _PDFOperationUIState();
}

class _PDFOperationUIState extends State<PDFOperationUI>
    with WidgetsBindingObserver {
  String apiData;
  String ay;
  String feeType;
  String childName;
  String currentAY;
  String childId;
  bool _isLoading = false;
  ReceiptList receiptList = ReceiptList();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    receiptList = null;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  DateTime backButtonPressTime;
  Future<bool> onWillPops() async {
    print("**********************");
    //await Future.delayed(Duration(seconds: 5));
    DateTime currentTime = DateTime.now();
    bool backButtonHasNotBeenPressedOrSnackBarHasBeenClosed =
        backButtonPressTime == null ||
            currentTime.difference(backButtonPressTime) > Duration(seconds: 3);

    if (backButtonHasNotBeenPressedOrSnackBarHasBeenClosed) {
      backButtonPressTime = currentTime;
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('Tap one more time to exit the app'),
          duration: Duration(seconds: 1),
        ),
      );
      return false;
    } else {
      print("Double Tapped");
      Navigator.of(context).pop(true);
    }
    return true;
  }

  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: null,
        //onWillPop: () =>onWillPop(context),
        child: Scaffold(
            // drawer: AppDrawer(0),
            //drawer: MyDrawer(currentProfilePic),
            appBar: AppBar(
              iconTheme: new IconThemeData(color: Colors.white),
              // shape: cardBorder(),
              backgroundColor: themeColorBlue,
              title: Text("Receipt",
                  style: txtStyle(18, whiteColor, fontWeight: FontWeight.bold)),
            ),
            body: receiptList == null
                ? Center(
                    child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(themeColorYellow),
                  ))
                : receiptList.learners == null
                    ? Center(
                        child: Text(
                        "No childs Available",
                      ))
                    : Container(
                        child: ListView(
                          shrinkWrap: true,
                          // This makes each child fill the full width of the screen
                          // crossAxisAlignment: CrossAxisAlignment.stretch,
                          // mainAxisSize: MainAxisSize.min,
                          children: [
                            receiptList.learners.length == 0
                                ? Center(
                                    child: Text("No Data Available"),
                                  )
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(
                                        height: setHeight(10),
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(setHeight(10)),
                                        child: Text(
                                          "Child",
                                          style: txtStyle(14, textPrimaryColor,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(setHeight(10)),
                                        decoration: ShapeDecoration(
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                width: 2.0,
                                                style: BorderStyle.solid,
                                                color: themeColorBlue),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(5.0),
                                            ),
                                          ),
                                        ),
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              left: setWidth(10),
                                              right: setWidth(10)),
                                          child: new DropdownButton<String>(
                                            underline: SizedBox(),
                                            isExpanded: true,
                                            icon: Icon(
                                              Icons.arrow_drop_down,
                                              color: themeColorYellow,
                                              size: setHeight(40),
                                            ),
                                            // icon: Icon(Icons.arrow_drop_down_circle, size: setHeight(20),),
                                            hint: new Text("  Chooose Child"),
                                            value: childName,
                                            // value: appField.applicationFormFieldValue!='null' && appField.applicationFormFieldValue!=''
                                            //       ?appField.applicationFormFieldValue:"Select ${appField.applicationFormFieldName}",
                                            onChanged: (String newValue) {
                                              // print(newValue);
                                              setState(() {
                                                childName = newValue;
                                                for (Learner my
                                                    in receiptList.learners) {
                                                  if (my.name == childName) {
                                                    childId = my.id.toString();
                                                  }
                                                }
                                              });
                                              //  print(txtOptionValue[index]);
                                            },

                                            items: receiptList.learners
                                                .map((Learner user) {
                                              return new DropdownMenuItem<
                                                  String>(
                                                value: user.name,
                                                child: Row(
                                                  children: <Widget>[
                                                    new Text(
                                                      user.name.length > 29
                                                          ? user.name.substring(
                                                                  0, 29) +
                                                              "..."
                                                          : user.name,
                                                      style: txtStyle(
                                                        14,
                                                        Colors.black,
                                                      ),
                                                      //new TextStyle(color: Colors.black,fontSize: setHeight(16)),
                                                      overflow:
                                                          TextOverflow.clip,
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(setHeight(10)),
                                        child: Text(
                                          "Academic Year",
                                          style: txtStyle(14, textPrimaryColor,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(setHeight(10)),
                                        decoration: ShapeDecoration(
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                width: 2.0,
                                                style: BorderStyle.solid,
                                                color: themeColorBlue),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(5.0),
                                            ),
                                          ),
                                        ),
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              left: setWidth(10),
                                              right: setWidth(10)),
                                          child: new DropdownButton<String>(
                                            underline: SizedBox(),
                                            isExpanded: true,
                                            icon: Icon(
                                              Icons.arrow_drop_down,
                                              color: themeColorYellow,
                                              size: setHeight(40),
                                            ),
                                            // icon: Icon(Icons.arrow_drop_down_circle, size: setHeight(20),),
                                            hint: new Text("  Chooose AY"),
                                            value: currentAY,
                                            // value: appField.applicationFormFieldValue!='null' && appField.applicationFormFieldValue!=''
                                            //       ?appField.applicationFormFieldValue:"Select ${appField.applicationFormFieldName}",
                                            onChanged: (String newValue) {
                                              // print(newValue);
                                              setState(() {
                                                currentAY = newValue;
                                              });
                                              //  print(txtOptionValue[index]);
                                            },

                                            items: receiptList.ayList
                                                .map((String user) {
                                              return new DropdownMenuItem<
                                                  String>(
                                                value: user,
                                                child: Row(
                                                  children: <Widget>[
                                                    new Text(
                                                      user.length > 29
                                                          ? user.substring(
                                                                  0, 29) +
                                                              "..."
                                                          : user,
                                                      style: txtStyle(
                                                        14,
                                                        Colors.black,
                                                      ),
                                                      //new TextStyle(color: Colors.black,fontSize: setHeight(16)),
                                                      overflow:
                                                          TextOverflow.clip,
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(setHeight(10)),
                                        child: Text(
                                          "Fee Type",
                                          style: txtStyle(14, textPrimaryColor,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(setHeight(10)),
                                        decoration: ShapeDecoration(
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                width: 2.0,
                                                style: BorderStyle.solid,
                                                color: themeColorBlue),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(5.0),
                                            ),
                                          ),
                                        ),
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              left: setWidth(10),
                                              right: setWidth(10)),
                                          child: new DropdownButton<String>(
                                            underline: SizedBox(),
                                            isExpanded: true,
                                            icon: Icon(
                                              Icons.arrow_drop_down,
                                              color: themeColorYellow,
                                              size: setHeight(40),
                                            ),
                                            // icon: Icon(Icons.arrow_drop_down_circle, size: setHeight(20),),
                                            hint:
                                                new Text("  Chooose Fee Type"),
                                            value: feeType,
                                            // value: appField.applicationFormFieldValue!='null' && appField.applicationFormFieldValue!=''
                                            //       ?appField.applicationFormFieldValue:"Select ${appField.applicationFormFieldName}",
                                            onChanged: (String newValue) {
                                              // print(newValue);
                                              setState(() {
                                                feeType = newValue;
                                              });
                                              //  print(txtOptionValue[index]);
                                            },

                                            items: receiptList.fees_type
                                                .map((String user) {
                                              return new DropdownMenuItem<
                                                  String>(
                                                value: user,
                                                child: Row(
                                                  children: <Widget>[
                                                    new Text(
                                                      user.length > 29
                                                          ? user.substring(
                                                                  0, 29) +
                                                              "..."
                                                          : user,
                                                      style: txtStyle(
                                                        14,
                                                        Colors.black,
                                                      ),
                                                      //new TextStyle(color: Colors.black,fontSize: setHeight(16)),
                                                      overflow:
                                                          TextOverflow.clip,
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              top: setHeight(20),
                                              bottom: setHeight(10)),
                                          width: setWidth(120),
                                          height: setHeight(50),
                                          child: RaisedButton(
                                              child: Text(
                                                "Fetch",
                                                style:
                                                    txtStyle(14, Colors.white,fontWeight: FontWeight.bold),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  _isLoading = true;
                                                });
                                                
                                              }),
                                        ),
                                      ),
                                      buildReceiptData(receiptList.receipts),
                                    ],
                                  ),
                          ],
                        ),
                      )));
  }

  Widget buildReceiptData(List<Receipt> recpList) {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: recpList == null ? 0 : recpList.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(setHeight(10.0)),
                child: Card(
                  child: Container(
                    margin: EdgeInsets.all(setHeight(10.0)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Receipt Number : " + recpList[index].receiptNo,
                              style: txtStyle(14, blackColor,
                                  fontWeight: FontWeight.w900),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                IconButton(
                              onPressed: () {
                                print("reciptid");
                                print(recpList[index]);

                                var params = Map<String, String>();
                                params["receipt_id"] =
                                    recpList[index].id.toString();
                                
                                    setState(() {
                                      exportPdf(
                                          recpList,
                                          index,
                                          ['receipt_data'],
                                          ["comp_list"],
                                          ["trans_list"],
                                          feeType,
                                          true
                                          );
                                });
                              },
                              icon: Icon(
                                Icons.file_download,
                                size: setHeight(28),
                                color: themeColorYellow,
                              ),
                            ),
                            SizedBox(
                              width: setWidth(10),
                            ),
                            IconButton(
                              onPressed: () {
                                print("reciptid");
                                print(recpList[index]);

                                var params = Map<String, String>();
                                params["receipt_id"] =
                                    recpList[index].id.toString();

                                    setState(() {

                                      exportPdf(
                                          recpList,
                                          index,
                                          'receipt_data',
                                          "comp_list",
                                          "trans_list",
                                          feeType,
                                          false
                                          );
                                });
                              },
                              icon: Icon(Icons.file_download,
                                size: setHeight(26),
                                color: themeColorYellow,
                              ),
                            ),
                              ],
                            )
                            // Text(
                            //   "Receipt Number : " + recpList[index].receiptNo,
                            //   style: txtStyle(14, blackColor,
                            //       fontWeight: FontWeight.w900),
                            // ),
                          ],
                        ),
                        Divider(),
                        SizedBox(height: setHeight(10)),
                        Text(
                          "Standard : " + recpList[index].standard,
                          style: txtStyle(
                            14,
                            blackColor,
                          ),
                        ),
                        SizedBox(height: setHeight(10)),
                        Text(
                          "Date : " + recpList[index].receiptDate,
                          style: txtStyle(
                            14,
                            blackColor,
                          ),
                        ),
                        SizedBox(height: setHeight(10)),
                        Text("Amount : \u20B9 " + recpList[index].amount,
                            style: txtStyle(
                              14,
                              blackColor,
                            )),
                        SizedBox(height: setHeight(10)),
                      ],
                    ),
                  ),
                  elevation: 9,
                ),
              ),
            ],
          );
        });
  }

  exportPdf(var reciptlist, var index, var reciptdata, var complist1,
      var translist, var feetype, bool downld) async {
    List<List<String>> tdata = new List();
    List<List<String>> tdata1 = new List();
    List<List<String>> tdata2 = new List();
    tdata.add(<String>['Srno', 'Component', 'Amount']);
    tdata2.add(<String>[
      'Payment Mode',
      'DD No./Cheque No./Transaction No.',
      'Date',
      'Amount(Rs.)',
      'Drawn On'
    ]);
    tdata2.add(<String>[
      translist[0]['mode'].toString(),
      translist[0]['transid'].toString(),
      translist[0]['date'].toString(),
      translist[0]['amount'].toString(),
      translist[0]['bank'].toString()
    ]);
    int x = 0;
    for (var i = 0; i < complist1.length; i++) {
      x = i;
      tdata.add(<String>[
        i.toString(),
        complist1[i]['name'].toString(),
        complist1[i]['amount'].toString()
      ]);
    }
    x++;
    tdata1.add(<String>[
      "Total",
      reciptlist[index].amount.toString(),
    ]);

    print(tdata);
    final p.Document pdf = p.Document(deflate: zlib.encode);
    pdf.addPage(p.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return p.Container(
              alignment: p.Alignment(0.0, 1.0),
              child: p.Column(children: <p.Widget>[
                p.Row(
                    mainAxisAlignment: p.MainAxisAlignment.center,
                    children: <p.Widget>[
                      p.Text("Receipt No:",
                          style: p.TextStyle(fontWeight: p.FontWeight.bold)),
                      p.Text(reciptlist[index].receiptNo)
                    ]),
                p.SizedBox(height: 10.0),
                p.Row(
                    mainAxisAlignment: p.MainAxisAlignment.spaceBetween,
                    children: <p.Widget>[
                      p.Column(children: <p.Widget>[
                        p.Row(children: <p.Widget>[
                          p.Text("GR.No: ",
                              style:
                                  p.TextStyle(fontWeight: p.FontWeight.bold)),
                          p.Text(reciptdata['stud_reg_no']),
                        ])
                      ]),
                      p.Column(children: <p.Widget>[
                        p.Row(children: <p.Widget>[
                          p.Text("Receipt Date: ",
                              style:
                                  p.TextStyle(fontWeight: p.FontWeight.bold)),
                          p.Text(reciptdata['receipt_date']),
                        ])
                      ])
                    ]),
                p.SizedBox(height: 10.0),
                p.Row(
                    mainAxisAlignment: p.MainAxisAlignment.center,
                    children: <p.Widget>[
                      p.Text(
                          "Recieved with thanks application " +
                              feeType +
                              " for the " +
                              feeType +
                              " year " +
                              reciptdata['ay'] +
                              " from",
                          style: p.TextStyle(fontSize: 10.0))
                    ]),
                p.SizedBox(height: 10.0),
                p.Row(
                    mainAxisAlignment: p.MainAxisAlignment.center,
                    children: <p.Widget>[
                      p.Text(reciptdata['stud_name'],
                          style: p.TextStyle(
                              fontWeight: p.FontWeight.bold, fontSize: 16.0))
                    ]),
                p.Container(
                    padding:
                        p.EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
                    child: p.Column(children: <p.Widget>[
                      p.Table.fromTextArray(context: context, data: tdata),
                      p.Table.fromTextArray(context: context, data: tdata1),
                      p.SizedBox(height: 20.0),
                      p.Table.fromTextArray(context: context, data: tdata2),
                    ]))
              ]));
        }));
    Future<Directory> downloadsDirectory = DownloadsPathProvider.downloadsDirectory;
    Directory _downloadsDirectory = await DownloadsPathProvider.downloadsDirectory;
    String dir;
    if(Platform.isIOS){
      dir = (await getApplicationDocumentsDirectory()).absolute.path;
    }else{
      dir = _downloadsDirectory.path;
    }
    final String path =
        '$dir/${reciptdata['ay']}_${reciptdata['stud_name']}_payment_receipt.pdf';
    print(path);
    final File file = File(path);
    List<String> basename=path.split("/");
    int len=basename.length;
    String fileName=basename[len-2]+"/"+basename[len-1];
    await file.writeAsBytes(pdf.save());
    pdf.save();
    if (downld) {
      if(Platform.isIOS){
        toastFunstion(context, "File Saved in $fileName");
      }else{
        toastFunstion(context, "File Saved in Downloads");
      }
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CustomPdfViewer(path),
        ),
      );
    }
  }
}
