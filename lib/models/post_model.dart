class PostModel {
  String? firstname;
  String? lastname;
  String? content;
  String? data;
  String? id;
  String? image;
  

  PostModel({this.firstname, this.lastname, this.content, this.data, this.id, this.image});

  PostModel.fromJson(Map<String, dynamic> json) {
    firstname = json['firstname'];
    lastname = json['lastname'];
    content = json['content'];
    data = json['data'];
    id = json['id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    return {
      "firstname": firstname,
      "lastname": lastname,
      "content": content,
      "data": data,
      "id": id,
      "image": image,
    };
  }
}
