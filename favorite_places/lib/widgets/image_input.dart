import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:io';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.pickedImg});
  final void Function(File image) pickedImg;

  @override
  State<StatefulWidget> createState() {
    return _ImageInputState();
  }
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedImage;

  void _takePicture() async {
    final imagePicker = ImagePicker();
    final pcikedImage = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    if (pcikedImage == null) {
      return;
    }
    setState(() {
      _selectedImage = File(pcikedImage.path);
    });
    widget.pickedImg(_selectedImage!);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
      icon: const Icon(Icons.camera),
      label: const Text("take picture"),
      onPressed: () {
        _takePicture();
      },
    );

    if (_selectedImage != null) {
      content = GestureDetector(
        onTap: () {
          _takePicture();
        },
        child: Image.file(
          _selectedImage!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    }

    return Container(
      height: 250,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border:
            Border.all(width: 1, color: Theme.of(context).colorScheme.primary),
      ),
      child: content,
    );
  }
}
