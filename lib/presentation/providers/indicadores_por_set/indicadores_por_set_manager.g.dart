// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'indicadores_por_set_manager.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$indicadoresPorSetManagerHash() =>
    r'bca763501f25c8253cf30792cc1603c6a09675e1';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$IndicadoresPorSetManager
    extends BuildlessAutoDisposeAsyncNotifier<List<IndicadoresPorSet>> {
  late final int idSet;

  FutureOr<List<IndicadoresPorSet>> build(
    int idSet,
  );
}

/// See also [IndicadoresPorSetManager].
@ProviderFor(IndicadoresPorSetManager)
const indicadoresPorSetManagerProvider = IndicadoresPorSetManagerFamily();

/// See also [IndicadoresPorSetManager].
class IndicadoresPorSetManagerFamily
    extends Family<AsyncValue<List<IndicadoresPorSet>>> {
  /// See also [IndicadoresPorSetManager].
  const IndicadoresPorSetManagerFamily();

  /// See also [IndicadoresPorSetManager].
  IndicadoresPorSetManagerProvider call(
    int idSet,
  ) {
    return IndicadoresPorSetManagerProvider(
      idSet,
    );
  }

  @override
  IndicadoresPorSetManagerProvider getProviderOverride(
    covariant IndicadoresPorSetManagerProvider provider,
  ) {
    return call(
      provider.idSet,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'indicadoresPorSetManagerProvider';
}

/// See also [IndicadoresPorSetManager].
class IndicadoresPorSetManagerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<IndicadoresPorSetManager,
        List<IndicadoresPorSet>> {
  /// See also [IndicadoresPorSetManager].
  IndicadoresPorSetManagerProvider(
    int idSet,
  ) : this._internal(
          () => IndicadoresPorSetManager()..idSet = idSet,
          from: indicadoresPorSetManagerProvider,
          name: r'indicadoresPorSetManagerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$indicadoresPorSetManagerHash,
          dependencies: IndicadoresPorSetManagerFamily._dependencies,
          allTransitiveDependencies:
              IndicadoresPorSetManagerFamily._allTransitiveDependencies,
          idSet: idSet,
        );

  IndicadoresPorSetManagerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.idSet,
  }) : super.internal();

  final int idSet;

  @override
  FutureOr<List<IndicadoresPorSet>> runNotifierBuild(
    covariant IndicadoresPorSetManager notifier,
  ) {
    return notifier.build(
      idSet,
    );
  }

  @override
  Override overrideWith(IndicadoresPorSetManager Function() create) {
    return ProviderOverride(
      origin: this,
      override: IndicadoresPorSetManagerProvider._internal(
        () => create()..idSet = idSet,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        idSet: idSet,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<IndicadoresPorSetManager,
      List<IndicadoresPorSet>> createElement() {
    return _IndicadoresPorSetManagerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is IndicadoresPorSetManagerProvider && other.idSet == idSet;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, idSet.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin IndicadoresPorSetManagerRef
    on AutoDisposeAsyncNotifierProviderRef<List<IndicadoresPorSet>> {
  /// The parameter `idSet` of this provider.
  int get idSet;
}

class _IndicadoresPorSetManagerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<IndicadoresPorSetManager,
        List<IndicadoresPorSet>> with IndicadoresPorSetManagerRef {
  _IndicadoresPorSetManagerProviderElement(super.provider);

  @override
  int get idSet => (origin as IndicadoresPorSetManagerProvider).idSet;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
