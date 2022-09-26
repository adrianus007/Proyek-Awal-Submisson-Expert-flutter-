import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/tv_series/domain_tv/entities_tv/tv.dart';
import 'package:ditonton/tv_series/domain_tv/repositories_tv/tv_repository.dart';

class GetOnAirTv {
  final TvRepository repository;

  GetOnAirTv(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getOnAirTv();
  }
}
