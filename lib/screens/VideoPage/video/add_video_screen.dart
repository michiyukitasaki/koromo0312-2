import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';

import 'confirm_screen.dart';

class AddVideoScreen extends StatelessWidget {
  const AddVideoScreen({Key? key}) : super(key: key);

  pickVideo(ImageSource src, BuildContext context) async {
    final video = await ImagePicker().pickVideo(source: src);
    if (video != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ConfirmScreen(
            videoFile: File(video.path),
            videoPath: video.path,
          ),
        ),
      );
    }
  }

  showOptionsDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        children: [
          SimpleDialogOption(
            onPressed: () => pickVideo(ImageSource.gallery, context),
            child: Row(
              children: const [
                Icon(Icons.image),
                Padding(
                  padding: EdgeInsets.all(7.0),
                  child: Text(
                    'Gallery',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () => pickVideo(ImageSource.camera, context),
            child: Row(
              children: const [
                Icon(Icons.camera_alt),
                Padding(
                  padding: EdgeInsets.all(7.0),
                  child: Text(
                    'Camera',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () => Navigator.of(context).pop(),
            child: Row(
              children: const [
                Icon(Icons.cancel),
                Padding(
                  padding: EdgeInsets.all(7.0),
                  child: Text(
                    'Cancel',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // pickImage(ImageSource src, BuildContext context) async {
  //   final image = await ImagePicker().pickImage(source: src);
  //   if (image != null) {
  //     Navigator.of(context).push(
  //       MaterialPageRoute(
  //         builder: (context) => ConfirmImageScreen(
  //           imageFile: File(image.path),
  //           imagePath: image.path,
  //         ),
  //       ),
  //     );
  //   }
  // }

  // showImageOptionsDialog(BuildContext context) {
  //   return showDialog(
  //     context: context,
  //     builder: (context) => SimpleDialog(
  //       children: [
  //         SimpleDialogOption(
  //           onPressed: () => pickImage(ImageSource.gallery, context),
  //           child: Row(
  //             children: const [
  //               Icon(Icons.image),
  //               Padding(
  //                 padding: EdgeInsets.all(7.0),
  //                 child: Text(
  //                   'Gallery',
  //                   style: TextStyle(fontSize: 20),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         SimpleDialogOption(
  //           onPressed: () => pickImage(ImageSource.camera, context),
  //           child: Row(
  //             children: const [
  //               Icon(Icons.camera_alt),
  //               Padding(
  //                 padding: EdgeInsets.all(7.0),
  //                 child: Text(
  //                   'Camera',
  //                   style: TextStyle(fontSize: 20),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         SimpleDialogOption(
  //           onPressed: () => Navigator.of(context).pop(),
  //           child: Row(
  //             children: const [
  //               Icon(Icons.cancel),
  //               Padding(
  //                 padding: EdgeInsets.all(7.0),
  //                 child: Text(
  //                   'Cancel',
  //                   style: TextStyle(fontSize: 20),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(80.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox(
            //   width: 250,
            //   height: 50,
            //   child: ElevatedButton(
            //       style: ButtonStyle(
            //           backgroundColor:MaterialStateProperty.all<Color>(Colors.red)
            //       ),
            //       onPressed: (){
            //     Get.to(()=>UploadImagePage());
            //   }, child: Text('写真をアップロード',
            //     style: TextStyle(
            //       fontSize: 20,
            //       color: Colors.black,
            //       fontWeight: FontWeight.bold,
            //     ),)),
            // ),
            // SizedBox(height: 30,),
            SizedBox(
              width: 250,
              height: 200,
              child: Column(
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:MaterialStateProperty.all<Color>(Colors.red)
                    ),
                      onPressed: () => showOptionsDialog(context),
                      child: Text('動画をアップロード',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),)),
                  SizedBox(height: 20,),
                  // ElevatedButton(
                  //     style: ButtonStyle(
                  //         backgroundColor:MaterialStateProperty.all<Color>(Colors.red)
                  //     ),
                  //     onPressed: () => showImageOptionsDialog(context),
                  //     child: Text('写真をアップロード',
                  //       style: TextStyle(
                  //         fontSize: 20,
                  //         color: Colors.black,
                  //         fontWeight: FontWeight.bold,
                  //       ),)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
