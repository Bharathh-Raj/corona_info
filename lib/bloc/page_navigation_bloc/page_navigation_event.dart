import 'package:equatable/equatable.dart';

abstract class PageNavigationEvent extends Equatable{

  @override
  List<Object> get props => null;
}

class ArticlePageEvent extends PageNavigationEvent{}

class LiveCountPageEvent extends PageNavigationEvent{}