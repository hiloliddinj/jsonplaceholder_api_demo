import 'package:flutter/material.dart';

class AlbumWidget extends StatelessWidget {
  const AlbumWidget(this.albumTitle, this.thumbnailUrl, {Key? key}) : super(key: key);

  final String albumTitle, thumbnailUrl;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: ListTile(
        leading: Image.network(
          thumbnailUrl,
          width: 30.0,
        ),
        title: Text(albumTitle),
      ),
    );
  }
}
