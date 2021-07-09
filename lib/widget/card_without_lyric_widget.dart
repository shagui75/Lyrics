import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lyric_search/providers/lyrics_provider.dart';

class CardWithoutLyric extends StatefulWidget {
  final String nameSong;
  final String artist;

  CardWithoutLyric({@required this.artist, @required this.nameSong});

  @override
  _CardWithoutLyricState createState() => _CardWithoutLyricState();
}

class _CardWithoutLyricState extends State<CardWithoutLyric> {
  bool searching = false;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      leading: Icon(Icons.my_library_music_rounded),
      title: Text('artist: ${widget.artist}'),
      subtitle: Text('title: ${widget.nameSong}'),
      onTap: () {
        setState(() {
          searching = true;
        });

        _obtenerLyric(context, widget.artist, widget.nameSong);
      },
      trailing: WidgetProgress(searching),
    ));
  }

  Future _obtenerLyric(
      BuildContext context, String artist, String title) async {
    final resp = await lyricProvider.getLyric(artist, title);
    //A continuación agrego && (searching) en la condición porque searching podría ser false si,
    //con datos correctos, presiono buscar e inmediatamente presiono cancelar.
    //La idea es que vaya a "lyric" sólo si encontró la letra y no se presionó "cancelar"

    if (resp != null) {
      Map<String, String> _argument = {
        'title': title,
        'artist': artist,
        'lyric': resp
      };
      Navigator.pushNamed(context, 'lyric', arguments: _argument);
    } else {
      showAlert(context, 'we couldn\'t find the song "$title"');
    }
    setState(() {
      searching = false;
    });
  }
}

class WidgetProgress extends StatelessWidget {
  bool _searching;
  WidgetProgress(this._searching);

  @override
  Widget build(BuildContext context) {
    if (_searching) {
      return CircularProgressIndicator(value: null);
    } else
      return CircularProgressIndicator(value: 0);
  }
}

void showAlert(BuildContext context, String errorMessage) {
  CupertinoAlertDialog alert = CupertinoAlertDialog(
    content: Text('$errorMessage '),
    title: Text('Sorry!'),
  );
  showCupertinoDialog(
      context: context, builder: (context) => alert, barrierDismissible: true);
}



/*
Widget tarjeta(BuildContext context, Pelicula pelicula) {
    final tarjeta = Container(
        child: ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: FadeInImage(
        image: obtenerImagen(pelicula.getUrlPoster()),
        placeholder: AssetImage('lib/src/assets/img/no-image.jpg'),
      ),
    ));
    return GestureDetector(
      child: tarjeta,
      onTap: () {
        Navigator.pushNamed(context, 'detallePelicula', arguments: pelicula);
      },
    );
  }
}
*/
