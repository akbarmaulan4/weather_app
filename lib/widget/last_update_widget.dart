import 'package:flutter/material.dart';

class LastUpdateWidget extends StatelessWidget {
  DateTime date = DateTime.now();
  LastUpdateWidget({this.date});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 20.0, left: 00),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(
            Icons.access_time,
            color: Colors.black45,
            size: 15,
          ),
          SizedBox(width: 10),
          Text(
              'Last updated on ${TimeOfDay.fromDateTime(date).format(context)}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black45,
              ))
        ])
    );
  }
}
