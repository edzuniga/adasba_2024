import 'package:adasba_2024/data/datasources/actor_datasource.dart';
import 'package:adasba_2024/domain/entities/actor.dart';
import 'package:adasba_2024/domain/repositories/actor_repository.dart';

class ActorRepositoryImpl implements ActorRepository {
  final ActorDataSource actorDataSource;

  ActorRepositoryImpl({required this.actorDataSource});

  @override
  Future<void> addActor(Actor actor) {
    return actorDataSource.addActor(actor);
  }

  @override
  Future<void> deleteActor(int id) {
    return actorDataSource.deleteActor(id);
  }

  @override
  Future<List<Actor>> getAllActores(String codaleaOrg) {
    return actorDataSource.getAllActores(codaleaOrg);
  }

  @override
  Future<Actor> getSpecificActor(int id) {
    return actorDataSource.getSpecificActor(id);
  }

  @override
  Future<void> updateActor(Actor actor) {
    return actorDataSource.updateActor(actor);
  }
}
