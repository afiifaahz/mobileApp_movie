import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui/models/movie_model.dart';
import 'package:ui/screens/listRomance.dart';
import 'package:ui/viewmodel/fetchRomance.dart';
import 'navigasi_bottom.dart';

class ListViewMovieR extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 22, 22, 53),
      bottomNavigationBar: NavigasiBottom(),
      appBar: AppBar(
        title: Text(
          "Romance",
          style: GoogleFonts.manrope(fontSize: 25, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Color.fromARGB(255, 22, 22, 53),
      ),
      body: FutureBuilder<List<MovieModal>?>(
        future: fetchRomanceData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final romanceList = snapshot.data;

            // Set up a ScrollController
            final ScrollController _scrollController = ScrollController();

            return Column(
              children: [
                SizedBox(height: 5),
                SizedBox(height: 20),
                Expanded(
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: romanceList?.length ?? 0,
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 11,
                    ),
                    itemBuilder: (context, index) {
                      final MovieModal movie = romanceList![index];
                      // Use the RomanceList widget for each item   w
                      return RomanceList();
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
