import 'package:jsonplaceholder_api_demo/controllers/albums_controller.dart';
import 'package:jsonplaceholder_api_demo/controllers/photos_controller.dart';
import 'package:jsonplaceholder_api_demo/controllers/posts_controller.dart';
import 'package:jsonplaceholder_api_demo/controllers/users_controller.dart';
import 'package:jsonplaceholder_api_demo/models/album_photos.dart';
import 'package:jsonplaceholder_api_demo/models/user.dart';
import 'package:jsonplaceholder_api_demo/models/user_albums.dart';
import 'package:jsonplaceholder_api_demo/models/user_posts.dart';
import 'package:jsonplaceholder_api_demo/screens/user_albums_screen.dart';
import 'package:jsonplaceholder_api_demo/screens/user_posts_screen.dart';
import 'package:jsonplaceholder_api_demo/widgets/album_widget.dart';
import 'package:jsonplaceholder_api_demo/widgets/post_widget.dart';
import 'package:jsonplaceholder_api_demo/widgets/prog_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jsonplaceholder_api_demo/constants.dart';

class UserDetailsScreen extends StatelessWidget {
  UserDetailsScreen(this.userIndex, {Key? key}) : super(key: key);

  final int userIndex;

  final UsersController uC = Get.find<UsersController>();
  final PostsController pC = Get.put(PostsController());
  final AlbumsController aC = Get.put(AlbumsController());
  final PhotosController phC = Get.put(PhotosController());

  @override
  Widget build(BuildContext context) {
    final User user = uC.userList[userIndex];

    return Scaffold(
      appBar: AppBar(title: Text(user.username)),
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              color: Colors.green.shade200,
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('User Details:', style: kHeadingStyle),
                  Container(
                    padding: const EdgeInsets.all(2),
                    margin: const EdgeInsets.all(2),
                    width: double.infinity,
                    color: Colors.amber.shade100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Name: ' + user.name),
                        Text('Email: ' + user.email),
                        Text('Phone: ' + user.phone),
                        Text('Website: ' + user.website),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(2),
                    margin: const EdgeInsets.all(2),
                    width: double.infinity,
                    color: Colors.blue.shade100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Working at: ' + user.company.name),
                        Row(children: [
                          const SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('bs: ' + user.company.bs),
                              Text('catchPhrase: ' + user.company.catchPhrase),
                            ],
                          ),
                        ]),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(2),
                    margin: const EdgeInsets.all(2),
                    width: double.infinity,
                    color: Colors.purpleAccent.shade100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Address: ' +
                            user.address.street +
                            ', ' +
                            user.address.suite +
                            ', ' +
                            user.address.city +
                            ', ' +
                            user.address.zipcode +
                            ', (lat: ' +
                            user.address.geo.lat +
                            ', lng: ' +
                            user.address.geo.lng +
                            ')'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Obx(() {
              if (pC.isPostsLoading()) {
                return const ProgIndicator();
              } else {
                UserPosts userWithPosts = pC.listOfUsersWithPosts[userIndex];
                return Container(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.all(5),
                  color: Colors.green.shade200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Posts:', style: kHeadingStyle),
                      PostWidget(
                        userWithPosts.userPostsList[0].title,
                        userWithPosts.userPostsList[0].body,
                      ),
                      PostWidget(
                        userWithPosts.userPostsList[1].title,
                        userWithPosts.userPostsList[1].body,
                      ),
                      PostWidget(
                        userWithPosts.userPostsList[2].title,
                        userWithPosts.userPostsList[2].body,
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            Get.to(() => UserPostsScreen(userIndex));
                          },
                          child: const Text('See All Posts'),
                        ),
                      ),
                    ],
                  ),
                );
              }
            }),
            Obx(() {
              if (aC.isAlbumsLoading() || phC.isPhotosLoading()) {
                return const ProgIndicator();
              } else {
                UserAlbums userWithAlbums = aC.listOfUsersWithAlbums[userIndex];
                int albumId0 = userWithAlbums.userAlbumsList[0].id;
                int albumId1 = userWithAlbums.userAlbumsList[1].id;
                int albumId2 = userWithAlbums.userAlbumsList[2].id;
                List<AlbumPhotos> albumWithPhotos = phC.listOfAlbumsWithPhotos;
                return Container(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.all(5),
                  color: Colors.green.shade200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Albums:', style: kHeadingStyle),
                      AlbumWidget(userWithAlbums.userAlbumsList[0].title,
                          albumWithPhotos[albumId0 - 1].albumPhotosList[0].thumbnailUrl),
                      AlbumWidget(userWithAlbums.userAlbumsList[1].title,
                          albumWithPhotos[albumId1 - 1].albumPhotosList[0].thumbnailUrl),
                      AlbumWidget(userWithAlbums.userAlbumsList[2].title,
                          albumWithPhotos[albumId2 - 1].albumPhotosList[0].thumbnailUrl),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            Get.to(() => UserAlbumsScreen(userIndex));
                          },
                          child: const Text('See All Albums'),
                        ),
                      ),
                    ],
                  ),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
