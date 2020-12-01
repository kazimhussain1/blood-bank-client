import 'package:flutter/material.dart';
import 'package:flutter_app/config/config.dart';

class ListScreen extends StatelessWidget {
  final bool request;
  final String title;
  final List<dynamic> data;

  // ignore: sort_constructors_first
  const ListScreen(this.title, this.data, {Key key, this.request = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(centerTitle: true, title: Text(title, style: TextStyle(fontSize: 18.0))),
        body: Builder(
            builder: (scaffoldContext) => Container(
                  child: data.isEmpty
                      ? Center(child: Text('No data to show', style: TextStyle(fontSize: 16.0)))
                      : ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (buildContext, index) {
                            var title = request
                                ? "BloodType: ${data[index]['blood_type']}"
                                : data[index]['requestor']['name'];
                            var description = request
                                ? "Bottles: ${data[index]['num_of_bottles']}"
                                : "BloodType: ${data[index]['blood_request']['blood_type']}";
                            return Container(
                              padding: EdgeInsets.all(16.0),
                              margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                              decoration: BoxDecoration(
                                  color: Palette.colorWhite,
                                  boxShadow: Styles.boxShadow,
                                  borderRadius: BorderRadius.circular(8.0)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(title,
                                        style: TextStyle(
                                            color: Palette.colorPrimaryLight,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w500)),
                                    Text(description,
                                        style: TextStyle(
                                            color: Palette.colorPrimary,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w500))
                                  ],
                                ),
                              ),
                            );
                          }),
                )));
  }
}
