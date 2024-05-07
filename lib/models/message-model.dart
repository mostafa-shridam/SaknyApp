class MessageModel {
  String? senderId;
  String? receiverId;
  String? messageDate;
  String? text;
  String? photo;

  MessageModel({
    this.receiverId,
    this.senderId,
    this.messageDate,
    this.text,
    this.photo,
  });

  factory MessageModel.fromJson(Map<String, dynamic>? json) {
    return MessageModel(
      receiverId: json?['receiverId'] ?? '',
      senderId: json?['senderId'] ?? '',
      messageDate: json?['messageDate'],
      text: json?['text'] ?? '',
      photo: json?['photo'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'receiverId': receiverId,
      'senderId': senderId,
      'messageDate': messageDate,
      'text': text,
      'photo': photo,
    };
  }
}
