// ignore_for_file: must_be_immutable, non_constant_identifier_names, nullable_type_in_catch_clause, unused_element, prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:io';
import 'package:akhir/add_klasemen_futsal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class AddFutsal extends StatefulWidget {
  final String id;
  const AddFutsal({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _AddFutsalState createState() => _AddFutsalState();
}

class _AddFutsalState extends State<AddFutsal> {
  final _formKey = GlobalKey<FormState>();
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('cabor').snapshots();
  final RoundedLoadingButtonController _btnController2 =
      RoundedLoadingButtonController();

  void _doSomething(RoundedLoadingButtonController controller) async {
    Timer(const Duration(seconds: 10), () {
      controller.success();
    });
  }

  TextEditingController tim1 = TextEditingController();
  TextEditingController tim2 = TextEditingController();
  TextEditingController skor1 = TextEditingController();
  TextEditingController skor2 = TextEditingController();

  File? image;
  File? image2;
  var index;

  final MediaType _mediaType = MediaType.image;
  XFile? file;
  XFile? file2;

  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  String? imagePath;
  String? imagePathh;
  // String? image, image2;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text("something is wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xff142D4C),
              elevation: 0,
            ),
            body: ListView(
              children: [
                Form(
                  key: _formKey,
                  child: Container(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Tambah list futsal',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff142D4C)),
                        ),
                        const SizedBox(height: 30),
                        TextFormField(
                          controller: tim1,
                          maxLength: 4,
                          decoration: InputDecoration(
                            hintText: 'Cth. OTKP',
                            labelText: 'Tim 1 :',
                            labelStyle:
                                const TextStyle(color: Color(0xff142D4C)),
                            suffixIcon: IconButton(
                              onPressed: tim1.clear,
                              icon: const Icon(Icons.clear),
                              color: const Color(0xff142D4C),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff142D4C)),
                            ),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                          ),
                          //memberikan validasi jika form kosong
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Nama tim tidak boleh kosong';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          //memberikan identitas untuk setiap form
                          controller: tim2,
                          maxLength: 4,
                          decoration: InputDecoration(
                            hintText: 'Cth. RPL',
                            labelText: 'Tim 2 :',
                            labelStyle:
                                const TextStyle(color: Color(0xff142D4C)),
                            suffixIcon: IconButton(
                              onPressed: tim2.clear,
                              icon: const Icon(Icons.clear),
                              color: const Color(0xff142D4C),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff142D4C)),
                            ),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                          ),
                          //memberikan validasi jika form kosong
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Nama tim tidak boleh kosong';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          //memberikan identitas untuk setiap form
                          controller: skor1,
                          keyboardType: const TextInputType.numberWithOptions(),
                          maxLength: 2,
                          decoration: InputDecoration(
                            labelText: 'Skor tim 1 :',
                            labelStyle:
                                const TextStyle(color: Color(0xff142D4C)),
                            suffixIcon: IconButton(
                              onPressed: skor1.clear,
                              icon: const Icon(Icons.clear),
                              color: const Color(0xff142D4C),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff142D4C)),
                            ),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                          ),
                          //memberikan validasi jika form kosong
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Skor main tidak boleh kosong';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          //memberikan identitas untuk setiap form
                          controller: skor2,
                          keyboardType: const TextInputType.numberWithOptions(),
                          maxLength: 2,
                          decoration: InputDecoration(
                            labelText: 'Skor tim 2 :',
                            labelStyle:
                                const TextStyle(color: Color(0xff142D4C)),
                            suffixIcon: IconButton(
                              onPressed: skor2.clear,
                              icon: const Icon(Icons.clear),
                              color: const Color(0xff142D4C),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff142D4C)),
                            ),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                          ),
                          //memberikan validasi jika form kosong
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Skor Menang tidak boleh kosong';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),
                        // Center(
                        //     child: Container(
                        //         constraints: BoxConstraints(maxWidth: 600),
                        //         child: DateTimeForm())),
                        const SizedBox(height: 15),
                        const SizedBox(height: 15),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //   children: [

                        //batas
                        // InkWell(
                        //   onTap: () {
                        //     pickMedia(ImageSource.gallery);
                        //   },
                        //   child: SizedBox(
                        //     width: 110,
                        //     height: 110,
                        //     child: (imagePath != null)
                        //         ? CircleAvatar(
                        //             backgroundImage:
                        //                 FileImage(File(imagePath!)))
                        //         : image!.path == ""
                        //             ? Container(
                        //                 decoration: BoxDecoration(
                        //                   shape: BoxShape.circle,
                        //                   color: Colors.grey[300]!,
                        //                 ),
                        //                 width: 300,
                        //                 height: 300,
                        //                 child: const Icon(
                        //                   Icons.person,
                        //                   color: Colors.white,
                        //                   size: 100,
                        //                 ),
                        //               )
                        //             : Container(
                        //                 decoration: BoxDecoration(
                        //                   image: DecorationImage(
                        //                       fit: BoxFit.cover,
                        //                       image: FileImage(
                        //                           File(image!.path))),
                        //                   shape: BoxShape.circle,
                        //                   color: Colors.grey[300]!,
                        //                 ),
                        //                 width: 300,
                        //                 height: 300,
                        //               ),
                        //   ),
                        // ),
                        // InkWell(
                        //   onTap: () {
                        //     pickMedia(ImageSource.gallery);
                        //   },
                        //   child: SizedBox(
                        //     width: 110,
                        //     height: 110,
                        //     child: (imagePathh != null)
                        //         ? CircleAvatar(
                        //             backgroundImage:
                        //                 FileImage(File(imagePathh!)))
                        //         : image2!.path == ""
                        //             ? Container(
                        //                 decoration: BoxDecoration(
                        //                   shape: BoxShape.circle,
                        //                   color: Colors.grey[300]!,
                        //                 ),
                        //                 width: 300,
                        //                 height: 300,
                        //                 child: const Icon(
                        //                   Icons.person,
                        //                   color: Colors.white,
                        //                   size: 100,
                        //                 ),
                        //               )
                        //             : Container(
                        //                 decoration: BoxDecoration(
                        //                   image: DecorationImage(
                        //                       fit: BoxFit.cover,
                        //                       image: FileImage(
                        //                           File(image2!.path))),
                        //                   shape: BoxShape.circle,
                        //                   color: Colors.grey[300]!,
                        //                 ),
                        //                 width: 300,
                        //                 height: 300,
                        //               ),
                        //   ),
                        // ),

                        //BATASSS
                        //     const Text(
                        //       'VS',
                        //       style: TextStyle(
                        //         fontWeight: FontWeight.bold,
                        //         fontSize: 20,
                        //         color: Color(0xff142D4C),
                        //       ),
                        //     ),
                        //     InkWell(
                        //       onTap: () {
                        //         pickMediaa(ImageSource.gallery);
                        //       },
                        //       child: SizedBox(
                        //         width: 110,
                        //         height: 110,
                        //         child: (imagePathh != null)
                        //             ? CircleAvatar(
                        //                 backgroundImage:
                        //                     FileImage(File(imagePathh!)))
                        //             : imagePathh == ""
                        //                 ? Container(
                        //                     decoration: BoxDecoration(
                        //                       shape: BoxShape.circle,
                        //                       color: Colors.grey[300]!,
                        //                     ),
                        //                     width: 300,
                        //                     height: 300,
                        //                     child: const Icon(
                        //                       Icons.person,
                        //                       color: Colors.white,
                        //                       size: 100,
                        //                     ),
                        //                   )
                        //                 : Container(
                        //                     decoration: BoxDecoration(
                        //                       image: DecorationImage(
                        //                           fit: BoxFit.cover,
                        //                           image: FileImage(
                        //                               File(image2!.path))),
                        //                       shape: BoxShape.circle,
                        //                       color: Colors.grey[300]!,
                        //                     ),
                        //                     width: 300,
                        //                     height: 300,
                        //                   ),
                        //       ),
                        //     ),
                        //   ],
                        // ),

                        //batass

                        Row(
                          children: [
                            image != null
                                ? SizedBox(
                                    width: 100,
                                    height: 100,
                                    child: Image.file(
                                      image!,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Container(
                                    width: 100,
                                    height: 100,
                                    child: const Center(
                                        child: Padding(
                                            padding: EdgeInsets.all(10),
                                            child: Text(
                                              'Logo 1',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Color(0xff142D4C)),
                                            ))),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: const Color(0xff142D4C)),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                            const SizedBox(
                              width: 5,
                            ),
                            image == null
                                ? IconButton(
                                    onPressed: () async {
                                      File? _images = await getImageGallery();
                                      if (_images != null) {
                                        setState(() {
                                          image = _images;
                                        });
                                      }
                                    },
                                    icon: const Icon(Icons.add, size: 40))
                                : IconButton(
                                    onPressed: () {}, icon: Icon(null)),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            image2 != null
                                ? SizedBox(
                                    width: 100,
                                    height: 100,
                                    child: Image.file(
                                      image2!,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Container(
                                    width: 100,
                                    height: 100,
                                    child: const Center(
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Text(
                                          'Logo 2',
                                          style: TextStyle(
                                              color: Color(0xff142D4C)),
                                        ),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: const Color(0xff142D4C)),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                            const SizedBox(
                              width: 5,
                            ),
                            image2 == null
                                ? IconButton(
                                    onPressed: () async {
                                      File? _images = await getImageGallery2();
                                      if (_images != null) {
                                        setState(() {
                                          image2 = _images;
                                        });
                                      }
                                    },
                                    icon: const Icon(Icons.add, size: 40))
                                : IconButton(
                                    onPressed: () {}, icon: Icon(null)),
                          ],
                        ),

                        const SizedBox(height: 15),
                        const SizedBox(height: 30),
                        RoundedLoadingButton(
                          color: const Color(0xff142D4C),
                          // successColor: const Color(0xff142D4C),
                          controller: _btnController2,
                          onPressed: () async {
                            DocumentReference<Map<String, dynamic>> caborId =
                                await FirebaseFirestore.instance
                                    .collection('cabor')
                                    .add({
                              'futsal': {
                                'logo1': '',
                                'logo2': '',
                                'skor1': skor1.text,
                                'skor2': skor2.text,
                                'tim1': tim1.text,
                                'tim2': tim2.text,

                                // 'tanggalPertandingan' : ,
                              },
                            });
                            // .then((value) async {
                            //   print(value.id);
                            if (image != null) {
                              await FirebaseStorage.instance
                                  .ref(
                                      'logo/$Timestamp.fromMicrosecondsSinceEpoch(microseconds)')
                                  .putFile(image!)
                                  .then((result) async {
                                String downloadUrl =
                                    await result.ref.getDownloadURL();

                                await caborId.set({
                                  'futsal': {'logo1': downloadUrl}
                                }, SetOptions(merge: true));
                              });
                            }
                            if (image2 != null) {
                              await FirebaseStorage.instance
                                  .ref(
                                      'logo/$Timestamp.fromMicrosecondsSinceEpoch(microseconds)')
                                  .putFile(image2!)
                                  .then((result) async {
                                String downloadUrl =
                                    await result.ref.getDownloadURL();

                                await caborId.set({
                                  'futsal': {'logo2': downloadUrl}
                                }, SetOptions(merge: true));
                              });
                            }
                            // });
                            FirebaseFirestore.instance
                                .collection('statistikPertandingan')
                                .add({
                              'caborId': caborId.id,
                              'tim1': {
                                'kartuKuning': '-',
                                'kartuMerah': '-',
                                'pelanggaran': '-',
                                'penguasaanBola': '-',
                                'tendangan': '-',
                                'tendanganKeGawang': '-',
                              },
                              'tim2': {
                                'kartuKuning': '-',
                                'kartuMerah': '-',
                                'pelanggaran': '-',
                                'penguasaanBola': '-',
                                'tendangan': '-',
                                'tendanganKeGawang': '-',
                              }
                            });
                            FirebaseFirestore.instance
                                .collection('deskripsiFutsal')
                                .add({
                              'caborId': caborId.id,
                              'deskripsi': '',
                            });
                            FirebaseFirestore.instance
                                .collection('timFutsal')
                                .add({
                              'caborId': caborId.id,
                              'tim1': {
                                'namaPemain': '',
                                'noPemain': '',
                                'posisiPemain': '',
                                'fotoPemain': '',
                              },
                              'tim2': {
                                'namaPemain': '',
                                'noPemain': '',
                                'posisiPemain': '',
                                'fotoPemain': '',
                              }
                            });
                            // widget.docid.reference.update({
                            // 'futsal': {
                            //   'skor1': skor1.text,
                            //   'skor2': skor2.text,
                            //   'tanggal': tanggal.text,
                            //   'tim1': tim1.text,
                            //   'tim2': tim2.text,
                            //   'logo1': image1,
                            //   'logo2': image2,
                            //   // 'tanggalPertandingan' : ,
                            // },
                            // });
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text(
                                "Data telah ditambahkan!",
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Color(0xff142D4C),
                            ));
                            // uploadImage();
                            setState(() {});
                            // .whenComplete(() {

                            Navigator.pop(
                              context,
                            );
                            // });
                          },
                          // onPressed: () {
                          //   if (_formKey.currentState!.validate()) {
                          //     FirebaseStorage.instance
                          //         .ref(
                          // "logoAddFutsal/${DateTime.now().microsecondsSinceEpoch}")
                          //         // masalahnya di putfile, dia nyebut image tapi ga nyebut image2, emang put file bisa 2??
                          //         .putFile(
                          //           File(image!.path),
                          //         )
                          //         .then(
                          //       (image) async {
                          //         // String imageUrl =
                          //         //     await image.ref.getDownloadURL();
                          //         // String imageUrl2 =
                          //         //     await image.ref.getDownloadURL();
                          //         FirebaseFirestore.instance
                          // .collection("cabor")
                          //             .add({
                          //           'futsal': {
                          //             // "logo1": fileUrl,
                          //             // "logo2": fileUrl2,
                          //             "tim1": tim1.text,
                          //             "tim2": tim2.text,
                          //             "skor1": skor1.text,
                          //             "skor2": skor2.text,
                          //           }
                          //         });
                          //         uploadImage();
                          //         uploadImage2();
                          //       },
                          //     ).then((value) => Navigator.pop(context));
                          //   }
                          // },
                          valueColor: Colors.white,
                          borderRadius: 10,
                          child: const Text('''Simpan''',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        // untuk membuat form input tambahakan widget form()

        );
  }

  void pickMedia(ImageSource source) async {
    if (_mediaType == MediaType.image) {
      file = await ImagePicker().pickImage(source: source);
    } else {
      file = await ImagePicker().pickVideo(source: source);
    }
    if (file != null) {
      imagePath = file!.path;
      if (_mediaType == MediaType.video) {
        imagePath = await VideoThumbnail.thumbnailFile(
            video: file!.path,
            imageFormat: ImageFormat.PNG,
            quality: 100,
            maxWidth: 300,
            maxHeight: 300);
      }
      setState(() {});
    }
  }

  void pickMediaa(ImageSource source) async {
    if (_mediaType == MediaType.image) {
      file2 = await ImagePicker().pickImage(source: source);
    } else {
      file2 = await ImagePicker().pickVideo(source: source);
    }
    if (file2 != null) {
      imagePathh = file2!.path;
      if (_mediaType == MediaType.video) {
        imagePathh = await VideoThumbnail.thumbnailFile(
            video: file2!.path,
            imageFormat: ImageFormat.PNG,
            quality: 100,
            maxWidth: 300,
            maxHeight: 300);
      }
      setState(() {});
    }
  }

  Future<void> uploadImage() async {
    if (file == null || file2 == null) {
      return;
    }

    try {
      String imageName = file!.name;
      File imageFile = File(file!.path);
      final firebaseStorageRef = await firebaseStorage
          .ref("logoAddFutsal/${DateTime.now().microsecondsSinceEpoch}")
          .child(imageName)
          .putFile(imageFile)
          .then((result) async {
        String fileUrl = await result.ref.getDownloadURL();
      });
      await FirebaseFirestore.instance
          .collection('cabor')
          .doc(widget.id)
          .update(
        {
          'futsal': {
            'skor1': skor1.text,
            'skor2': skor2.text,
            'tim1': tim1.text,
            'tim2': tim2.text,
            'logo1': file,
            // 'logo2': fileUrl2,
            // 'tanggalPertandingan' : ,
          },
        },
      );

      String imageName2 = file2!.name;
      File imageFile2 = File(file2!.path);
      final firebaseStorageRef2 = await firebaseStorage
          .ref("logoAddFutsal/${DateTime.now().microsecondsSinceEpoch}")
          .child(imageName2)
          .putFile(imageFile2);
      final fileUrl2 = await firebaseStorageRef2.ref.getDownloadURL();
      print(fileUrl2);

      await FirebaseFirestore.instance
          .collection('cabor')
          .doc(widget.id)
          .update(
        {
          'futsal': {
            'skor1': skor1.text,
            'skor2': skor2.text,
            'tim1': tim1.text,
            'tim2': tim2.text,
            'logo1': file,
            'logo2': fileUrl2,
            // 'tanggalPertandingan' : ,
          },
        },
      );
    } on FirebaseException catch (e) {
      print(e);
    } catch (error) {
      print(error);
    }
  }
  // Future<void> uploadImage() async {
  //   if (file == null) {
  //     return;
  //   }
  //   String imageName = file!.name;
  //   File imageFile = File(file!.path);
  //   try {
  //     final firebaseStorageRef = await firebaseStorage
  //         .ref("logoani")
  //         .child(imageName)
  //         .putFile(imageFile);
  //     final fileUrl = await firebaseStorageRef.ref.getDownloadURL();
  //     print(fileUrl);
  //     FirebaseFirestore.instance.collection('cabor').doc(widget.id).update({
  //       'futsal': {
  //         'logo1': fileUrl,

  //         // 'tanggalPertandingan' : ,
  //       },
  //     });
  //   } on FirebaseException catch (e) {
  //     print(e);
  //   } catch (error) {
  //     print(error);
  //   }
  // }

  // Future<void> uploadImage2() async {
  //   if (file2 == null) {
  //     return;
  //   }
  //   String imageName = file2!.name;
  //   File imageFile = File(file2!.path);
  //   try {
  //     final firebaseStorageRef = await firebaseStorage
  //         .ref("logoani")
  //         .child(imageName)
  //         .putFile(imageFile);
  //     final fileUrl2 = await firebaseStorageRef.ref.getDownloadURL();
  //     print(fileUrl2);
  //     await FirebaseFirestore.instance
  //         .collection('cabor')
  //         .doc(widget.id)
  //         .update({
  //       'futsal': {
  //         'logo2': fileUrl2,
  //         // 'tanggalPertandingan' : ,
  //       },
  //     });
  //   } on FirebaseException catch (e) {
  //     print(e);
  //   } catch (error) {
  //     print(error);
  //   }
  // }
}

// class PickImage {
//   final ImagePicker _picker = ImagePicker();
//   Future<XFile?> pickImage({required ImageSource source}) async {
//     try {
//       final XFile? image = await _picker.pickImage(source: source);
//       if (image == null) return null;
//       final imageTemp = XFile(image.path);
//       return imageTemp;
//     } on PlatformException catch (e) {
//       print("Failed to pick image $e");
//     }
//   }
// }

Future<File?> getImageGallery() async {
  ImagePicker _picker = ImagePicker();
  final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  if (image != null) {
    return File(image.path);
  } else {
    return null;
  }
}

Future<File?> getImageGallery2() async {
  ImagePicker _picker = ImagePicker();
  final XFile? image2 = await _picker.pickImage(source: ImageSource.gallery);
  if (image2 != null) {
    return File(image2.path);
  } else {
    return null;
  }
}
