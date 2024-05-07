class PostModel {
  String? name;
  String? uId;
  String? image;
  String? postImage;
  String? postVideo;
  String? postDate;
  String? text;

  PostModel({
    this.name,
    this.uId,
    this.postImage,
    this.postDate,
    this.image,
    this.postVideo,
    this.text,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      name: json['name'] ?? '',
      uId: json['uId'] ?? '',
      image: json['image'] ?? '',
      postDate: json['postDate'] ?? '',
      postImage: json['postImage'] ?? '',
      postVideo: json['postVideo'] ?? '',
      text: json['text'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uId': uId,
      'postDate': postDate,
      'postImage': postImage,
      'image': image,
      'postVideo': postVideo,
      'text': text,
    };
  }
}
