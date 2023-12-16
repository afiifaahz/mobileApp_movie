import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui/models/actionmodel.dart';
import 'package:ui/screens/detail_movie.dart';

class ActionList extends StatefulWidget {
  @override
  State<ActionList> createState() => _ActionListState();
}

class _ActionListState extends State<ActionList> {
  late Future<List<ActionModal>> actionData;

  @override
  void initState() {
    super.initState();
    actionData = fetchActionData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ActionModal>>(
      future: actionData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<ActionModal> actionList = snapshot.data!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: actionList.map((action) {
              return buildActionListItem(action);
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

  Widget buildActionListItem(ActionModal action) {
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
                  action.imageURL,
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
                      action.nama,
                      style: GoogleFonts.manrope(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 7),
                    RichText(
                      text: TextSpan(
                        text: "Genre: ${action.kategori}",
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
                          "${action.tahun}",
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
                      builder: (context) => DetailAction(movie: action)
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
