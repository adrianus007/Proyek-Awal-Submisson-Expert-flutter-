import 'package:ditonton/common/state_enum.dart';
import 'package:flutter/foundation.dart';
import '../../domain/entities/movie.dart';
import '../../domain/usecases/get_now_playing_movies.dart';

class NowPlayingNotifier extends ChangeNotifier {
  final GetNowPlayingMovies getNowPlaying;

  NowPlayingNotifier(this.getNowPlaying);

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Movie> _movies = [];
  List<Movie> get movies => _movies;

  String _message = '';
  String get message => _message;

  Future<void> fetchNowPlaying() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getNowPlaying.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (moviesData) {
        _movies = moviesData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
