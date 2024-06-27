import 'package:flutter/material.dart';

class PageNotFound extends StatelessWidget {
  const PageNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title:
                Text("Page Not Found", style: TextStyle(color: Colors.white)),
            centerTitle: true,
            backgroundColor: Color.fromARGB(255, 23, 25, 45)),
        body: Center(child: Text("Page Not Found")));
  }
}
