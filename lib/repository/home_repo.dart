import 'package:dio/dio.dart';
import 'package:women_safety/datasource/remote/dio/dio_client.dart';
import 'package:women_safety/datasource/remote/exception/api_error_handler.dart';
import 'package:women_safety/model/base/api_response.dart';
import 'package:women_safety/provider/home_provider.dart';

class HomeRepo {
  final DioClient dioClient;

  HomeRepo({required this.dioClient});

  Future<ApiResponse> getAllSatellite({int type = 0}) async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try {
      response =
          await dioClient.get('https://api.n2yo.com/rest/v1/satellite/above/24.0178/90.4182/0/70/$type/&apiKey=CR2H2D-TKCVRR-LQ2ZRH-5CFD');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> satelliteDetails({int id = 0}) async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try {
      response = await dioClient
          .get('https://api.n2yo.com/rest/v1/satellite/radiopasses/$id/24.0178/90.4182/0/10/40/&apiKey=CR2H2D-TKCVRR-LQ2ZRH-5CFD');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> astronomyDay() async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try {
      response = await dioClient.get(
          'https://api.nasa.gov/planetary/apod?date=&start_date=&end_date=&count=&thumbs&api_key=bUbVf6O5yhJj8KiA5c3L8pyGpZ5l3U0gDhpGDWlH');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> planets1(String planetName) async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try {
      response = await Dio().get('https://api.api-ninjas.com/v1/planets?name=$planetName',
          options: Options(headers: {'Accept': 'application/json', 'X-Api-Key': 'nCcdx7jf7VYEg0rXp+RyQA==ATvWlEwPdTxjiDB0'}));
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> planets2(String planetName) async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try {
      response = await dioClient.get('https://planets-17f2.onrender.com/planets/getPlanet?name=$planetName',
          options: Options(headers: {'Accept': 'application/json'}));
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  List<SatelliteType> satelliteTypes = [
    SatelliteType(name: 'All', type: 0),
    SatelliteType(name: 'Amateur radio', type: 18),
    SatelliteType(name: 'Beidou Navigation System', type: 35),
    SatelliteType(name: 'Brightest', type: 1),
    SatelliteType(name: 'Celestis', type: 45),
    SatelliteType(name: 'CubeSats', type: 32),
    SatelliteType(name: 'Disaster monitoring', type: 8),
    SatelliteType(name: 'Earth resources', type: 6),
    SatelliteType(name: 'Education', type: 29),
    SatelliteType(name: 'Engineering', type: 28),
    SatelliteType(name: 'Experimental', type: 19),
    SatelliteType(name: 'Flock', type: 48),
    SatelliteType(name: 'Galileo', type: 22),
    SatelliteType(name: 'Geodetic', type: 27),
    SatelliteType(name: 'Geostationary', type: 10),
    SatelliteType(name: 'Global Positioning System', type: 50),
    SatelliteType(name: 'Global Positioning System', type: 20),
    SatelliteType(name: 'Globalstar', type: 17),
    SatelliteType(name: 'Glonass Constellation', type: 51),
    SatelliteType(name: 'Glonass Operational', type: 21),
    SatelliteType(name: 'GOES', type: 5),
    SatelliteType(name: 'Gonets', type: 40),
    SatelliteType(name: 'Gorizont', type: 12),
    SatelliteType(name: 'Intelsat', type: 11),
    SatelliteType(name: 'Iridium', type: 15),
    SatelliteType(name: 'IRNSS', type: 46),
    SatelliteType(name: 'ISS', type: 2),
    SatelliteType(name: 'Lemur', type: 49),
    SatelliteType(name: 'Military', type: 30),
    SatelliteType(name: 'Molniya', type: 14),
    SatelliteType(name: 'Navy Navigation Satellite', type: 24),
    SatelliteType(name: 'NOAA', type: 4),
    SatelliteType(name: 'O3B Networks', type: 43),
    SatelliteType(name: 'OneWeb', type: 53),
    SatelliteType(name: 'Orbcomm', type: 16),
    SatelliteType(name: 'Parus', type: 38),
    SatelliteType(name: 'QZSS', type: 47),
    SatelliteType(name: 'Radar Calibration', type: 31),
    SatelliteType(name: 'Raduga', type: 13),
    SatelliteType(name: 'Russian LEO Navigation', type: 25),
    SatelliteType(name: 'Satellite-Based Augmentation', type: 23),
    SatelliteType(name: 'Search & rescue', type: 7),
    SatelliteType(name: 'Space & Earth Science', type: 26),
    SatelliteType(name: 'Starlink', type: 53),
    SatelliteType(name: 'Strela', type: 39),
    SatelliteType(name: 'Tracking and Data Relay', type: 3),
    SatelliteType(name: 'Tsikada', type: 42),
  ];
}
