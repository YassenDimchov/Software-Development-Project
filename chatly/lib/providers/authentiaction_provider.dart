//Packages
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

//Services
import '../services/database_serivce.dart';
import '../services/navigation_service.dart';

class AuthentiactionProvider extends ChangeNotifier {
  late final FirebaseAuth _auth;
  late final NavigationService _navigationService;
  late final DatabaseSerivce _databaseSerivce;

  AuthentiactionProvider() {
    _auth = FirebaseAuth.instance;
    _navigationService = GetIt.instance.get<NavigationService>();
    _databaseSerivce = GetIt.instance.get<DatabaseSerivce>();
  }
}
