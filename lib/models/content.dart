// ignore_for_file: public_member_api_docs, sort_constructors_first
class Content {
  String posterPath;
  String movieName;
  String description;
  String videoUrl;
  Content(
      {required this.posterPath,
      required this.movieName,
      required this.description,
      required this.videoUrl});

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
        posterPath: "http://image.tmdb.org/t/p/w500" + json['poster_path'],
        movieName: json['title'],
        description: json['overview'],
        videoUrl: "https://www.youtube.com/watch?v=YLslsZuEaNE&t=1s");
  }

  @override
  String toString() {
    return "$posterPath , $movieName, $description, $videoUrl";
  }
}
