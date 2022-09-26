import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/tv_series/domain_tv/entities_tv/tv.dart';
import 'package:ditonton/tv_series/domain_tv/usecases_tv/get_on_air_tv.dart';
import 'package:ditonton/tv_series/domain_tv/usecases_tv/get_popular_tv.dart';
import 'package:ditonton/tv_series/domain_tv/usecases_tv/get_top_rated_tv.dart';
import 'package:ditonton/tv_series/presentation_tv/provider_tv/tv_list_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'tv_list_notifier_test.mocks.dart';


@GenerateMocks([GetOnAirTv, GetPopularTv, GetTopRatedTv])
void main() {
  late TvListNotifier provider;
  late MockGetOnAirTv mockGetOnAirTv;
  late MockGetPopularTv mockGetPopularTv;
  late MockGetTopRatedTv mockGetTopRatedTv;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetOnAirTv = MockGetOnAirTv();
    mockGetPopularTv = MockGetPopularTv();
    mockGetTopRatedTv = MockGetTopRatedTv();
    provider = TvListNotifier(
      getOnAirTv: mockGetOnAirTv,
      getPopularTv: mockGetPopularTv,
      getTopRatedTv: mockGetTopRatedTv,
    )..addListener(() {
      listenerCallCount += 1;
    });
  });

  final tTv = Tv(
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    firstAirDate: 'firstAirDate',
    name: 'name',
    voteAverage: 1,
    voteCount: 1,
  );
  final tTvList = <Tv>[tTv];

  group('now playing tv', () {
    test('initialState should be Empty', () {
      expect(provider.nowPlayingState, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetOnAirTv.execute())
          .thenAnswer((_) async => Right(tTvList));
      // act
      provider.fetchOnAirTv();
      // assert
      verify(mockGetOnAirTv.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetOnAirTv.execute())
          .thenAnswer((_) async => Right(tTvList));
      // act
      provider.fetchOnAirTv();
      // assert
      expect(provider.nowPlayingState, RequestState.Loading);
    });

    test('should change tv when data is gotten successfully', () async {
      // arrange
      when(mockGetOnAirTv.execute())
          .thenAnswer((_) async => Right(tTvList));
      // act
      await provider.fetchOnAirTv();
      // assert
      expect(provider.nowPlayingState, RequestState.Loaded);
      expect(provider.nowPlayingTv, tTvList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetOnAirTv.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchOnAirTv();
      // assert
      expect(provider.nowPlayingState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('popular tv', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetPopularTv.execute())
          .thenAnswer((_) async => Right(tTvList));
      // act
      provider.fetchPopularTv();
      // assert
      expect(provider.popularTvState, RequestState.Loading);
      // verify(provider.setState(RequestState.Loading));
    });

    test('should change tv data when data is gotten successfully',
            () async {
          // arrange
          when(mockGetPopularTv.execute())
              .thenAnswer((_) async => Right(tTvList));
          // act
          await provider.fetchPopularTv();
          // assert
          expect(provider.popularTvState, RequestState.Loaded);
          expect(provider.popularTv, tTvList);
          expect(listenerCallCount, 2);
        });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetPopularTv.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchPopularTv();
      // assert
      expect(provider.popularTvState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('top rated tv', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetTopRatedTv.execute())
          .thenAnswer((_) async => Right(tTvList));
      // act
      provider.fetchTopRatedTv();
      // assert
      expect(provider.topRatedTvState, RequestState.Loading);
    });

    test('should change tv data when data is gotten successfully',
            () async {
          // arrange
          when(mockGetTopRatedTv.execute())
              .thenAnswer((_) async => Right(tTvList));
          // act
          await provider.fetchTopRatedTv();
          // assert
          expect(provider.topRatedTvState, RequestState.Loaded);
          expect(provider.topRatedTv, tTvList);
          expect(listenerCallCount, 2);
        });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTopRatedTv.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTopRatedTv();
      // assert
      expect(provider.topRatedTvState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
