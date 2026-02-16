import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:super_market/features/google_mpas/data/models/place_details_model.dart';
import 'package:super_market/features/google_mpas/data/models/place_model.dart';
import 'package:uuid/uuid.dart';


class PlacesService {
  // Replace with your actual API key
  static const String _apiKey = 'AIzaSyDDcHfppJaxISoKQbWhyXifSq0YrWFSF1o';
  static const String _baseUrl =
      'https://maps.googleapis.com/maps/api/place';
  
  final String _sessionToken = Uuid().v4();

  // Get autocomplete suggestions
  Future<List<PlaceModel>> getAutocompleteSuggestions(String query) async {
    if (query.isEmpty) {
      return [];
    }

    try {
      final url = Uri.parse(
        '$_baseUrl/autocomplete/json?input=$query&key=$_apiKey&sessiontoken=$_sessionToken',
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['status'] == 'OK') {
          final List predictions = data['predictions'];
          return predictions
              .map((prediction) => PlaceModel.fromJson(prediction))
              .toList();
        } else {
          return [];
        }
      } else {
        throw Exception('Failed to load suggestions');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Get place details by place ID
  Future<PlaceDetailsModel> getPlaceDetails(String placeId) async {
    try {
      final url = Uri.parse(
        '$_baseUrl/details/json?place_id=$placeId&key=$_apiKey&sessiontoken=$_sessionToken',
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['status'] == 'OK') {
          return PlaceDetailsModel.fromJson(data);
        } else {
          throw Exception('Place not found');
        }
      } else {
        throw Exception('Failed to load place details');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}