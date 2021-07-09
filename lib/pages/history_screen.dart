import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lyric_search/models/LyricSearch_model.dart';
import 'package:lyric_search/widget/card_without_lyric_widget.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Future<List<LyricSearch>> listaSearches =
        ModalRoute.of(context).settings.arguments;
    //db = DB_Class();
    return Scaffold(
        appBar: AppBar(title: Text('Previous searches')),
        body: FutureBuilder(
            future: listaSearches,
            builder: (context, AsyncSnapshot<List<LyricSearch>> snapshot) {
              if (snapshot.hasData) {
                List<CardWithoutLyric> listCard = [];
                for (var item in snapshot.data) {
                  CardWithoutLyric newCard = CardWithoutLyric(
                      artist: item.artist, nameSong: item.title);
                 
                  listCard.add(newCard);
                }
                return ListView(
                  children: listCard,
                );
              }
              //Si no encuentra nada en la BD devuelve una tarjeta vacía
              else {
                return CardWithoutLyric(
                  artist: '',
                  nameSong: '',
                );
              }
            }));
  }
}
