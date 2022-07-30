import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/song_item.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dummy_data.dart';

class ArtistSongsScreen extends StatelessWidget {
  final String routeArgs;
  final scrollController = ScrollController();

  ArtistSongsScreen( this.routeArgs);

  @override
  Widget build(BuildContext context) {
    final selectedArtist = Dummy_Data_Artists.firstWhere((element) {
      return element.rank == routeArgs;
    });

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
                selectedArtist.name,
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700, fontSize: 25),
              ),
              expandedHeight: 350,
              floating: true,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: ClipRRect(
                  child: Image.asset(
                    selectedArtist.imageUrl,
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
                    rank: Dummy_Data_Songs[index].rank,
                    artists: Dummy_Data_Songs[index].Artists,
                    name: Dummy_Data_Songs[index].name,
                    imageUrl: Dummy_Data_Songs[index].imageUrl,
                  );
                }),
                itemCount: Dummy_Data_Songs.length,
              ),
            )),
          ],
        ),
      ),
    );
  }
}
