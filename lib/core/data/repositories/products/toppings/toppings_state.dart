import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:hungry/core/controller/repo_state_controller.dart';
import 'package:hungry/core/data/repositories/products/toppings/toppings_provider.dart';
import 'package:hungry/core/networks/retrofit/model/topping/topping_model.dart';

final toppingStateProvider =
    StateNotifierProvider<
      RepoStateController<List<ToppingModel>>,
      AsyncValue<List<ToppingModel>>
    >((ref) {
      final repo = ref.watch(toppingProvider);
      return repo.controller;
    });
