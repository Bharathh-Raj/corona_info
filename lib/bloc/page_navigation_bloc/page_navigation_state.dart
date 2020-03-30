import 'package:equatable/equatable.dart';

abstract class PageNavigationState extends Equatable{
  @override
  List<Object> get props => null;
}

class ArticlePageState extends PageNavigationState{}

class LiveCountPageState extends PageNavigationState{}

class StateStatPageState extends PageNavigationState{}