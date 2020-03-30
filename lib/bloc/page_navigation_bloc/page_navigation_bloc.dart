import 'package:bloc/bloc.dart';

import 'page_navigation_event.dart';
import 'page_navigation_state.dart';

class PageNavigationBloc extends Bloc<PageNavigationEvent, PageNavigationState> {
  @override
  PageNavigationState get initialState => LiveCountPageState();

  @override
  Stream<PageNavigationState> mapEventToState(
    PageNavigationEvent event,
  ) async* {
    if(event is ArticlePageEvent)
      yield ArticlePageState();
    else if(event is LiveCountPageEvent)
      yield LiveCountPageState();
    else if(event is StateStatPageEvent)
      yield StateStatPageState();
  }
}