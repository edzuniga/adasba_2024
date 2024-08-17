import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'page_title.g.dart';

@Riverpod(keepAlive: true)
class PageTitle extends _$PageTitle {
  @override
  String build() {
    return 'Dashboard principal';
  }

  void changePageTitle(String title) {
    state = title;
  }
}
