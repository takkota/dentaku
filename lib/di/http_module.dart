
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:dentaku/resources/api/rest_client.dart';

@registerModule
abstract class HttpModule {
  Dio get dio => Dio();
  RestClient get restClient => RestClient(dio);
}