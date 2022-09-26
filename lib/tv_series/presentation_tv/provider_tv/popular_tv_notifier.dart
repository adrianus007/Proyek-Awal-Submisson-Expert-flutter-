import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/tv_series/domain_tv/entities_tv/tv.dart';
import 'package:ditonton/tv_series/domain_tv/usecases_tv/get_popular_tv.dart';
import 'package:flutter/foundation.dart';

class PopularTvNotifier extends ChangeNotifier {
  final GetPopularTv getPopularTv;

  PopularTvNotifier(this.getPopularTv);

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Tv> _tv = [];
  List<Tv> get tv => _tv;

  String _message = '';
  String get message => _message;

  Future<void> fetchPopularTv() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTv.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (tvData) {
        _tv = tvData.cast<Tv>();
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
