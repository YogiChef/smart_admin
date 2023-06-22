// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _categoriesStream =
        FirebaseFirestore.instance.collection('categories').snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: _categoriesStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.cyan,
            ),
          );
        }

        return GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 6, mainAxisSpacing: 8, crossAxisSpacing: 4),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final cateData = snapshot.data!.docs[index];

              return Column(
                children: [
                  SizedBox(
                    height: 80,
                    width: 100,
                    child: ClipRRect(
                      child: Image.network(
                        cateData['image'],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      cateData['categoryName'],
                      style: GoogleFonts.righteous(letterSpacing: 1),
                    ),
                  ),
                ],
              );
            });
      },
    );
  }
}
