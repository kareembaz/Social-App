class postModel {
  late String? name;
  late String? uId;
  late String? image;
  late String? dateTime;
  late String? text;
  late String? postImage;
  postModel({
    this.name,
    this.uId,
    this.image,
    this.dateTime,
    this.postImage,
    this.text,
  });

  postModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    uId = json['uId'];
    dateTime = json['dateTime'];
    postImage = json['postImage'];
    text = json['text'];
    image = json['image'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uId': uId,
      'image': image,
      'dateTime': dateTime,
      'postImage': postImage,
      'text': text,
    };
  }
}
