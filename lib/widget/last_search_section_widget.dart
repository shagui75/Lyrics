import 'package:flutter/material.dart';
import 'package:lyric_search/widget/card_info_widget.dart';

class BuildLastSearchSection extends StatelessWidget {
  const BuildLastSearchSection({
    Key key,
    @required String lastArtistOK,
    @required String lastSongTitleOK,
    @required String lastLyricOK,
  })  : _lastArtistOK = lastArtistOK,
        _lastSongTitleOK = lastSongTitleOK,
        _lastLyricOK = lastLyricOK,
        super(key: key);

  final String _lastArtistOK;
  final String _lastSongTitleOK;
  final String _lastLyricOK;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          ' Previous search',
        ),
        CardInfo(
            artist: _lastArtistOK,
            title: _lastSongTitleOK,
            lyric: _lastLyricOK),
      ]),
    );
  }
}
