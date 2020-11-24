import 'package:flutter/material.dart';
import 'package:flutter_app/config/config.dart';

class ListScreen extends StatelessWidget {

  const ListScreen({Key key, this.title}) : super(key: key);

  final String title;

  static const data = [
    {'name':'John Doe', 'bloodType':'O +ve'},
    {'name':'Jane Smith', 'bloodType':'A +ve'},
    {'name':'Bruce Wayne', 'bloodType':'B +ve'},
    {'name':'John Doe', 'bloodType':'O -ve'},
    {'name':'John Doe', 'bloodType':'AB -ve'},
    {'name':'John Doe', 'bloodType':'B -ve'},
    {'name':'John Doe', 'bloodType':'O -ve'},
    {'name':'John Doe', 'bloodType':'A +ve'},
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true, title: Text(title, style: TextStyle(fontSize: 18.0))),
        body: Builder(
            builder: (scaffoldContext) => Container(

                    child: ListView.builder(itemCount: ListScreen.data.length ,itemBuilder: (buildContext, index) => Container(
                      padding: EdgeInsets.all(16.0),
                      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical:8.0),
                      decoration: BoxDecoration(
                          color: Palette.colorWhite,
                          boxShadow: Styles.boxShadow,
                          borderRadius: BorderRadius.circular(8.0)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child:  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(ListScreen.data[index]['name'], style: TextStyle(color: Palette.colorPrimaryLight, fontSize: 18.0, fontWeight: FontWeight.w500)),
                            Text(ListScreen.data[index]['bloodType'], style: TextStyle(color: Palette.colorPrimary, fontSize: 18.0, fontWeight: FontWeight.w500))
                          ],),
                      ),
                    )),

            )));
  }
}
