import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui/models/movie_model.dart';
import 'package:ui/screens/listHorror.dart';
import 'package:ui/viewmodel/fetchHorror.dart';
import 'navigasi_bottom.dart';

class ListViewMovieH extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 22, 22, 53),
      bottomNavigationBar: NavigasiBottom(),
      appBar: AppBar(
        title: Text(
          "Horror",
          style: GoogleFonts.manrope(fontSize: 25, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Color.fromARGB(255, 22, 22, 53),
      ),
      body: FutureBuilder<List<MovieModal>?>(
        future: fetchHorrorData(), // Use the fetchHorrorData function
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final horrorList = snapshot.data;
            return Column(
              children: [
                SizedBox(height: 5),
                SizedBox(height: 20),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: horrorList?.length ?? 0,
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 11,
                    ),
                    itemBuilder: (context, index) {
                      final MovieModal movie = horrorList![index];
                      // Use the appropriate widget for each item (e.g., HorrorList)
                      return HorrorList();
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
