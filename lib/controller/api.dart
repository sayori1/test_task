import 'dart:convert';
import 'package:http/http.dart';
import 'package:test_task/controller/models/user.dart';

import 'models/post.dart';

Future<User?> fetchUser(id) async {
  var response = await makeGETRequest(
      'https://jsonplaceholder.typicode.com/users/' + id.toString());

  if (response.statusCode == 200) {
    var body = jsonDecode(response.body);
    var user = User.fromJson(body);

    var image = await makeGETRequest(
        'https://jsonplaceholder.typicode.com/photos/' + id.toString());
    var imageBody = jsonDecode(image.body);
    print(imageBody);
    user.imageUrl = imageBody['url'];

    return user;
  }
  return null;
}

Future<List<Post>> fetchPosts() async {
  var response =
      await makeGETRequest('https://jsonplaceholder.typicode.com/posts');
  List<Post> posts = [];
  if (response.statusCode == 200) {
    var body = jsonDecode(response.body);
    for (var i = 0; i < body.length; i += 1) {
      posts.add(Post.fromJson(body[i]));
    }
  }
  return posts;
}

Future<Response> makePOSTRequest(String uri, Map<String, dynamic> body) async {
  print(uri);
  var url = Uri.parse(uri);

  var ret = await post(url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
      body: jsonEncode(body));

  return ret;
}

Future<Response> makeGETRequest(String uri) async {
  var url = Uri.parse(uri);

  var ret = get(url, headers: {'Accept': 'application/json'});

  return ret;
}
