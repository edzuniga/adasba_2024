//Casos de uso (en abstracto)

import 'package:adasba_2024/domain/entities/indicador.dart';

abstract class IndicadorRepository {
  Future<List<Indicador>> getAllIndicadores(String codaleaOrg);
  Future<Indicador> getSpecificIndicador(int id);
  Future<void> addIndicador(Indicador indicador);
  Future<void> updateIndicador(Indicador indicador);
  Future<void> deleteIndicador(int id);
}
