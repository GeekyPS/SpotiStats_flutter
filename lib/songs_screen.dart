import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/song_item.dart';
import './dummy_data.dart';


class SongsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.black87, Colors.black],
        ),
      ),
      child: ListView.builder(
        itemBuilder: ((context, index) {
          return SongItem(
            rank: Dummy_Data_Songs[index].rank,
            artists: Dummy_Data_Songs[index].Artists,
            name: Dummy_Data_Songs[index].name,
            imageUrl: Dummy_Data_Songs[index].imageUrl,
          );
        }),
        itemCount: Dummy_Data_Songs.length,
      ),
    );
  }
}
