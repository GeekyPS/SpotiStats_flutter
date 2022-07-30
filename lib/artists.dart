import 'package:flutter/material.dart';
import 'artist_songs_screen.dart';
import 'package:page_transition/page_transition.dart';

class Artist extends StatelessWidget {
  final String rank;
  final String name;
  final String imageUrl;

  Artist(this.rank, this.name, this.imageUrl);

  void artistSelect(BuildContext context) {
    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.bottomToTop,
            duration: Duration(milliseconds: 550),
            child: ArtistSongsScreen(rank)));
  }

  @override
  Widget build(BuildContext context) {
    // ignore: dead_code
    return InkWell(
      splashColor: Colors.green,
      onTap: () => artistSelect(context),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5),
        height: 80,
        child: Column(children: [
          Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.asset(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          FittedBox(
            child: RichText(
              text: TextSpan(
                  text: '#${rank}',
                  style: TextStyle(
                      color: Colors.grey[600], fontWeight: FontWeight.bold),
                  children: <TextSpan>[
                    TextSpan(
                      text: ' ${name}',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]),
            ),
          )
        ]),
      ),
    );
  }
}
