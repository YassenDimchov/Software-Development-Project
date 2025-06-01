//Packages
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

//Services
import '../services/database_serivce.dart';
import '../services/navigation_service.dart';

//Models
import '../models/chat_user.dart';

class AuthentiactionProvider extends ChangeNotifier {
  late final FirebaseAuth _auth;
  late final NavigationService _navigationService;
  late final DatabaseSerivce _databaseSerivce;

  late ChatUser user;

  AuthentiactionProvider() {
    _auth = FirebaseAuth.instance;
    _navigationService = GetIt.instance.get<NavigationService>();
    _databaseSerivce = GetIt.instance.get<DatabaseSerivce>();

    //_auth.signOut(); // Uncomment this if you want to force logout on startup (not usually recommended)

    _auth.authStateChanges().listen((_user) {
      if (_user != null) {
        _databaseSerivce.updateUserLastSeenTime(_user.uid);

        _databaseSerivce
            .getUser(_user.uid)
            .then((_snapshot) {
              final data = _snapshot.data() as Map<String, dynamic>?;

              if (data == null) {
                print(
                  "⚠️ Firestore user document not found for UID: ${_user.uid}",
                );
                return;
              }

              user = ChatUser.fromJSON({
                "uid": _user.uid,
                "name": data["name"],
                "email": data["email"],
                "last_active": data["last_active"],
                "image": data["image"],
              });

              _navigationService.removeAndNavigateToRoute('/home');
            })
            .catchError((e) {
              print("❌ Error fetching user document: $e");
            });
      } else {
        _navigationService.removeAndNavigateToRoute('/login');
      }
    });
  }

  Future<void> loginUsingEmailAndPassword(
    String _email,
    String _password,
  ) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: _email,
        password: _password,
      );
      print(_auth.currentUser);
    } on FirebaseException {
      print("Erorr logging user into Firebase");
    } catch (e) {
      print(e);
    }
  }

  Future<String?> registerUserUsingEmailAndPassword(
    String _email,
    String _password,
  ) async {
    try {
      UserCredential _credentials = await _auth.createUserWithEmailAndPassword(
        email: _email,
        password: _password,
      );
      return _credentials.user!.uid;
    } on FirebaseAuthException {
      print("Error registering user.");
    } catch (e) {
      print(e);
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e);
    }
  }
}
