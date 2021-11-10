import 'dart:convert';
import 'package:jsonplaceholder_api_demo/models/album.dart';
import 'package:jsonplaceholder_api_demo/models/comment.dart';
import 'package:jsonplaceholder_api_demo/models/photo.dart';
import 'package:jsonplaceholder_api_demo/models/post.dart';
import 'package:http/http.dart' as http;
import 'package:jsonplaceholder_api_demo/models/user.dart';

class RemoteServices {
  static var client = http.Client();


  static Future fetchUsersData() async {
    var response = await client.get(Uri.http('jsonplaceholder.typicode.com', 'users'));

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);

      List<User> userList = [];
      //User(this.id, this.name, this.username, this.email, this.phone, this.website, this.address, this.company);
      for (var u in jsonData) {
        Geo geo = Geo(u['address']['geo']['lat'], u['address']['geo']['lng']);
        Address address = Address(u['address']['street'], u['address']['suite'],
            u['address']['city'], u['address']['zipcode'], geo);
        Company company = Company(u['company']['name'],
            u['company']['catchPhrase'], u['company']['bs']);
        User user = User(u['id'], u['name'], u['username'], u['email'],
            u['phone'], u['website'], address, company);

        userList.add(user);
      }
      return userList;
    } else {
      print('Error in fetching Users');
      return null;
    }
  }


  static Future fetchUsersPosts() async {
    var response = await client.get(Uri.http('jsonplaceholder.typicode.com', 'posts'));

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);

      List<Post> postList = [];
      //Post(this.userId, this.id, this.title, this.body);
      for (var u in jsonData) {
        Post post = Post(u['userId'], u['id'], u['title'], u['body']);
        postList.add(post);
      }
      return postList;
    } else {
      print('Error in fetching Posts');
      return null;
    }
  }

  static Future fetchPostsComments() async {
    var response = await client.get(Uri.http('jsonplaceholder.typicode.com', 'comments'));

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);

      List<Comment> commentList = [];
      //Comment(this.postId, this.id, this.name, this.email, this.body);
      for (var u in jsonData) {
        Comment comment = Comment(u['postId'], u['id'], u['name'], u['email'], u['body']);
        commentList.add(comment);
      }
      return commentList;
    } else {
      print('Error in fetching Comments');
      return null;
    }
  }

  static Future fetchUsersAlbums() async {
    var response = await client.get(Uri.http('jsonplaceholder.typicode.com', 'albums'));

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);

      List<Album> albumList = [];
      //Album(this.userId, this.id, this.title);
      for (var u in jsonData) {
        Album album = Album(u['userId'], u['id'], u['title']);
        albumList.add(album);
      }
      return albumList;
    } else {
      print('Error in fetching Albums');
      return null;
    }
  }

  static Future fetchAlbumsPhotos() async {
    var response = await client.get(Uri.http('jsonplaceholder.typicode.com', 'photos'));

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);

      List<Photo> photosList = [];
      //Photo(this.albumId, this.id, this.title, this.url, this.thumbnailUrl);
      for (var u in jsonData) {
        Photo photo = Photo(u['albumId'], u['id'], u['title'], u['url'], u['thumbnailUrl']);
        photosList.add(photo);
      }
      return photosList;
    } else {
      print('Error in fetching Comments');
      return null;
    }
  }

  static postNewComment(String name, String email, String body, int postId) async {
    try {
      var response = await http.post(
        Uri.parse('https://jsonplaceholder.typicode.com/comments'),
        body: {
          'postId': postId.toString(),
          'id': 501.toString(),
          'name': name,
          'email': email,
          'body': body,
        },
      );
      print(response.body);
    } catch (e){
      print(e);
    }
  }

}