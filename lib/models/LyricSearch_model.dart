class LyricSearch {
  final int id;
  final String title;
  final String artist;

  LyricSearch({this.id, this.title, this.artist});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'artist': artist,
    };
  }
}
