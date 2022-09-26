import 'package:dartz/dartz.dart';
import 'package:ditonton/tv_series/domain_tv/entities_tv/tv.dart';
import 'package:ditonton/tv_series/domain_tv/entities_tv/tv_detail.dart';
import '../../../common/failure.dart';

abstract class TvRepository {
  Future<Either<Failure, List<Tv>>> getOnAirTv();
  Future<Either<Failure, TvDetail>> getTvDetail(int id);
  Future<Either<Failure, List<Tv>>> getTvRecommendations(id);
  Future<Either<Failure, List<Tv>>> getPopularTv();
  Future<Either<Failure, List<Tv>>> getTopRatedTv();
  Future<Either<Failure, List<Tv>>> searchTv(String query);
  Future<Either<Failure, String>> saveWatchlistTv(TvDetail movie);
  Future<Either<Failure, String>> removeWatchlistTv(TvDetail movie);
  Future<bool> isAddedToWatchlistTv(int id);
  Future<Either<Failure, List<Tv>>> getWatchlistTv();
}
