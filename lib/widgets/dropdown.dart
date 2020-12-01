import 'package:flutter/material.dart';
import 'package:flutter_app/config/config.dart';

typedef onSelectCallback<T> = Null Function(dynamic value);

class DropDownButton<T> extends StatefulWidget {
   const DropDownButton({Key key, @required this.data, this.label = '', this.onSelect, this.fixedValue})
      : super(key: key);


  @override
  _DropDownButtonState<T> createState() => _DropDownButtonState<T>();

  final List<T> data;
  final String label;
  final onSelectCallback<T> onSelect;
  final String  fixedValue;
}

class _DropDownButtonState<T> extends State<DropDownButton> {
  T dropdownValue;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: widget.fixedValue !=null,
      child: Container(
        padding: const EdgeInsets.fromLTRB(12.0, 4.0, 12.0, 4.0),
        decoration: const ShapeDecoration(
            shape: RoundedRectangleBorder(
          side: BorderSide(width: 1.0, style: BorderStyle.solid, color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        )),
        child: Row(
          children: [
             Expanded(
                child: Text(
              widget.label,
              style: TextStyle(fontSize: 16.0, color: Colors.grey[700]),
            )),
            DropdownButtonHideUnderline(
              child: DropdownButton<T>(

                value: widget.fixedValue ?? dropdownValue,
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: widget.fixedValue !=null?Colors.grey[700]:Palette.colorPrimary, fontSize: 16.0),
                onChanged: (T newValue) {
                  if(widget.onSelect != null){
                    widget.onSelect(newValue);
                  }
                  setState(() {
                    dropdownValue = newValue;
                  });
                },
                items: widget.data.map<DropdownMenuItem<T>>((value) {
                  return DropdownMenuItem<T>(
                    value: value,
                    child: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text(value.toString()),
                          ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
