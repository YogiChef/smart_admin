// ignore_for_file: no_leading_underscores_for_local_identifiers, avoid_unnecessary_containers, sized_box_for_whitespace, sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WithdrawalWidget extends StatelessWidget {
  const WithdrawalWidget({super.key});

  Widget withdrawalsData(int flex, Widget widget) {
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
    final Stream<QuerySnapshot> _withdrawalStream =
        FirebaseFirestore.instance.collection('withdrawal').snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: _withdrawalStream,
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
              final withdrawalData = snapshot.data!.docs[index];
              return Container(
                  child: Row(
                children: [
                  withdrawalsData(
                      1,
                      Text(
                        withdrawalData['name'],
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.righteous(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      )),
                  withdrawalsData(
                      2,
                      Text(
                        withdrawalData['bankname'],
                        style: GoogleFonts.righteous(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      )),
                  withdrawalsData(
                      2,
                      Text(
                        withdrawalData['bankaccount'],
                        style: GoogleFonts.righteous(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      )),
                  withdrawalsData(
                      2,
                      Text(
                        withdrawalData['accountnumber'],
                        style: GoogleFonts.righteous(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      )),
                  withdrawalsData(
                      2,
                      Text(
                        withdrawalData['mobile'],
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.righteous(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      )),
                  withdrawalsData(
                    1,
                    Text(
                      withdrawalData['amount'],
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.righteous(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                ],
              ));
            });
      },
    );
  }
}
