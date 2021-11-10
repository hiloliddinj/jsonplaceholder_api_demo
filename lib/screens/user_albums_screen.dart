import 'package:jsonplaceholder_api_demo/controllers/albums_controller.dart';
import 'package:jsonplaceholder_api_demo/controllers/photos_controller.dart';
import 'package:jsonplaceholder_api_demo/controllers/users_controller.dart';
import 'package:jsonplaceholder_api_demo/models/album_photos.dart';
import 'package:jsonplaceholder_api_demo/models/user.dart';
import 'package:jsonplaceholder_api_demo/models/user_albums.dart';
import 'package:jsonplaceholder_api_demo/screens/album_photos_screen.dart';
import 'package:jsonplaceholder_api_demo/widgets/album_widget.dart';
import 'package:jsonplaceholder_api_demo/widgets/prog_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserAlbumsScreen extends StatelessWidget {
  UserAlbumsScreen(this.userIndex, {Key? key}) : super(key: key);

  final int userIndex;

  final UsersController uC = Get.find<UsersController>();
  final AlbumsController aC = Get.find<AlbumsController>();
  final PhotosController phC = Get.find<PhotosController>();

  @override
  Widget build(BuildContext context) {
    final User user = uC.userList[userIndex];

    return Scaffold(
      appBar: AppBar(title: Text(user.username + ' Albums')),
      body: SafeArea(
        child: Obx(() {
          if (aC.isAlbumsLoading() || phC.isPhotosLoading()) {
            return const ProgIndicator();
          } else {
            UserAlbums userWithAlbums = aC.listOfUsersWithAlbums[userIndex];
            List<AlbumPhotos> albumWithPhotos = phC.listOfAlbumsWithPhotos;
            return ListView.builder(
              itemCount: userWithAlbums.userAlbumsList.length,
              itemBuilder: (context, i) {
                int albumId = userWithAlbums.userAlbumsList[i].id;
                return GestureDetector(
                  child: AlbumWidget(userWithAlbums.userAlbumsList[i].title,
                      albumWithPhotos[albumId - 1].albumPhotosList[0].thumbnailUrl),
                  onTap: () {
                    //Get.to(() => PostDetailsScreen(userIndex, i));
                    print('Go to details Screen');
                    Get.to(() => AlbumPhotosScreen(albumId));
                  },
                );
              },
            );
          }
        }),
      ),
    );
  }
}
