import 'package:flutter/material.dart';

class WidgetProgress extends StatelessWidget {
  final bool searching;
  const WidgetProgress(this.searching);

  @override
  Widget build(BuildContext context) {
    if (searching) {
      return CircularProgressIndicator();
    } else
      return SizedBox(height: 0);
  
  }
}
