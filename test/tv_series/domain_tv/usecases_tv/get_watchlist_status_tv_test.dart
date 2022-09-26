import 'package:ditonton/tv_series/domain_tv/usecases_tv/get_watchlist_status_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../data_tv/helpers_tv/test_helper_tv.mocks.dart';

void main() {
  late GetWatchListStatusTv usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetWatchListStatusTv(mockTvRepository);
  });

  test('should get watchlist status from repository', () async {
    // arrange
    when(mockTvRepository.isAddedToWatchlistTv(1))
        .thenAnswer((_) async => true);
    // act
    final result = await usecase.execute(1);
    // assert
    expect(result, true);
  });
}
