// ignore: file_names
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
//for storage we will be using firebase storage and for picking the image we will be using image picker package

// ignore: camel_case_types, must_be_immutable
class uploadImage extends StatefulWidget {
  String userId="";	
  uploadImage({Key? key, userId}) : super(key: key);

  @override
  State<uploadImage> createState() => _uploadImageState();
}

class _uploadImageState extends State<uploadImage> {
  File? _image;
  final imagePicker = ImagePicker();
  String? downloadURL;
  //image picking method to pick images from gallary or even you can use camera
  //but we will be using gallary for this project
  Future getImageFromGallery() async {
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
      } else {
        showsnackbar("no image selected",const  Duration(milliseconds: 1200));
      }
    });
  }

//this snackbar is fireed when user press the button but he donot select any image
  showsnackbar(String snackText, Duration d) {
    final snackBar = SnackBar(content: Text(snackText), duration: d);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  //we have selected image and image is in _image now we need to upload it to the firebase storage............
  //not only upload also we will get the url of that image and show that image in our application
  //got problem on upload 3 4 mb photo is also taking too long time to upload but speed is not case now we will change the method
  //after project will be completed
  Future uploadImageTOfirestore() async {
    Reference ref = FirebaseStorage
    .instance
    .ref()
    .child("${widget.userId}/images")
    .child("${DateTime.now().millisecondsSinceEpoch}");
    await ref
    .putFile(_image!);
    downloadURL = await ref.getDownloadURL();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Upload Image"),
        ),
        body: Center(
            child: Padding(
          padding: const EdgeInsets.all(10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              height: 500,
              width: double.infinity,
              child: Column(
                children: [
                 const Text("Upload Image"),
                 const  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      width: 300,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.red),
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: _image == null
                                ? const Center(
                                    child:Text("no image selected"),
                                  )
                                : Image.file(_image!),
                          ),
                        ],
                      )),
                    ),
                  ),
                  //two elevated buttons
                  ElevatedButton(
                      onPressed: () {
                        getImageFromGallery();
                      },
                      child:const  Text("select image")),
                  ElevatedButton(
                      onPressed: () {
                        uploadImageTOfirestore().whenComplete(() => 
                        showsnackbar("Image uploaded successfully $widget.userId",
                         const Duration(milliseconds: 12000
                         )
                         )
                         );
                      },
                      child: const Text("upload image")),
                ],
              ),
            ),
          ),
        )));
  }
}
