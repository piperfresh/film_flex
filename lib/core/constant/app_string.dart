String accountId = '20846584/';
String baseUrl = "https://api.themoviedb.org/3/";
String apiKey = "719c821ece3dffc5e63e38956968f693";
String accessToken =
    "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3MTljODIxZWNlM2RmZmM1ZTYzZTM4OTU2OTY4ZjY5MyIsInN1YiI6IjY1ODJmOWRiODgwNTUxNDA5ZDI3OTQ3ZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.t5WJkD3_FYPDRcpw0riZlP0upGU6ystCNMIErDfJphQ";

class AppString {
  static var movieListEndPoint = "account/${accountId}lists";
  static const popularMoviesEndPoint = "movie/popular";
  static const nowPlayingEndPoint = "movie/now_playing";
  static const upcomingEndPoint = "movie/upcoming";
  static const popularMoviesCastEndPoint = "movie";
  static const searchMovieEndPoint = "search/movie";
  static const baseImageUrl = 'https://image.tmdb.org/t/p/';
}
