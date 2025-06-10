import 'package:flutter_test/flutter_test.dart';
import 'package:chatly/models/chat_user.dart';

void main() {
  test('ChatUser wasRecentlyActive returns true for recent time', () {
    final recentUser = ChatUser(
      uid: "1",
      name: "Test",
      email: "test@email.com",
      imageURL: "image.png",
      lastActive: DateTime.now().subtract(Duration(minutes: 2)),
    );

    expect(recentUser.wasRecentlyActive(), true);
  });

  test('ChatUser wasRecentlyActive returns false for old time', () {
    final inactiveUser = ChatUser(
      uid: "2",
      name: "Old",
      email: "old@email.com",
      imageURL: "image.png",
      lastActive: DateTime.now().subtract(Duration(hours: 1)),
    );

    expect(inactiveUser.wasRecentlyActive(), false);
  });
}
