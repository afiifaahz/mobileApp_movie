import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui/models/actionmodel.dart';
import 'package:ui/models/movie_model.dart';
import 'package:ui/screens/listAction.dart';
import 'package:ui/screens/list_template.dart';
import 'navigasi_bottom.dart';

class ListViewMovie extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 22, 22, 53),
      bottomNavigationBar: NavigasiBottom(),
      appBar: AppBar(
        title: Text(
          "Action",
          style: GoogleFonts.manrope(fontSize: 25, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Color.fromARGB(255, 22, 22, 53),
      ),
      body: FutureBuilder<List<ActionModal>?>(
        future: fetchActionData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final actionList = snapshot.data;
            return Column(
              children: [
                SizedBox(height: 5),
                SizedBox(height: 20),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: actionList?.length ?? 0,
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 11,
                    ),
                    itemBuilder: (context, index) {
                      final ActionModal movie = actionList![index];
                      // Use the RomanceList widget for each item
                      return ActionList();
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
