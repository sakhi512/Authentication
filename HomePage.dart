import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);




  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // File? _image;
  // Future getImage() async {
  //   final image = await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if (image == null) return;
  //   final imageTemporary=File(image.path);
  //   setState(() {
  //     this._image=imageTemporary;
  //   });
  // }
  final storage = FirebaseStorage.instance;

  Future<void> uploadFile(String filePath, String fileName) async {
    File file = File(filePath);
    try {
      await storage.ref('test/$fileName').putFile(file);
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
       body: Column(
         children: [
           Center(
             child: Container(
               child: ElevatedButton(
                 onPressed: () async {
                   var result = await FilePicker.platform.pickFiles(
                     allowMultiple: false,
                     type: FileType.custom,
                     allowedExtensions: ['png', 'jpg','gif'],
                   );
                   if (result == null) {
                     ScaffoldMessenger.of(context).showSnackBar(
                         SnackBar(content: Text("No Files Selected")));
                     return;
                   }
                   var path = result.files.single.path;
                   var fileName = result.files.single.name;
                   uploadFile(path!, fileName);
                 },
                 child: Text("Upload a file"),),
             ),
           ),

         ],
       ),
     );

    // Scaffold(
    //   appBar: AppBar(title:
    //   Text("pick an image"
    //   ),
    //   ),
    //   body: Center(
    //     child: Column(
    //       children: [
    //         SizedBox(height: 40,),
    //         _image !=null ? Image.file(_image!, width: 250,height: 250, fit: BoxFit.cover,
    //         )
    //         :Image.network("https://i.pinimg.com/736x/2e/35/81/2e35812326c389b592e85a7f25ebf313.jpg"),
    //         SizedBox(height: 40,),
    //         CustomButton(title: "pick from gallery",
    //             icon: Icons.image_outlined,onClick:getImage, ),
    //         CustomButton(title: "pick from camera",
    //             icon: Icons.image_outlined,
    //             onClick:()=>{} ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
// Widget CustomButton({
//   required String title,
//   required IconData icon,
//   required VoidCallback onClick,
// }){
//   return Container(
//     width: 280,
//     child: ElevatedButton(onPressed: onClick,
// child: Row(
//   children: [
//     Icon(icon),
//   Text(title),
//
//   ],
// ),
//     ),
//   );
// }