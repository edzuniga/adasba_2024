//Casos de uso (en abstracto)

import 'package:adasba_2024/domain/entities/actor.dart';

abstract class ActorRepository {
  Future<List<Actor>> getAllActores(String codaleaOrg);
  Future<Actor> getSpecificActor(int id);
  Future<void> addActor(Actor actor);
  Future<void> updateActor(Actor actor);
  Future<void> deleteActor(int id);
}
