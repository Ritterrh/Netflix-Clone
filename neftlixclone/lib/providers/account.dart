import 'dart:convert';

import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:neftlixclone/api/client.dart';
import 'package:neftlixclone/data/store.dart';

class AccountProvider extends ChangeNotifier {
  User? _current;
  User? get current => _current;

  Session? _session;
  Session? get session => _session;

  Future<Session?> get _cachedSession async {
    final cached = await Store.get("seneftlixclonession");

    if (cached == null) {
      return null;
    }

    return Session.fromMap(json.decode(cached));
  }

  Future<bool> isValid() async {
    if (session == null) {
      final cached = await _cachedSession;

      if (cached == null) {
        return false;
      }

      _session = cached;
    }

    return _session != null;
  }

  //TODO Fehlermeldung hinzufügen
  Future<void> register(String email, String password, String? name) async {
    try {
      final result = await ApiClient.account.create(
          userId: 'unique()', email: email, password: password, name: name);

      _current = result;

      notifyListeners();
    } catch (_e) {
      throw Exception("Failed to register");
    }
  }

  //TODO FIX wenn session schon da das anmelde screen kommt
  Future<void> login(String email, String password) async {
    isSessionActive();
    print(isSessionActive());
    try {
      final result = await ApiClient.account
          .createEmailPasswordSession(email: email, password: password);
      _session = result;

      Store.set("session", json.encode(result.toMap()));

      notifyListeners();
    } catch (e) {
      _session = null;
    }
  }

  Future isSessionActive() async {
    final account = ApiClient.account;
    final sessions = await account.listSessions();

    // Überprüfen, ob eine Sitzung aktiv ist
    return sessions;
  }
}
