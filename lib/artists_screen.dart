import 'package:flutter/material.dart';
import './dummy_data.dart';
import 'artists.dart';

class ArtistsPage extends StatelessWidget {
  const ArtistsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.black87, Colors.black],
        ),
      ),
      child: GridView(
          children: Dummy_Data_Artists.map((catData) {
            return Artist(
              catData.rank,
              catData.name,
              catData.imageUrl,
            );
          }).toList(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 0,
            crossAxisSpacing: 0,
            mainAxisExtent: 150,
          )),
    );
  }
}
