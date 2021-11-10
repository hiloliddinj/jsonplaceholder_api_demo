import 'package:carousel_slider/carousel_slider.dart';
import 'package:jsonplaceholder_api_demo/controllers/photos_controller.dart';
import 'package:jsonplaceholder_api_demo/models/photo.dart';
import 'package:jsonplaceholder_api_demo/widgets/prog_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlbumPhotosScreen extends StatelessWidget {
  AlbumPhotosScreen(this.albumId, {Key? key}) : super(key: key);

  final int albumId;

  final PhotosController phC = Get.find<PhotosController>();

  final List<String> photoList = [];

  final List<Photo> photoObjectList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Album Content')),
      body: Center(
        child: Obx(() {
          if (phC.isPhotosLoading()) {
            return const ProgIndicator();
          } else {
            List<Photo> listOfPhotosInAlbum = phC.listOfAlbumsWithPhotos[albumId - 1].albumPhotosList;
            for (Photo u in listOfPhotosInAlbum) {
              photoList.add(u.url);
              photoObjectList.add(u);
            }
            return CarouselSlider(
              options: CarouselOptions(
                aspectRatio: 2.0,
                enlargeCenterPage: true,
                enableInfiniteScroll: false,
                initialPage: 2,
                autoPlay: true,
              ),
              items: sliderWidget(),
            );
          }
        }),
      ),
    );
  }

  List<Widget> sliderWidget() {
    final List<Widget> imageSliders = photoList
        .map((item) => Container(
      margin: const EdgeInsets.all(5.0),
      child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          child: Stack(
            children: <Widget>[
              Image.network(item, fit: BoxFit.cover, width: 1000.0),
              Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(200, 0, 0, 0),
                        Color.fromARGB(0, 0, 0, 0)
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                  child: Text(
                    photoObjectList[photoList.indexOf(item)].title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          )),
    ))
        .toList();

    return imageSliders;
  }
}