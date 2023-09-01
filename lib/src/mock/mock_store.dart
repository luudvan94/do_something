import 'package:do_something/src/redux/init_redux.dart';
import 'package:mockito/mockito.dart';
import 'package:redux/redux.dart';

class MockStore extends Mock implements Store<AppState> {}
