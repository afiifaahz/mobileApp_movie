import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui/models/movie_model.dart';
import 'package:ui/screens/detail_latest.dart';
import 'package:ui/screens/detail_top.dart';
import 'package:ui/screens/kategori_card.dart';
import 'package:ui/viewmodel/fetchLatest.dart';
import 'navigasi_bottom.dart';
import 'list_template.dart';

var menus = [
  FeatherIcons.home,
  FeatherIcons.list,
  
];



class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigasiBottom(),
      backgroundColor: const Color(0xFF000B49),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF000B49),
                ),
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: [
                    const SizedBox(height: 15),
                    _greetings(),
                    const SizedBox(height: 17),
                    _card(),
                    const SizedBox(height: 20),
                    KategoriCard(),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Latest Movie",
                          style: GoogleFonts.manrope(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    FutureBuilder<List<MovieModal>>(
                      future: fetchLatestData(),
                      builder: (context, latestDataSnapshot) {
                        if (latestDataSnapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (latestDataSnapshot.hasError) {
                          return Text('Error: ${latestDataSnapshot.error}');
                        } else {
                          return _cardmovie(latestDataSnapshot.data);
                        }
                      },
                    ),

                    SizedBox(height: 20),
                    

                  ],
                ),
              ),
              // _cardmovie(),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Recommendation Movie",
                    style: GoogleFonts.manrope(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              TopList(),
              
            

            ],
          ),
        ),
      ),
    );
  }

  Widget promoCard(MovieModal movie) {
    return Container(
      width: 150,
      height: 250,
      margin: EdgeInsets.only(right: 15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          fit: BoxFit.fill,
          image: NetworkImage(movie.imageURL)
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            stops: [0.1, 0.9],
            colors: [
              Colors.black.withOpacity(.8),
              Colors.black.withOpacity(.1),
            ],
          ),
        ),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              movie.nama,
              style: GoogleFonts.manrope(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }


  Widget _cardmovie(List<MovieModal>? latestMovies) {
  if (latestMovies == null || latestMovies.isEmpty) {
    return Container(); // Return an empty container or a placeholder widget
  }

  return Container(
    height: 250, // Adjust height as needed
    margin: const EdgeInsets.symmetric(horizontal: 20),
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: latestMovies.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailLatest(movie: latestMovies[index]),
              ),
            );
          },
          child: promoCard(latestMovies[index]),
        );
      },
    ),
  );
}

  AspectRatio _card() {
    return AspectRatio(
      aspectRatio: 336 / 184,
      child: Container(
        clipBehavior: Clip.hardEdge,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Color.fromARGB(255, 87, 85, 158),
        ),
        child: Stack(
          children: [
            Image.asset(
              'assets/bg1.png',
              height: double.maxFinite,
              width: double.maxFinite,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                      text: TextSpan(
                          text: "Explore ",
                          style: GoogleFonts.manrope(
                              fontSize: 18,
                              color: Colors.white,
                              height: 150 / 100),
                          children: const [
                            TextSpan(
                                text: "Movies, \n ",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800)),
                            TextSpan(text: "Dive into "),
                            TextSpan(
                                text: "Entertainment, \nAnytime Anywhere",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800)),
                          ])),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(.4),
                        border: Border.all(
                            color: Colors.white.withOpacity(.12), width: 2),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      "See details",
                      style: GoogleFonts.manrope(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }




  Padding _greetings() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello, Movie-lovers!",
                style: GoogleFonts.manrope(
                  fontSize: 27,
                  fontWeight: FontWeight.w800,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ],
          ),
          Icon(
            Icons.person,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

 
}

Widget _movieList(List<MovieModal>? movies) {
  if (movies == null || movies.isEmpty) {
    return Container(); // Return an empty container or a placeholder widget
  }

  return Container(
    height: 250, // Adjust height as needed
    margin: const EdgeInsets.symmetric(horizontal: 20),
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: movies.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailTop(movie: movies[index]),
              ),
            );
          },
          child: _buildMovieCard(movies[index]), // Create a widget to display movie details
        );
      },
    ),
  );
}

Widget _buildMovieCard(MovieModal movie) {
  return Container(
    width: 150,
    height: 250,
    margin: EdgeInsets.only(right: 15.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      image: DecorationImage(
        fit: BoxFit.fill,
        image: AssetImage(movie.imageURL),
      ),
    ),
    clipBehavior: Clip.antiAlias,
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          begin: Alignment.bottomRight,
          stops: [0.1, 0.9],
          colors: [
            Colors.black.withOpacity(.8),
            Colors.black.withOpacity(.1),
          ],
        ),
      ),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            movie.nama,
            style: GoogleFonts.manrope(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
      ),
    ),
  );
}
