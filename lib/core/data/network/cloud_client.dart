import 'dart:convert';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CloudClient {
  CloudClient(
    this._functions,
    this._crashlytics,
    this._prefs,
    this._remoteConfig,
  );

  final FirebaseFunctions _functions;
  final FirebaseCrashlytics _crashlytics;
  final SharedPreferences _prefs;
  final FirebaseRemoteConfig _remoteConfig;

  Future<dynamic> get(
    String name, {
    Map<String, dynamic> parameters = const {},
    bool useCache = true,
  }) async {
    // Compare cache versions to use cache
    final remoteCacheVersion = _remoteConfig.getInt('${name}CacheVersion');

    // Use cache
    if (useCache) {
      final localCacheVersion = _prefs.getInt('${name}CacheVersion') ?? -1;
      final remoteAndLocalIsEqual = remoteCacheVersion == localCacheVersion;

      // Check if cache exists
      final cacheExists = _prefs.containsKey('${name}CloudFunction');

      // Get cache
      if (remoteAndLocalIsEqual && cacheExists) return _getCache(name);
    }

    // Get data from network
    return _httpCall(name, remoteCacheVersion, parameters);
  }

  Future<dynamic> post(
    String name, {
    Map<String, dynamic> parameters = const {},
  }) async {
    // Get data from network
    return _httpCall(name, -1, parameters);
  }

  Future<dynamic> _httpCall(String name, int cacheVersion,
      [dynamic parameters]) async {
    try {
      final response = await _functions.httpsCallable(name).call(parameters);
      final data = response.data;

      // Save in cache
      if (cacheVersion >= 0) {
        await _prefs.setString('${name}CloudFunction', json.encode(data));
        await _prefs.setInt('${name}CacheVersion', cacheVersion);
      }

      return data;
    } on FirebaseFunctionsException catch (e, s) {
      if (e.code != 'aborted') await _recordError(e, s);

      throw e;
    } catch (e, s) {
      await _recordError(e, s);
    }
  }

  Future<dynamic> _getCache(String name) async {
    try {
      final cache = _prefs.getString('${name}CloudFunction')!;
      return json.decode(cache);
    } catch (e, s) {
      await _crashlytics.recordError(e, s);
      throw e;
    }
  }

  Future<void> _recordError(e, s) async {
    await _crashlytics.recordError(e, s);
  }
}
