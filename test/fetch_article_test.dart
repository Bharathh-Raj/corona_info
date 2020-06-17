import 'package:corona_app/model/article.dart';
import 'package:corona_app/repository/fetch_article.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main(){
  test('Fetch article form API',(){
    when(fetchArticle(any)).thenAnswer((realInvocation) async=> Future.value(
      List.generate(3, (index) => new Article())
    ));
    expect(null,fetchArticle(null).then((value) => value[0].dateTime));
  });
}