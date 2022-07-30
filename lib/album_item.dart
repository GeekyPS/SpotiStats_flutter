import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/albums_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'AlbumsScreen_artist.dart';

class AlbumItem extends StatelessWidget {
  final String rank;
  final String artists;
  final String name;
  final String imageUrl;

  AlbumItem({
    @required this.rank,
    @required this.artists,
    @required this.name,
    @required this.imageUrl,
  });

  void _showAlbumSongs(BuildContext context) {
    Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.bottomToTop,
          duration: Duration(milliseconds: 550),
          child: AlbumsScreenArtist(rank),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.green,
      onTap: () => _showAlbumSongs(context),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 7),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          child: Container(
            height: 70,
            color: Color.fromRGBO(51, 51, 51, 0.6),
            child: Row(
              children: <Widget>[
                Container(
                  width: 70,
                  height: 70,
                  child: Image.asset(imageUrl),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          name,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.assistant(
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              fontSize: 20),
                        ),
                        Text(artists,
                            style: GoogleFonts.assistant(color: Colors.grey))
                      ],
                    ),
                  ),
                ),
                CircleAvatar(
                  backgroundColor: Colors.grey[800],
                  child: Text(
                    '#${rank}',
                    style: GoogleFonts.pacifico(
                      fontSize: 36,
                      color: Colors.white60,
                    ),
                  ),
                  maxRadius: 50,
                  minRadius: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
