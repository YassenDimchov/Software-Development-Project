import 'dart:async';

//Packages
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

//Services
import '../services/database_serivce.dart';
import '../services/cloud_storage_service.dart';
import '../services/media_service.dart';
import '../services/navigation_service.dart';

//Providers
import '../providers/authentiaction_provider.dart';

//Models
import '../models/chat_message.dart';

class ChatPageProvider extends ChangeNotifier {
  late DatabaseSerivce _db;
  late CloudStorageService _storage;
  late MediaService _media;
  late NavigationService _navigation;

  AuthentiactionProvider _auth;
  ScrollController _messagesListViewController;

  String _chatId;
  List<ChatMessage>? messages;

  late StreamSubscription _messageStream;

  String? _message;

  String get message {
    return _message!;
  }

  ChatPageProvider(this._chatId, this._auth, this._messagesListViewController) {
    _db = GetIt.instance.get<DatabaseSerivce>();
    _storage = GetIt.instance.get<CloudStorageService>();
    _navigation = GetIt.instance.get<NavigationService>();
    _media = GetIt.instance.get<MediaService>();
    listenToMessages();
  }

  @override
  void dispose() {
    _messageStream.cancel();
    super.dispose();
  }

  void listenToMessages() {
    try {
      _messageStream = _db.streamMessagesForChat(_chatId).listen((_snapshot) {
        List<ChatMessage> _messages =
            _snapshot.docs.map((_m) {
              Map<String, dynamic> _messageData =
                  _m.data() as Map<String, dynamic>;
              return ChatMessage.fromJSON(_messageData);
            }).toList();
        messages = _messages;
        notifyListeners();
      });
    } catch (e) {
      print(e);
      print("Error getting messages");
    }
  }

  void sendTextMessage() {
    if (_message != null) {
      ChatMessage _messageToSend = ChatMessage(
        senderID: _auth.user.uid,
        type: MessageType.TEXT,
        content: _message!,
        sentTime: DateTime.now(),
      );
      _db.addMessageToChat(_chatId, _messageToSend);
    }
  }

  void sentImageMessage() async {
    try {
      PlatformFile? _file = await _media.pickImageFromLibrary();
      if (_file != null) {
        String? _downloadURL = await _storage.saveChatImageToStorage(
          _chatId,
          _auth.user.uid,
          _file,
        );
        ChatMessage _messageToSend = ChatMessage(
          senderID: _auth.user.uid,
          type: MessageType.IMAGE,
          content: _downloadURL!,
          sentTime: DateTime.now(),
        );
        _db.addMessageToChat(_chatId, _messageToSend);
      }
    } catch (e) {
      print("Error sending image message");
      print(e);
    }
  }

  void delteChat() {
    goBack();
    _db.deleteChat(_chatId);
  }

  void goBack() {
    _navigation.goBack();
  }
}
