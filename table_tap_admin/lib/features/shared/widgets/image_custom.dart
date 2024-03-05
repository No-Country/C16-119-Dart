import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageCustom extends StatefulWidget {
  final String? initialImageUrl;
  final Function(File)? onImageChanged;

  const ImageCustom({Key? key, this.initialImageUrl, this.onImageChanged})
      : super(key: key);

  @override
  _ImageCustomState createState() => _ImageCustomState();
}

class _ImageCustomState extends State<ImageCustom> {
  late TextEditingController _textController;
  String? _imageUrl;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.initialImageUrl);
    _imageUrl = widget.initialImageUrl; // Inicializar _imageUrl con initialImageUrl
  }

  Future<void> _pickImage() async {
    final imageFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      _imageUrl = imageFile.path;
      widget.onImageChanged?.call(File(_imageUrl!)); // Llamar onImageChanged con el archivo seleccionado
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text("Imagen del producto *"),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: _pickImage,
          child: Container(
            width: double.infinity,
            height: 200.0,
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).primaryColor,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: _imageUrl == null || _imageUrl!.isEmpty
                ? const Icon(
                    Icons.add_a_photo_outlined,
                    size: 48.0,
                  )
                : _imageUrl!.startsWith("http") || _imageUrl!.startsWith("https")
                    ? CachedNetworkImage(
                        imageUrl: _imageUrl!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      )
                    : Image.file(
                        File(_imageUrl!),
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
