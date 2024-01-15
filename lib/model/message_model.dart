class MessageModel {
  late String? sendId;
  late String? reseiverId;
  late String? dateTime;
  late String? text;

  MessageModel({
    this.sendId,
    this.reseiverId,
    this.dateTime,
    this.text,
  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    sendId = json['sendId'];
    reseiverId = json['reseiverId'];
    dateTime = json['dateTime'];
    text = json['text'];
  }

  Map<String, dynamic> toMap() {
    return {
      'sendId': sendId,
      'reseiverId': reseiverId,
      'dateTime': dateTime,
      'text': text,
    };
  }
}
