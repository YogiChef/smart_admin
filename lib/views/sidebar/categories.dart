import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_admin/views/sidebar/widgets/category_widget.dart';

class CategoriesPage extends StatefulWidget {
  static const String route = 'categories';

  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final FirebaseStorage storage = FirebaseStorage.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  dynamic _image;
  String? fileName;
  late String categoryName;

  _pickImage() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(allowMultiple: false, type: FileType.image);
    if (result != null) {
      setState(() {
        _image = result.files.first.bytes;
        fileName = result.files.first.name;
      });
    }
  }

  _uploadCategoryToStorage(dynamic image) async {
    Reference ref = storage.ref().child('category_img').child(fileName!);
    UploadTask uploadTask = ref.putData(image);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  uploadCategory() async {
    EasyLoading.show();
    if (_formKey.currentState!.validate()) {
      String imageUrl = await _uploadCategoryToStorage(_image);
      await firestore.collection('categories').doc(fileName).set({
        'image': imageUrl,
        'categoryName': categoryName,
      }).whenComplete(() {
        EasyLoading.dismiss();
        setState(() {
          _image = null;
        });
      });
      _formKey.currentState!.reset();
    } else {
      EasyLoading.dismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(10),
              child: Text(
                'Category',
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
                                child: Text('Upload Category'),
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
                            _pickImage();
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
                Flexible(
                  child: _image != null
                      ? SizedBox(
                          width: MediaQuery.of(context).size.width * 0.16,
                          child: TextFormField(
                            onChanged: (value) {
                              categoryName = value;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Category Name Must not be empty';
                              } else {
                                return null;
                              }
                            },
                            decoration: const InputDecoration(
                                hintText: 'Enter Category Name'),
                          ),
                        )
                      : const SizedBox(),
                ),
                _image == null
                    ? const SizedBox()
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.yellow.shade900,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20)),
                        onPressed: () {
                          uploadCategory();
                        },
                        child: Text(
                          'Save',
                          style: GoogleFonts.righteous(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        )),
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
                'Categories',
                style: GoogleFonts.righteous(
                    fontSize: 36, fontWeight: FontWeight.w500),
              ),
            ),
            const CategoryWidget(),
          ],
        ),
      ),
    );
  }
}
