import 'package:flutter/material.dart';
import 'package:tractian_challenge/components/customized_button.dart';

class Home extends StatelessWidget {
  List<Map<String, dynamic>> data = [];
  Home({required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Image.asset("images/logo.png", width: 200.0),
            centerTitle: true,
            backgroundColor: Color.fromARGB(255, 23, 25, 45)),
        body: Container(
            padding: EdgeInsets.all(20.0),
            width: double.infinity,
            child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                      child: CustomizedButton(
                          text: data[index]['name'],
                          icon: Icons.device_hub,
                          height: 80.0,
                          width: double.infinity,
                          backgroundColor: Colors.blue,
                          changeState: false,
                          onTap: () {
                            Navigator.pushNamed(context, "/asset-tree",
                                arguments: data[index]['children']);
                          }));
                })));
  }
}
