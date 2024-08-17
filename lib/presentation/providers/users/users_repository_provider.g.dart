// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$usersDataSourceHash() => r'89316a467219787e7e69552ec098bf86ac96dcad';

/// See also [usersDataSource].
@ProviderFor(usersDataSource)
final usersDataSourceProvider = Provider<RemoteUserDataSource>.internal(
  usersDataSource,
  name: r'usersDataSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$usersDataSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UsersDataSourceRef = ProviderRef<RemoteUserDataSource>;
String _$usersRepositoryHash() => r'392061caa8908b9775622eabebd49a9d4de44a37';

/// See also [usersRepository].
@ProviderFor(usersRepository)
final usersRepositoryProvider = Provider<UserRepositoryImpl>.internal(
  usersRepository,
  name: r'usersRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$usersRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UsersRepositoryRef = ProviderRef<UserRepositoryImpl>;
String _$getAllUsersHash() => r'e7c3a2c99704f390acd8e4c816c12a838374f678';

/// See also [getAllUsers].
@ProviderFor(getAllUsers)
final getAllUsersProvider = AutoDisposeProvider<GetAllUsers>.internal(
  getAllUsers,
  name: r'getAllUsersProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getAllUsersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetAllUsersRef = AutoDisposeProviderRef<GetAllUsers>;
String _$getSpecificUserHash() => r'56eb82c5607532a238e139eb166ad1580a27feb8';

/// See also [getSpecificUser].
@ProviderFor(getSpecificUser)
final getSpecificUserProvider = AutoDisposeProvider<GetSpecificUser>.internal(
  getSpecificUser,
  name: r'getSpecificUserProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getSpecificUserHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetSpecificUserRef = AutoDisposeProviderRef<GetSpecificUser>;
String _$addUserHash() => r'989b4077677cd7a74c3ce3e4bca725bdb055310b';

/// See also [addUser].
@ProviderFor(addUser)
final addUserProvider = AutoDisposeProvider<AddUser>.internal(
  addUser,
  name: r'addUserProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$addUserHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AddUserRef = AutoDisposeProviderRef<AddUser>;
String _$updateUserHash() => r'aa435b60282db027f8c81866258e0929e4988c60';

/// See also [updateUser].
@ProviderFor(updateUser)
final updateUserProvider = AutoDisposeProvider<UpdateUser>.internal(
  updateUser,
  name: r'updateUserProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$updateUserHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UpdateUserRef = AutoDisposeProviderRef<UpdateUser>;
String _$deleteUserHash() => r'40dc1a6022b46ed22d831e73ddb1593f06612370';

/// See also [deleteUser].
@ProviderFor(deleteUser)
final deleteUserProvider = AutoDisposeProvider<DeleteUser>.internal(
  deleteUser,
  name: r'deleteUserProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$deleteUserHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef DeleteUserRef = AutoDisposeProviderRef<DeleteUser>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
