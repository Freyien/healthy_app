import 'dart:convert';

import 'package:equatable/equatable.dart';

class AppVersionStatus extends Equatable {
  final int mandatoryVersion;
  final int optionalVersion;
  final int currentVersion;
  final String androidStoreLink;
  final String iosStoreLink;

  AppVersionStatus({
    this.mandatoryVersion = 0,
    this.optionalVersion = 0,
    this.currentVersion = 0,
    this.androidStoreLink = '',
    this.iosStoreLink = '',
  });

  factory AppVersionStatus.fromMap(Map<String, dynamic> map) {
    return AppVersionStatus(
      mandatoryVersion: int.tryParse(map['mandatory_version']) ?? 0,
      optionalVersion: int.tryParse(map['optional_version']) ?? 0,
      androidStoreLink: map['android_store_link'] ?? '',
      iosStoreLink: map['ios_store_link'] ?? '',
      currentVersion: 0,
    );
  }

  factory AppVersionStatus.fromJson(String source) =>
      AppVersionStatus.fromMap(json.decode(source) as Map<String, dynamic>);

  // Getters
  UpdateVersionType get type {
    if (currentVersion < mandatoryVersion) return UpdateVersionType.mandatory;

    if (currentVersion < optionalVersion) return UpdateVersionType.optional;

    return UpdateVersionType.none;
  }

  bool get updateIsRequired => !(type == UpdateVersionType.none);
  bool get updateIsNotRequired => type == UpdateVersionType.none;

  AppVersionStatus copyWith({
    int? mandatoryVersion,
    int? optionalVersion,
    int? currentVersion,
    String? androidStoreLink,
    String? iosStoreLink,
  }) {
    return AppVersionStatus(
      mandatoryVersion: mandatoryVersion ?? this.mandatoryVersion,
      optionalVersion: optionalVersion ?? this.optionalVersion,
      currentVersion: currentVersion ?? this.currentVersion,
      androidStoreLink: androidStoreLink ?? this.androidStoreLink,
      iosStoreLink: iosStoreLink ?? this.iosStoreLink,
    );
  }

  @override
  List<Object> get props {
    return [
      mandatoryVersion,
      optionalVersion,
      currentVersion,
      androidStoreLink,
      iosStoreLink,
    ];
  }
}

enum UpdateVersionType { mandatory, optional, none }
