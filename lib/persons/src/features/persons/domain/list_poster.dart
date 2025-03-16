import 'package:notifi/credentials.dart';

enum PosterSize {
  w92,
  w154,
  w185,
  w342,
  w500,
  w780,
  original,
}

Map<PosterSize, String> _posterSizes = {
  PosterSize.w92: "/92x",
  PosterSize.w154: "/154x",
  PosterSize.w185: "/185x",
  PosterSize.w342: "/342x",
  PosterSize.w500: "/500x",
  PosterSize.w780: "/780x",
  PosterSize.original: "/100%",
};

class ListPoster {
  static String tmdbBaseImageUrl = defaultImageProxyUrl;

  static String imageUrl(String path, PosterSize size) {
    return "$tmdbBaseImageUrl${_posterSizes[size]!}/$path";
    //return tmdbBaseImageUrl + "/${size}x/" + path;
  }
}
