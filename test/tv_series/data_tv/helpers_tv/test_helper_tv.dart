import 'package:ditonton/tv_series/data_tv/datasources/db/database_helper_tv.dart';
import 'package:ditonton/tv_series/data_tv/datasources/tv_local_data_source.dart';
import 'package:ditonton/tv_series/data_tv/datasources/tv_remote_data_source.dart';
import 'package:ditonton/tv_series/domain_tv/repositories_tv/tv_repository.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';

@GenerateMocks([
  TvRepository,
  TvRemoteDataSource,
  TvLocalDataSource,
  TvDatabaseHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
