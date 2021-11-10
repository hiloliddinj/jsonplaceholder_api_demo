import 'package:jsonplaceholder_api_demo/models/album_photos.dart';
import 'package:jsonplaceholder_api_demo/models/photo.dart';
import 'package:get/get.dart';
import 'package:jsonplaceholder_api_demo/services/remote_services.dart';

class PhotosController extends GetxController{
  var isPhotosLoading = true.obs;
  var photosList = <Photo>[].obs;
  var listOfAlbumsWithPhotos = <AlbumPhotos>[].obs;

  @override
  void onInit() {
    fetchPhotos();
    super.onInit();
  }

  void fetchPhotos() async {
    try {
      isPhotosLoading(true);
      var photos = await RemoteServices.fetchAlbumsPhotos();
      if (photos != null) {
        photosList.value = photos;
      }
    } finally {
      List<Photo> albumPhotosList = [];
      for (int i=1; i<101; i++) {
        for(var u in photosList) {
          if (u.albumId == i) {
            albumPhotosList.add(u);
          }
        }
        listOfAlbumsWithPhotos.add(AlbumPhotos(albumPhotosList));
        albumPhotosList = [];
      }
      isPhotosLoading(false);
    }
  }
}