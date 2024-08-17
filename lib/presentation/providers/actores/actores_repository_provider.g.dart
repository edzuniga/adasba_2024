// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'actores_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$actoresDataSourceHash() => r'be0d16ae7cf232966c4808f52ea27f8673deb866';

/// See also [actoresDataSource].
@ProviderFor(actoresDataSource)
final actoresDataSourceProvider = Provider<RemoteActorDataSource>.internal(
  actoresDataSource,
  name: r'actoresDataSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$actoresDataSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ActoresDataSourceRef = ProviderRef<RemoteActorDataSource>;
String _$actoresRepositoryHash() => r'256e492ca6a6d5d1fa3a8835e297f5d9412b1b16';

/// See also [actoresRepository].
@ProviderFor(actoresRepository)
final actoresRepositoryProvider = Provider<ActorRepositoryImpl>.internal(
  actoresRepository,
  name: r'actoresRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$actoresRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ActoresRepositoryRef = ProviderRef<ActorRepositoryImpl>;
String _$getAllActoresHash() => r'59db3806212c7f7ce8826ac61bf455ae8905c0dc';

/// See also [getAllActores].
@ProviderFor(getAllActores)
final getAllActoresProvider = AutoDisposeProvider<GetAllActores>.internal(
  getAllActores,
  name: r'getAllActoresProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getAllActoresHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetAllActoresRef = AutoDisposeProviderRef<GetAllActores>;
String _$getSpecificActorHash() => r'acc28d7a4c59b4576587e4019711b912291994ce';

/// See also [getSpecificActor].
@ProviderFor(getSpecificActor)
final getSpecificActorProvider = AutoDisposeProvider<GetSpecificActor>.internal(
  getSpecificActor,
  name: r'getSpecificActorProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getSpecificActorHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetSpecificActorRef = AutoDisposeProviderRef<GetSpecificActor>;
String _$addActorHash() => r'28bfe3662e0aae1beb47f00cc20f7460016c849c';

/// See also [addActor].
@ProviderFor(addActor)
final addActorProvider = AutoDisposeProvider<AddActor>.internal(
  addActor,
  name: r'addActorProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$addActorHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AddActorRef = AutoDisposeProviderRef<AddActor>;
String _$updateActorHash() => r'dabfa66472e7412ab9275b24aa7d4e554b55e962';

/// See also [updateActor].
@ProviderFor(updateActor)
final updateActorProvider = AutoDisposeProvider<UpdateActor>.internal(
  updateActor,
  name: r'updateActorProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$updateActorHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UpdateActorRef = AutoDisposeProviderRef<UpdateActor>;
String _$deleteActorHash() => r'81d90b37cddb7dbd7354080af109db23ecffd67c';

/// See also [deleteActor].
@ProviderFor(deleteActor)
final deleteActorProvider = AutoDisposeProvider<DeleteActor>.internal(
  deleteActor,
  name: r'deleteActorProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$deleteActorHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef DeleteActorRef = AutoDisposeProviderRef<DeleteActor>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
