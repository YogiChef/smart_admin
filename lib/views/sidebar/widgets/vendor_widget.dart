// ignore_for_file: no_leading_underscores_for_local_identifiers, avoid_unnecessary_containers, sized_box_for_whitespace, sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VendorWidget extends StatelessWidget {
  const VendorWidget({super.key});

  Widget vendorData(int flex, Widget widget) {
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
    final Stream<QuerySnapshot> _vendorsStream =
        FirebaseFirestore.instance.collection('vendors').snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: _vendorsStream,
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
              final vendorUserData = snapshot.data!.docs[index];
              return Container(
                  child: Row(
                children: [
                  vendorData(
                      1,
                      Center(
                        child: vendorUserData['approved'] == false
                            ? Stack(
                                children: [
                                  Image(
                                      height: 60,
                                      width: 80,
                                      image:
                                          NetworkImage(vendorUserData['image']),
                                      fit: BoxFit.cover),
                                  Positioned.fill(
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      color: Colors.black87.withOpacity(0.4),
                                      height: 60,
                                      width: 80,
                                      child: Center(
                                        child: Text(
                                          'Wait..',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.righteous(
                                              fontSize: 14,
                                              color: Colors.white,
                                              backgroundColor: Colors.black38),
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
                                  vendorUserData['image'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                      )),
                  vendorData(
                      3,
                      Text(
                        vendorUserData['bussinessName'],
                        style: GoogleFonts.righteous(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      )),
                  vendorData(
                      2,
                      Text(
                        vendorUserData['city'],
                        style: GoogleFonts.righteous(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      )),
                  vendorData(
                      2,
                      Text(
                        vendorUserData['state'],
                        style: GoogleFonts.righteous(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      )),
                  vendorData(
                      1,
                      TextButton(
                        child: Text(
                          vendorUserData['approved'] == false
                              ? 'Unapproved'
                              : 'Approved',
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.righteous(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: vendorUserData['approved'] == false
                                  ? Colors.red
                                  : Colors.green),
                        ),
                        onPressed: vendorUserData['approved'] == false
                            ? () async {
                                await firestore
                                    .collection('vendors')
                                    .doc(vendorUserData['vendorId'])
                                    .update({'approved': true});
                              }
                            : () async {
                                await firestore
                                    .collection('vendors')
                                    .doc(vendorUserData['vendorId'])
                                    .update({'approved': false});
                              },
                      )),
                  vendorData(
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
