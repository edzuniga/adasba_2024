//Casos de uso (en abstracto)

import 'package:adasba_2024/domain/entities/set_indicador.dart';

abstract class SetIndicadoresRepository {
  Future<List<SetIndicador>> getAllSetIndicadores(String codaleaOrg);
  Future<SetIndicador> getSpecificSetIndicador(int id);
  Future<void> addSetIndicador(SetIndicador setIndicador);
  Future<void> updateSetIndicador(SetIndicador setIndicador);
  Future<void> deleteSetIndicador(int id);
}
