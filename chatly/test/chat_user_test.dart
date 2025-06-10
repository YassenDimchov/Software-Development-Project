import 'package:flutter_test/flutter_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // for Timestamp
import 'package:chatly/models/chat_user.dart';

void main() {
  test('ChatUser is correctly created from JSON', () {
    final data = {
      "uid": "123",
      "name": "LeBron James",
      "email": "lebron@gmail.com",
      "last_active": Timestamp.fromDate(DateTime.parse("2024-06-01T12:00:00Z")),
      "image": "https://image.com/avatar.png",
    };

    final user = ChatUser.fromJSON(data);

    expect(user.uid, "123");
    expect(user.name, "LeBron James");
    expect(user.email, "lebron@gmail.com");
    expect(user.imageURL, "https://image.com/avatar.png");
  });
}
