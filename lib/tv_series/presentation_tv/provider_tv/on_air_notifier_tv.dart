import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/tv_series/domain_tv/entities_tv/tv.dart';
import 'package:ditonton/tv_series/domain_tv/usecases_tv/get_on_air_tv.dart';
import 'package:flutter/foundation.dart';

class OnAirNotifier extends ChangeNotifier {
  final GetOnAirTv getOnAirTv;

  OnAirNotifier(this.getOnAirTv);

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Tv> _tv = [];
  List<Tv> get tv => _tv;

  String _message = '';
  String get message => _message;

  Future<void> fetchOnAirTv() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getOnAirTv.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (moviesData) {
        _tv = moviesData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
