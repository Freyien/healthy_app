import 'package:equatable/equatable.dart';

class LocationEntity extends Equatable {
  LocationEntity({
    required this.uid,
    required this.formattedAddress,
    required this.address,
    required this.lat,
    required this.lng,
  });

  final String uid;
  final String formattedAddress;
  final String address;
  final double lat;
  final double lng;

  factory LocationEntity.initial() => LocationEntity(
        uid: '',
        formattedAddress: '',
        address: '',
        lat: 0,
        lng: 0,
      );

  LocationEntity copyWith({
    String? uid,
    String? formattedAddress,
    String? address,
    double? lat,
    double? lng,
  }) {
    return LocationEntity(
      uid: uid ?? this.uid,
      formattedAddress: formattedAddress ?? this.formattedAddress,
      address: address ?? this.address,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }

  factory LocationEntity.fromGoogleMap(Map<String, dynamic> map) {
    final googleLocation = map['geometry']['location'];

    return LocationEntity(
      uid: '',
      formattedAddress: map['formatted_address'] ?? '',
      address: map['name'] ?? '',
      lat: googleLocation['lat']?.toDouble() ?? 0.0,
      lng: googleLocation['lng']?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'formattedAddress': formattedAddress,
      'address': address,
      'lat': lat,
      'lng': lng,
    };
  }

  @override
  List<Object> get props {
    return [
      uid,
      formattedAddress,
      address,
      lat,
      lng,
    ];
  }
}
