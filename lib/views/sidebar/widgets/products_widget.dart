// ignore_for_file: no_leading_underscores_for_local_identifiers, avoid_unnecessary_containers, sized_box_for_whitespace, sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductsWidget extends StatelessWidget {
  const ProductsWidget({super.key});

  Widget productData(int flex, Widget widget) {
    return Expanded(
        flex: flex,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
          child: Container(
            decoration: const BoxDecoration(
                // border: Border.all(color: Colors.grey),
                ),
            child: Center(child: widget),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final Stream<QuerySnapshot> _productsStream =
        FirebaseFirestore.instance.collection('products').snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: _productsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
             height: MediaQuery.of(context).size.height * 0.5,
            child: const Center(
                child: CircularProgressIndicator(
              color: Colors.cyan,
            )),
          );
        }

        return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final productsData = snapshot.data!.docs[index];
              return Container(
                  child: Row(
                children: [
                  productData(
                      1,
                      Center(
                        child: productsData['qty'] == 0
                            ? Stack(
                                children: [
                                  Image(
                                      height: 60,
                                      width: 80,
                                      image:
                                          NetworkImage(productsData['imageUrl'][0]),
                                      fit: BoxFit.cover),
                                  Positioned.fill(
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      color: Colors.black87.withOpacity(0.4),
                                      height: 60,
                                      width: 80,
                                      child: Center(
                                        child: Text(
                                          'Out of Sevice',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.righteous(
                                              fontSize: 12,
                                              color: Colors.white,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Container(
                                height: 60,
                                width: 80,
                                child: Image.network(
                                  productsData['imageUrl'][0],
                                  fit: BoxFit.cover,
                                ),
                              ),
                      )),
                  productData(
                      3,
                      Text(
                        productsData['brandName'],
                        style: GoogleFonts.righteous(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      )),
                  productData(
                      2,
                      Text(
                        productsData['price'].toString(),
                        style: GoogleFonts.righteous(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      )),
                  productData(
                      2,
                      Text(
                        productsData['qty'].toString(),
                        style: GoogleFonts.righteous(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      )),
                  productData(
                      1,
                      TextButton(
                        child: Text(
                          productsData['approved'] == false
                              ? 'Unapproved'
                              : 'Approved',
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.righteous(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: productsData['approved'] == false
                                  ? Colors.red
                                  : Colors.green),
                        ),
                        onPressed: productsData['approved'] == false
                            ? () async {
                                await firestore
                                    .collection('products')
                                    .doc(productsData['proId'])
                                    .update({'approved': true});
                              }
                            : () async {
                                await firestore
                                    .collection('products')
                                    .doc(productsData['proId'])
                                    .update({'approved': false});
                              },
                      )),
                  productData(
                    1,
                    TextButton(
                      child: Text(
                        'View More',
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.righteous(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onPressed: () {},
                    ),
                  )
                ],
              ));
            });
      },
    );
  }
}
