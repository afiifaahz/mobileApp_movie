import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui/models/horrormodel.dart';


class DetailHorror extends StatelessWidget {
  const DetailHorror({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final HorrorModal movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ..._buildBackground(context, movie),
          _buildMovieInformation(context, movie),
          _buildActions(context),
        ],
      ),
    );
  }

  Positioned _buildActions(BuildContext context) {
    return Positioned(
      bottom: 40,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }

  Positioned _buildMovieInformation(BuildContext context, HorrorModal movie) {
    return Positioned(
      bottom: 150,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              movie.nama,
              style: GoogleFonts.manrope(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '${movie.tahun} | ${movie.kategori} | ${movie.durasi} | Rating: ${movie.rating}',
              style: GoogleFonts.manrope(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 10),
            RatingBar.builder(
              initialRating: double.parse(movie.rating),
              direction: Axis.horizontal,
              allowHalfRating: true,
              ignoreGestures: true,
              itemCount: 5,
              itemSize: 20,
              unratedColor: Colors.white,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, index) {
                return const Icon(
                  Icons.star,
                  color: Colors.amber,
                );
              },
              onRatingUpdate: (rating) {},
            ),
            const SizedBox(height: 50),
            Text(
              '${movie.deskripsi}',
              textAlign: TextAlign.justify,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(height: 1.75, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildBackground(context, HorrorModal movie) {
    return [
      Container(
        height: double.infinity,
        color: Color.fromARGB(255, 22, 22, 53),
      ),
      Image.network(
        movie.imageURL,
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.5,
        fit: BoxFit.cover,
      ),
      const Positioned.fill(
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                Color.fromARGB(255, 22, 22, 53),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.3, 0.5],
            ),
          ),
        ),
      ),
    ];
  }
}
