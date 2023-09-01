import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProvider with ChangeNotifier {
  String _uid = '';
  String _name = '';
  String _email = '';
  String _phoneNumber = '';
  String _imageUrl = '';

  String get uid => _uid;
  String get name => _name;
  String get email => _email;
  String get phoneNumber => _phoneNumber;
  String get imageUrl => _imageUrl;

  Future<void> loadUserData() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? _firebaseUser = _auth.currentUser;
    if (_firebaseUser != null) {
      _uid = _firebaseUser.uid;
      _name = _firebaseUser.displayName!;
      _email = _firebaseUser.email!;
      _phoneNumber = _firebaseUser.phoneNumber!;
      _imageUrl = _firebaseUser.photoURL!;
    }
    notifyListeners();
  }

  setUserData(String name, String email, String phoneNumber) {
    _name = name;
    _email = email;
    _phoneNumber = phoneNumber;
    notifyListeners();
  }

  updateName(String newName) {
    _name = newName;
    notifyListeners();
  }

  updateEmail(String newEmail) {
    _email = newEmail;
    notifyListeners();
  }

  updatePhoneNumber(String newPhoneNumber) {
    _phoneNumber = newPhoneNumber;
    notifyListeners();
  }
}
