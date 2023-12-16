import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:ui/models/fetchLatest.dart'; // Update import statement
import 'package:ui/models/fetchRekomen.dart';
// import 'package:ui/screens/detail_latest.dart';
import 'package:ui/screens/detail_top.dart'; // Update import statement

class TopList extends StatefulWidget {
  @override
  State<TopList> createState() => _TopListState();
}

class _TopListState extends State<TopList> {
  late Future<List<TopModal>> topData;

  @override
  void initState() {
    super.initState();
    topData = fetchTopData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TopModal>>(
      future: topData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<TopModal> movieList = snapshot.data!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: movieList.map((movie) {
              return buildMovieListItem(movie);
            }).toList(),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        // While fetching, show a loading indicator
        return CircularProgressIndicator();
      },
    );
  }

  Widget buildMovieListItem(TopModal movie) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 2),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 22, 22, 53),
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 221, 221, 221).withOpacity(.12),
                blurRadius: 40,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  movie.imageURL,
                  width: 95,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 15),
              Flexible(
                fit: FlexFit.tight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.nama,
                      style: GoogleFonts.manrope(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 7),
                    RichText(
                      text: TextSpan(
                        text: "Genre: ${movie.kategori}",
                        style: GoogleFonts.manrope(
                          fontSize: 13,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 7),
                    Row(
                      children: [
                        const SizedBox(width: 7),
                        Text(
                          "${movie.tahun}",
                          style: GoogleFonts.manrope(
                            fontSize: 13,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailTop(movie: movie),
                    ),
                  );
                },
                child: Container(
                  width: 70,
                  height: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    color: const Color.fromARGB(255, 67, 122, 167),
                  ),
                  child: Center(
                    child: Text(
                      "Watch Now",
                      style: GoogleFonts.manrope(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  
}
