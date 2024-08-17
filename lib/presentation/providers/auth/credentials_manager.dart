import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'credentials_manager.g.dart';

@Riverpod(keepAlive: true)
class UserCredentials extends _$UserCredentials {
  @override
  Map<String, String> build() {
    return {};
  }

  void setUserCredentials(Map<String, String> map) {
    state.clear();
    state = map;
  }

  void resetUserCredentials() {
    state.clear();
  }
}
