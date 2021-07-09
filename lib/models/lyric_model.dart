import 'dart:convert';

Lyric lyricFromJson(String str) => Lyric.fromJson(json.decode(str));

String lyricToJson(Lyric data) => json.encode(data.toJson());

class Lyric {
  Lyric({
    this.lyrics,
  });

  String lyrics;

  factory Lyric.fromJson(Map<String, dynamic> json) => Lyric(
        lyrics: json["lyrics"],
      );

  Map<String, dynamic> toJson() => {
        "lyrics": lyrics,
      };
}
