import 'package:flutter_test/flutter_test.dart';
import 'package:chatly/models/chat.dart';
import 'package:chatly/models/chat_user.dart';
import 'package:chatly/models/chat_message.dart';

void main() {
  test("Chat is correctly created with valid data", () {
    final mockUser = ChatUser(
      uid: "user1",
      name: "Alice",
      email: "alice@email.com",
      imageURL: "alice.jpg",
      lastActive: DateTime.now(),
    );

    final mockMessage = ChatMessage(
      senderID: "user1",
      content: "Hello!",
      type: MessageType.TEXT,
      sentTime: DateTime.now(),
    );

    final chat = Chat(
      uid: "chat123",
      currentUserUid: "user1",
      members: [mockUser],
      messages: [mockMessage],
      activity: true,
      group: false,
    );

    expect(chat.uid, "chat123");
    expect(chat.currentUserUid, "user1");
    expect(chat.members.length, 1);
    expect(chat.messages.first.content, "Hello!");
    expect(chat.activity, true);
    expect(chat.group, false);
  });
}
