import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SongItem extends StatelessWidget {
  final String rank;
  final String artists;
  final String name;
  final String imageUrl;

  SongItem({
    @required this.rank,
    @required this.artists,
    @required this.name,
    @required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 7),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(10), bottomRight: Radius.circular(10),),
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
    );
  }
}
