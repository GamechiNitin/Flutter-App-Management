class PostsModel {
  int? userId;
  int? id;
  String? body;
  String? title;

  PostsModel({this.userId, this.id, this.body, this.title});

  PostsModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    body = json['body'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['id'] = id;
    data['body'] = body;
    data['title'] = title;
    return data;
  }
}
