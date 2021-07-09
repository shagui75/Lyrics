import 'package:flutter/material.dart';

class LyricsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, String> inputArgument =
        ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('${inputArgument['title']} (${inputArgument['artist']})',
            overflow: TextOverflow.ellipsis),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.all(10.0),
          child: Text('${inputArgument['lyric']}')),
    );
  }
}
