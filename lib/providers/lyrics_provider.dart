import 'dart:async';
import 'package:http/http.dart' as http;

import 'package:lyric_search/models/lyric_model.dart';

class LyricProvider {
  String _url = 'api.lyrics.ovh';

  Future<String> getLyric(String artist, String title) async {
    Uri url = Uri.https(_url, 'v1/$artist/$title');
    final resp = await http.get(url);
    if (resp.statusCode == 200) {
      Lyric lyric = lyricFromJson(resp.body);
      return lyric.lyrics;
    } else
      return null;
  }
}

final LyricProvider lyricProvider = new LyricProvider();
