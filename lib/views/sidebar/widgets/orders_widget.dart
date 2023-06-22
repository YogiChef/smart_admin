// ignore_for_file: no_leading_underscores_for_local_identifiers, avoid_unnecessary_containers, sized_box_for_whitespace, sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderWidget extends StatelessWidget {
  const OrderWidget({super.key});

  Widget orderData(int flex, Widget widget) {
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
    final Stream<QuerySnapshot> _ordersStream =
        FirebaseFirestore.instance.collection('orders').snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: _ordersStream,
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
              final ordersData = snapshot.data!.docs[index];
              return Container(
                  child: Row(
                children: [
                  orderData(
                      1,
                      Center(
                        child: ordersData['accepted'] == true
                            ? Stack(
                                children: [
                                  Image(
                                      height: 60,
                                      width: 80,
                                      image: NetworkImage(
                                          ordersData['productImage'][0]),
                                      fit: BoxFit.cover),
                                  Positioned.fill(
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      color: Colors.black38,
                                      height: 60,
                                      width: 80,
                                      child: Center(
                                        child: Text(
                                          'Accepted',
                                          style: GoogleFonts.righteous(
                                              fontSize: 14,
                                              color: Colors.yellow.shade900,
                                              backgroundColor: Colors.white54),
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
                                  ordersData['productImage'][0],
                                  fit: BoxFit.cover,
                                ),
                              ),
                      )),
                  orderData(
                      3,
                      Text(
                        ordersData['proName'],
                        style: GoogleFonts.righteous(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      )),
                  orderData(
                      2,
                      Text(
                        ordersData['fullName'],
                        style: GoogleFonts.righteous(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      )),
                  orderData(
                      2,
                      Text(
                        ordersData['address'],
                        style: GoogleFonts.righteous(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      )),
                  orderData(
                      1,
                      TextButton(
                        child: Text(
                          ordersData['accepted'] == false
                              ? 'No Accept'
                              : 'Accepted',
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.righteous(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: ordersData['accepted'] == false
                                  ? Colors.red
                                  : Colors.green),
                        ),
                        onPressed: ordersData['accepted'] == false
                            ? () async {
                                await firestore
                                    .collection('orders')
                                    .doc(ordersData['orderId'])
                                    .update({'accepted': true});
                              }
                            : () async {
                                await firestore
                                    .collection('orders')
                                    .doc(ordersData['orderId'])
                                    .update({'accepted': false});
                              },
                      )),
                  orderData(
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
