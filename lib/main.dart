import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/tv_series/presentation_tv/page_tv/home_tv.dart';
import 'package:ditonton/tv_series/presentation_tv/page_tv/on_air_page.dart';
import 'package:ditonton/tv_series/presentation_tv/page_tv/popular_tv_page.dart';
import 'package:ditonton/tv_series/presentation_tv/page_tv/search_tv_page.dart';
import 'package:ditonton/tv_series/presentation_tv/page_tv/top_rated_tv_page.dart';
import 'package:ditonton/tv_series/presentation_tv/page_tv/tv_detail_page.dart';
import 'package:ditonton/tv_series/presentation_tv/page_tv/watchlist_tv_page.dart';
import 'package:ditonton/tv_series/presentation_tv/provider_tv/on_air_notifier_tv.dart';
import 'package:ditonton/tv_series/presentation_tv/provider_tv/popular_tv_notifier.dart';
import 'package:ditonton/tv_series/presentation_tv/provider_tv/search_tv_notifier.dart';
import 'package:ditonton/tv_series/presentation_tv/provider_tv/top_rated_tv_notifier.dart';
import 'package:ditonton/tv_series/presentation_tv/provider_tv/tv_detail_notifier.dart';
import 'package:ditonton/tv_series/presentation_tv/provider_tv/tv_list_notifier.dart';
import 'package:ditonton/tv_series/presentation_tv/provider_tv/watchlist_tv_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;
import 'movies/presentation/pages/about_page.dart';
import 'movies/presentation/pages/home_movie_page.dart';
import 'movies/presentation/pages/movie_detail_page.dart';
import 'movies/presentation/pages/now_playing_page.dart';
import 'movies/presentation/pages/popular_movies_page.dart';
import 'movies/presentation/pages/search_page.dart';
import 'movies/presentation/pages/top_rated_movies_page.dart';
import 'movies/presentation/pages/watchlist_movies_page.dart';
import 'movies/presentation/provider/movie_detail_notifier.dart';
import 'movies/presentation/provider/movie_list_notifier.dart';
import 'movies/presentation/provider/movie_search_notifier.dart';
import 'movies/presentation/provider/now_palying_notifier.dart';
import 'movies/presentation/provider/popular_movies_notifier.dart';
import 'movies/presentation/provider/top_rated_movies_notifier.dart';
import 'movies/presentation/provider/watchlist_movie_notifier.dart';

void main() {
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<NowPlayingNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<OnAirNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedTvNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularTvNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistMovieNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistTvNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<OnAirNotifier>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case NowPlayingPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => NowPlayingPage());
            case OnAirPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => OnAirPage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case PopularTvPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularTvPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case TopRatedTvPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedTvPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case SearchPageTv.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPageTv());
            case WatchlistMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case WatchlistTvPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistTvPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            case HomeTvPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => HomeTvPage());
            case TvDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvDetailPage(id: id),
                settings: settings,
              );
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
