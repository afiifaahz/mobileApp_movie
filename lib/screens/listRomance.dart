import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui/models/romancemodel.dart';
import 'package:ui/screens/detail_movie.dart';
import 'package:ui/screens/detail_movie2.dart';

class RomanceList extends StatefulWidget {
  @override
  State<RomanceList> createState() => _RomanceListState();
}

class _RomanceListState extends State<RomanceList> {
  late Future<List<RomanceModal>> romanceData;

  @override
  void initState() {
    super.initState();
    romanceData = fetchRomanceData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<RomanceModal>>(
      future: romanceData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<RomanceModal> romanceList = snapshot.data!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: romanceList.map((romance) {
              return buildRomanceListItem(romance);
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

  Widget buildRomanceListItem(RomanceModal romance) {
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
                  romance.imageURL,
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
                      romance.nama,
                      style: GoogleFonts.manrope(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 7),
                    RichText(
                      text: TextSpan(
                        text: "Genre: ${romance.kategori}",
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
                          "${romance.tahun}",
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
                      builder: (context) => DetailRomance(movie: romance),
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
                        fontWeight: FontWeight.bold,
                      ),
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
