
class Message {
  static const String collectionName = 'messageCollection';
  String? id;
  String? senderName;
  String? senderId;
  String? content;
  String? roomId;
  int? dateTime;

  Message({
    this.id,
    this.senderName,
    this.senderId,
    this.content,
    this.roomId,
    this.dateTime,
  });

  Message.fromFirestore(Map<String, dynamic> json)
      : id = json['id'],
        senderName = json['senderName'],
        senderId = json['senderId'],
        content = json['content'],
        roomId = json['roomId'],
        dateTime = json['dateTime'];

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'senderName': senderName,
      'senderId': senderId,
      'content': content,
      'roomId': roomId,
      'dateTime': dateTime,
    };
  }
}
