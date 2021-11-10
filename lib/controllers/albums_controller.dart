import 'package:jsonplaceholder_api_demo/models/album.dart';
import 'package:jsonplaceholder_api_demo/models/user_albums.dart';
import 'package:get/get.dart';
import 'package:jsonplaceholder_api_demo/services/remote_services.dart';

class AlbumsController extends GetxController{
  var isAlbumsLoading = true.obs;
  var albumList = <Album>[].obs;
  var listOfUsersWithAlbums = <UserAlbums>[].obs;

  @override
  void onInit() {
    fetchAlbums();
    super.onInit();
  }

  void fetchAlbums() async {
    try {
      isAlbumsLoading(true);
      var albums = await RemoteServices.fetchUsersAlbums();
      if (albums != null) {
        albumList.value = albums;
      }
    } finally {
      List<Album> userAlbumsList = [];
      for (int i=1; i<11; i++) {
        for(var u in albumList) {
          if (u.userId == i) {
            userAlbumsList.add(u);
          }
        }
        listOfUsersWithAlbums.add(UserAlbums(userAlbumsList));
        userAlbumsList = [];
      }
      isAlbumsLoading(false);
    }
  }
}