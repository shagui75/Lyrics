import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:lyric_search/providers/lyrics_provider.dart';
import 'package:lyric_search/providers/db_provider.dart';
import 'package:lyric_search/models/LyricSearch_model.dart';
import 'package:lyric_search/widget/last_search_section_widget.dart';
import 'package:lyric_search/widget/progress_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //final LyricProvider lyricProvider = new LyricProvider();
  bool searching = false;
  String _artist = '';
  String _songTitle = '';
  String _lastArtistOK = '';
  String _lastSongTitleOK = '';
  String _lastLyricOK = '';
  DbClass db;
  final textControllerArtist = TextEditingController();
  final textControllerTitle = TextEditingController();

  @override
  void initState() {
    super.initState();
    db = DbClass();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('LYRIC SEARCH'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            _buildSearchSection(),
            BuildLastSearchSection(
                lastArtistOK: _lastArtistOK,
                lastSongTitleOK: _lastSongTitleOK,
                lastLyricOK: _lastLyricOK)
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, 'history',
                arguments: db.getSearches());
          },
          child: Icon(Icons.history),
          backgroundColor: Colors.orangeAccent,
        ));
  }

  Future _obtenerLyric(
      BuildContext context, String artist, String title) async {
    final resp = await lyricProvider.getLyric(artist, title);

    //searching puede ser false si se presiona cancelar aunque aún se esté buscando la letra en la web
    if (searching) {
      if (resp != null) {
        _lastArtistOK = artist;
        _lastSongTitleOK = title;
        _lastLyricOK = resp;

        int nextID = await db.getNextID();
        LyricSearch actualSearch = LyricSearch(
            id: nextID, artist: _lastArtistOK, title: _lastSongTitleOK);
        db.insertSearch(actualSearch);

        Map<String, String> _argument = {
          'title': title,
          'artist': artist,
          'lyric': resp
        };

        Navigator.pushNamed(context, 'lyric', arguments: _argument);
      } else {
        showAlert(context, 'we couldn\'t find the song "$title"');
      }
    }
    _showProgressSearching(false);
  }

// el CircularProgressIndicator se muestra sólo si searching = true;
  void _showProgressSearching(bool showSearching) {
    setState(() {
      searching = showSearching;
    });
  }

  Function _btnCancelarPressed() {
    if (searching) {
      return () {
        _showProgressSearching(false);
      };
    } else {
      return null;
    }
  }

  Widget _buildSearchSection() {
    return Expanded(
        child: Column(children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            textFieldArtist(),
            textFiledTitle(),
            SizedBox(height: 20.0),
            //container con los tres botones
            Container(
                child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  btnSubmit(context),
                  btnCancel(),
                ],
              ),
              btnClear(),
            ])),
          ],
        ),
      ),
      WidgetProgress(searching),
    ]));
  }

  Widget textFieldArtist() {
    return TextField(
      decoration: InputDecoration(hintText: 'Artist'),
      onChanged: (value) => _artist = value,
      controller: textControllerArtist,
    );
  }

  Widget textFiledTitle() {
    return TextField(
      decoration: InputDecoration(hintText: 'Song Title'),
      onChanged: (value) => _songTitle = value,
      controller: textControllerTitle,
    );
  }

  Widget btnSubmit(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      onPressed: () {
        _obtenerLyric(context, _artist, _songTitle);
        _showProgressSearching(true);
      },
      child: Text('Submit', style: TextStyle(color: Colors.white)),
      color: Colors.blueAccent,
    );
  }

  Widget btnCancel() {
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      onPressed: _btnCancelarPressed(),
      disabledColor: Colors.black26,
      child: Text(
        'Cancel',
        style: TextStyle(color: Colors.white),
      ),
      color: Colors.blueAccent,
    );
  }

  Widget btnClear() {
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      onPressed: () {
        textControllerArtist.clear();
        textControllerTitle.clear();
        setState(() {
          _artist = '';
          _songTitle = '';
        });
      },
      disabledColor: Colors.black26,
      child: Text(
        'Clear',
        style: TextStyle(color: Colors.white),
      ),
      color: Colors.blueAccent,
    );
  }
}

//mensaje de advertencia cuando no se encuentra la letra de la canción
void showAlert(BuildContext context, String errorMessage) {
  CupertinoAlertDialog alert = CupertinoAlertDialog(
    content: Text('$errorMessage '),
    title: Text('Sorry!'),
  );
  showCupertinoDialog(
      context: context, builder: (context) => alert, barrierDismissible: true);
}
