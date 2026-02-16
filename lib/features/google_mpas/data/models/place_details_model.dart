class PlaceDetailsModel {
  final String placeId;
  final String name;
  final String address;
  final double latitude;
  final double longitude;

  PlaceDetailsModel({
    required this.placeId,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  factory PlaceDetailsModel.fromJson(Map<String, dynamic> json) {
    final location = json['result']['geometry']['location'];
    return PlaceDetailsModel(
      placeId: json['result']['place_id'] ?? '',
      name: json['result']['name'] ?? '',
      address: json['result']['formatted_address'] ?? '',
      latitude: location['lat'] ?? 0.0,
      longitude: location['lng'] ?? 0.0,
    );
  }
}