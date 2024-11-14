import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ImageFromStorage extends StatelessWidget {
  final String imagePath;
  final FirebaseStorage storage = FirebaseStorage.instance;

  ImageFromStorage({Key? key, required this.imagePath}) : super(key: key);

  Future<Image> _loadImage() async {
    try {
      String imageUrl = await storage.ref(imagePath).getDownloadURL();
      return Image.network(imageUrl);
    } catch (e) {
      // If an error occurs, return the backup image
      String backupImageUrl = await storage
          .ref(
              'gs://co2-target-asset-tracking.appspot.com/profileImages/B1Lr5HQ0rVQNkiVrxoPGepHMQ453/ca_logo.png')
          .getDownloadURL();
      return Image.network(backupImageUrl);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadImage(),
      builder: (BuildContext context, AsyncSnapshot<Image> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return snapshot.data!;
        } else if (snapshot.error != null) {
          return Text('Error loading image');
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
