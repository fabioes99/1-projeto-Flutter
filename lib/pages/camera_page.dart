import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:native_image_cropper/native_image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path/path.dart';
import 'dart:typed_data';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  XFile? photo;
  Uint8List? aaa;
  Uint8List uint8ListVazia = Uint8List(20);

  Uint8List xFileToUint8List(XFile file) {
  List<int> bytes = File(file.path).readAsBytesSync();
  
  Uint8List uint8List = Uint8List.fromList(bytes);
  
  return uint8List;
}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          TextButton(
              onPressed: () async {
                showModalBottomSheet(
                    context: context,
                    builder: (_) {
                      return Wrap(
                        children: [
                          ListTile(
                            leading: const FaIcon(FontAwesomeIcons.camera),
                            title: const Text("Camera"),
                            onTap: () async {
                              final ImagePicker _picker = ImagePicker();
                              photo = await _picker.pickImage(
                                  source: ImageSource.camera);
                              if (photo != null) {
                                String path = (await path_provider
                                        .getApplicationDocumentsDirectory())
                                    .path;
                                String name = basename(photo!.path);
                                await photo!.saveTo("$path/$name");

                                await GallerySaver.saveImage(photo!.path);

                                /*
                                var teste = xFileToUint8List(photo!);

                                var teste2 = await NativeImageCropper.cropOval(bytes: teste, x: 30, y: 30, width: 20, height: 20);
                                aaa = teste2;
                                setState(() {
                                  
                                }); */

                                Navigator.pop(context);
                              }
                            },
                          ),
                          //CropPreview(bytes: aaa ?? uint8ListVazia),
                          ListTile(
                              leading: const FaIcon(FontAwesomeIcons.images),
                              title: const Text("Galeria"),
                              onTap: () async {
                                final ImagePicker _picker = ImagePicker();
                                photo = await _picker.pickImage(
                                    source: ImageSource.gallery);
                                Navigator.pop(context);
                                setState(() {
                                  
                                });
                                
                              })
                        ],
                      );
                    });
              },
              child: const Text("Teste")),
               Padding(
                padding: const EdgeInsets.all(28.0),
                child: Center(
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      //_showSelectPhotoOptions(context);
                    },
                    child: Center(
                      child: Container(
                          height: 200.0,
                          width: 200.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.shade200,
                          ),
                          child: Center(
                            child: photo == null
                                ? const Center(
                                  child: Text(
                                      'No image selected',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                )
                                : CircleAvatar(
                                    backgroundImage: FileImage(File(photo!.path)),
                                    radius: 200.0,
                                  ),
                          )),
                    ),
                  ),
                ),
              )
        ],
      ),
      appBar: AppBar(
        title: Text("Camera"),
      ),
    ));
  }
}