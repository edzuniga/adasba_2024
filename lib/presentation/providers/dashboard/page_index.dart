import 'package:adasba_2024/presentation/providers/dashboard/page_title.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'page_index.g.dart';

@Riverpod(keepAlive: true)
class PageIndex extends _$PageIndex {
  @override
  int build() {
    return 0;
  }

  void changePageIndex(int i) {
    state = i;

    /*
      0 -> Inicio
      1 -> Planes
      2 -> Mediciones
      3 -> Central de Información
      4 -> Usuarios
      5 -> Proyectos
      6 -> Componentes
      7 -> Indicadores
      8 -> Compromisos
      9 -> Actores
      10 -> Beneficiarios
      11 -> Fuentes_financiamiento
      12 -> Gestión Documental
    */

    String pageTitle = '';

    switch (i) {
      case 0:
        pageTitle = 'Dashboard principal';
        break;
      case 1:
        pageTitle = 'Planes';
        break;
      case 2:
        pageTitle = 'Mediciones';
        break;
      case 3:
        pageTitle = 'Central de información';
        break;
      case 4:
        pageTitle = 'Usuarios';
        break;
      case 5:
        pageTitle = 'Proyectos';
        break;
      case 6:
        pageTitle = 'Componentes';
        break;
      case 7:
        pageTitle = 'Indicadores';
        break;
      case 8:
        pageTitle = 'Compromiso, Normativa o Ley';
        break;
      case 9:
        pageTitle = 'Actores Participantes';
        break;
      case 10:
        pageTitle = 'Grupos Beneficiarios';
        break;
      case 11:
        pageTitle = 'Fuentes de Financiamiento';
        break;
      case 12:
        pageTitle = 'Gestión documental';
        break;
      default:
        pageTitle = 'Dashboard principal';
        break;
    }

    ref.read(pageTitleProvider.notifier).changePageTitle(pageTitle);
  }
}
