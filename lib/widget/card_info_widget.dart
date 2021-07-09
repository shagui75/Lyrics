import 'package:flutter/material.dart';

class CardInfo extends StatelessWidget {
  final String title;
  final String artist;
  final String lyric;

  CardInfo({@required this.artist, @required this.title, @required this.lyric});

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.black12,
        child: ListTile(
          leading: Icon(Icons.my_library_music_rounded),
          title: Text(
            'artist: $artist',
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
          subtitle: Text(
            'title: $title',
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
          onTap: () {
            Map<String, String> _argument = {
              'title': title,
              'artist': artist,
              'lyric': lyric
            };
            Navigator.pushNamed(context, 'lyric', arguments: _argument);
          },
        ));
  }
}
