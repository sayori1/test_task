
class Post{
  int userId;
  int id;
  String title;
  String body;
  Post({required this.userId, required this.id, required this.title, required this.body});
  factory Post.fromJson(json){
    return Post(body: json['body'], title: json['title'], userId: json['userId'], id: json['id']);
  }
}

