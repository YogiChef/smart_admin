import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';

import 'widgets/banners_widget.dart';

class UploadBannerPage extends StatefulWidget {
  static const String route = 'upload';
  const UploadBannerPage({super.key});

  @override
  State<UploadBannerPage> createState() => _UploadBannerPageState();
}

class _UploadBannerPageState extends State<UploadBannerPage> {
  final FirebaseStorage storage = FirebaseStorage.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  dynamic _image;
  String? fileName;

  pickImage() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(allowMultiple: true, type: FileType.image);
    if (result != null) {
      setState(() {
        _image = result.files.first.bytes;
        fileName = result.files.first.name;
      });
    }
  }

  uploadBannersToStore(dynamic image) async {
    Reference ref = storage.ref().child('banners').child(fileName!);
    UploadTask uploadTask = ref.putData(image);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  uploadToFireStore() async {
    EasyLoading.show();
    if (_image != null) {
      String imgUrl = await uploadBannersToStore(_image);
      await firestore.collection('banners').doc(fileName).set({
        'image': imgUrl,
      }).whenComplete(() {
        EasyLoading.dismiss();
        setState(() {
          _image = null;
        });
      });
    }
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10),
            child: Text(
              'Banners',
              style: GoogleFonts.righteous(
                  fontSize: 36, fontWeight: FontWeight.w500),
            ),
          ),
          const Divider(
            color: Colors.grey,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  children: [
                    Container(
                      height: 140,
                      width: 180,
                      decoration: BoxDecoration(
                          color: Colors.yellow.shade900.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.yellow.shade800)),
                      child: _image != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.memory(_image, fit: BoxFit.cover))
                          : const Center(
                              child: Text('Upload Banners'),
                            ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.yellow.shade900,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20)),
                        onPressed: () {
                          pickImage();
                        },
                        child: Text(
                          'Upload Image',
                          style: GoogleFonts.righteous(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        )),
                  ],
                ),
              ),
              _image != null
                  ? ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow.shade900,
                          padding: const EdgeInsets.symmetric(horizontal: 20)),
                      onPressed: () {
                        uploadToFireStore();
                      },
                      child: Text(
                        'Save',
                        style: GoogleFonts.righteous(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ))
                  : const SizedBox(),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Divider(color: Colors.grey),
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10),
            child: Text(
              'Banners',
              style: GoogleFonts.righteous(
                  fontSize: 36, fontWeight: FontWeight.w500),
            ),
          ),
          const BannerWidget(),
        ],
      ),
    );
  }
}
