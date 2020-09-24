import 'package:flutter_poc/CSS/Colors.dart';
import 'package:flutter_poc/CSS/textcss.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebViewPage extends StatefulWidget {
  final String url;
  final String name;
  WebViewPage(this.name, this.url);
  @override
  State<StatefulWidget> createState() {
    return _WebViewPageState();
  }
}

class _WebViewPageState extends State<WebViewPage> with WidgetsBindingObserver {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
        enableAppScheme: true,
        // userAgent: "mobile",
        withZoom: true,
      withLocalStorage: true,
      hidden: true,
      initialChild: Container(
        child: const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(themeColorYellow),
          ),
        ),
      ),
        url: widget.url, //payUrl, //cc_avenue_payment_url,
        appBar: new AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: new Text(
            widget.name,
            style: txtStyle(
              18,
              Colors.white,
            ),
          ),
          backgroundColor: themeColorBlue,
          iconTheme: new IconThemeData(
            color: Colors.white,
          ),
        ),
    );
  }
}
