import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:hungry/core/models/response_failure.dart';

import 'package:riverpod/riverpod.dart';

import '../networks/failure/handle_response_failure.dart'
    show handelResponseFailure;

typedef EitherResponse<T> = Either<ResponseFailure, T>;
typedef FutureResponse<T> = Future<EitherResponse<T>>;
typedef StreamResponse<T> = Stream<EitherResponse<T>>;

@immutable
abstract class RepoProvider {
  static const FamilyRepoProvider _familyInstance = FamilyRepoProvider._();
  static FamilyRepoProvider get family => _familyInstance;
  static AutoDisposeProvider<FutureResponse<T> Function()> future<T>(
    Future<T> Function(Ref ref) body,
  ) => Provider.autoDispose<FutureResponse<T> Function()>(
    (ref) => () async {
      try {
        final result = await body(ref);
        return right(result);
      } catch (e, stack) {
        return left(handelResponseFailure(e, stack));
      }
    },
  );

  static AutoDisposeProvider<StreamResponse<T> Function()> stream<T>(
    Stream<T> Function(Ref ref) body,
  ) => Provider.autoDispose<StreamResponse<T> Function()>(
    (ref) => () async* {
      try {
        await for (final result in body(ref)) {
          yield right(result);
        }
      } catch (e, stack) {
        yield left(handelResponseFailure(e, stack));
      }
    },
  );
}

@immutable
class FamilyRepoProvider {
  const FamilyRepoProvider._();
  AutoDisposeProviderFamily<FutureResponse<T> Function(), P> future<T, P>(
    Future<T> Function(Ref ref, P value) body,
  ) => Provider.family.autoDispose<FutureResponse<T> Function(), P>(
    (ref, value) => () async {
      try {
        final result = await body(ref, value);
        return right(result);
      } catch (e, stack) {
        return left(handelResponseFailure(e, stack));
      }
    },
  );

  AutoDisposeProviderFamily<StreamResponse<T> Function(), P> stream<T, P>(
    Stream<T> Function(Ref ref, P value) body,
  ) => Provider.family.autoDispose<StreamResponse<T> Function(), P>(
    (ref, value) => () async* {
      try {
        await for (final result in body(ref, value)) {
          yield right(result);
        }
      } catch (e, stack) {
        yield left(handelResponseFailure(e, stack));
      }
    },
  );
}
