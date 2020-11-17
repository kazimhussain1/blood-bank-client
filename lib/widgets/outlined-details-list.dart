import 'package:flutter/material.dart';
import 'package:flutter_app/config/config.dart';
import 'outlined-container.dart';

class OutlinedDetailsList extends StatelessWidget {
  const OutlinedDetailsList({Key key, this.label, this.data}) : super(key: key);

  final String label;
  final Map<String, String> data;

  @override
  Widget build(BuildContext context) {
    return OutlinedContainer(
      label: label,
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 16.0,
              ),
              ...data.keys
                  .map<Widget>((e) => Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(e,
                            style: TextStyle(
                                color: Palette.colorGrey,
                                fontSize: 18,
                                fontWeight: FontWeight.w500)),
                      ))
                  .toList(),
              SizedBox(
                height: 8.0,
              ),
            ],
          ),
          SizedBox(
            width: 16.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 16.0,
              ),
              ...data.values
                  .map<Widget>((e) => Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(e ?? '',
                            style: TextStyle(
                                color: Palette.colorPrimary,
                                fontSize: 18,
                                fontWeight: FontWeight.w500)),
                      ))
                  .toList(),
              SizedBox(
                height: 8.0,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
