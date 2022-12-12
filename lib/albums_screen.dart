import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/album_item.dart';
import 'package:flutter_complete_guide/dummy_data2.dart';

class AlbumsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.black87, Colors.black],
        ),
      ),
      child: ListView.builder(
        itemBuilder: (context, index) {
          var _pages = Dummy_Data_Albums[index];
          return AlbumItem(
            rank: _pages.rank,
            artists: _pages.artistName,
            name: _pages.name,
            imageUrl: _pages.imageUrl,
          );
        },
        itemCount: Dummy_Data_Albums.length,
      ),
    );
  }
}
