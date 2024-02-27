import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageCustom extends StatefulWidget {
  final String? initialImageUrl;
  final Function(String)? onImageChanged;

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
    _imageUrl = widget.initialImageUrl;
  }

  Future<void> _pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      _imageUrl = image.path;
      widget.onImageChanged?.call(_imageUrl!); // Notify parent widget if needed
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GestureDetector(
          // Add a GestureDetector for image tapping
          onTap: _pickImage,
          child: Container(
            width: double.infinity,
            height: 200.0,
            decoration: BoxDecoration(
              border:
                  Border.all(color: Theme.of(context).primaryColor, width: 1.0),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (_imageUrl != null && _imageUrl!.isNotEmpty)
                  Image.file(
                    File(_imageUrl!), // Load image from local file
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                if (_imageUrl == null || _imageUrl!.isEmpty)
                  Icon(
                    Icons.add_a_photo_outlined,
                    size: 48.0,
                  ),
              ],
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
