import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/dummy_data.dart';
import 'package:flutter_complete_guide/dummy_data2.dart';
import 'package:flutter_complete_guide/song_item.dart';
import 'package:google_fonts/google_fonts.dart';

class AlbumsScreenArtist extends StatelessWidget {
  final scrollController = ScrollController();
  final String rank;

  AlbumsScreenArtist(this.rank);
  @override
  Widget build(BuildContext context) {
    List selectedAlbum =
        Dummty_Album_songs.where((ml) => ml.rank == rank).toList();

    print(selectedAlbum[0].name);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black87, Colors.black],
          ),
        ),
        child: CustomScrollView(
          controller: scrollController,
          slivers: [
            SliverAppBar(
              centerTitle: false,
              backgroundColor: Colors.black,
              title: Text(
                selectedAlbum[0].name,
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700, fontSize: 25),
              ),
              expandedHeight: 350,
              floating: true,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: ClipRRect(
                  child: Image.asset(
                    selectedAlbum[0].imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
                child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black87, Colors.black],
                ),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                controller: scrollController,
                itemBuilder: ((context, index) {
                  return SongItem(
                    rank: selectedAlbum[index].id,
                    artists: selectedAlbum[index].Artist,
                    name: selectedAlbum[index].name,
                    imageUrl: selectedAlbum[index].imageUrl,
                  );
                }),
                itemCount: selectedAlbum.length,
              ),
            )),
          ],
        ),
      ),
    );
  }
}
