import 'package:equatable/equatable.dart';

class Article extends Equatable{
  final String source;
  final String title;
  final String description;
  final String url;
  final String imageUrl;
  final String dateTime;

  Article({
    this.source,
    this.title,
    this.description,
    this.url,
    this.imageUrl,
    this.dateTime,
  })  : assert(source!=null),
        assert(title!=null),
        assert(url!=null),
        assert(dateTime!=null);

  factory Article.fromJson(Map<String,dynamic> json){
    String dateAndTime=json['publishedAt'].toString().substring(0,10);
    return Article(
      source: json['source']['name'],
      title: json['title'],
      description: json['description'],
      url:json['url'],
      imageUrl: json['urlToImage'],
      dateTime: dateAndTime
    );
  }

  @override
  String toString(){
    String articleToString = """Source: $source \n Title: $title
                                Description: $description \n URL: $url 
                                ImageURL: $imageUrl \n DateTime: $dateTime""";
    return articleToString;
  }

  @override
  List<Object> get props => [source,title,description,url,imageUrl,dateTime];
}
