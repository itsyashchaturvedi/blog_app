import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AccountsView extends StatefulWidget {
  final String url;
  final String name;

  AccountsView({super.key, required this.url,required this.name});

  @override
  State<AccountsView> createState() => _AccountsViewState();
}

class _AccountsViewState extends State<AccountsView> {
   final WebViewController _controller=WebViewController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(widget.name,style: TextStyle(color: Colors.white),),
        leading: IconButton(
          icon: FaIcon(FontAwesomeIcons.arrowLeft,color: Colors.white,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: WebViewWidget(controller: _controller
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.url)),
      ));
  }
}
