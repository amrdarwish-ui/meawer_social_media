class Post {
  String name;
  String time;
  String userUrl;
  String userId;
  String body;
  String imageUrl;
  int likes;
  int comments;
  String imageName;
  Post({
    required this.name,
    required this.time,
    required this.userUrl,
    required this.userId,
    required this.body,
    required this.imageUrl,
    required this.imageName,
    this.likes = 0,
    this.comments = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'time': time,
      'userUrl': userUrl,
      'userId': userId,
      'body': body,
      'imageUrl': imageUrl,
      'likes': likes,
      'comments': comments,
      'imageName': imageName
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      name: map['name'],
      time: map['time'],
      userUrl: map['userUrl'],
      userId: map['userId'],
      body: map['body'],
      imageUrl: map['imageUrl'],
      likes: map['likes'],
      comments: map['comments'],
      imageName: '',
    );
  }
}
