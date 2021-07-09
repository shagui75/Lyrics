import 'package:flutter/material.dart';

import 'package:lyric_search/pages/home_page.dart';
import 'package:lyric_search/pages/lyric_screen.dart';
import 'package:lyric_search/pages/history_screen.dart';

//import 'package:Lyric_search/src/pages/lyric_screen.dart';
//import 'package:Lyric_search/src/pages/history_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (BuildContext context) => HomePage(),
          'lyric': (BuildContext context) => LyricsScreen(),
          'history': (BuildContext context) => HistoryScreen(),
        });
  }
}
