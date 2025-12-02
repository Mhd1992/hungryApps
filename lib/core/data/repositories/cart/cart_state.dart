import 'package:hungry/core/controller/repo_state_controller.dart';
import 'package:hungry/core/networks/retrofit/model/cart/request_cart/cart_item_model.dart';
import 'package:hungry/core/utils/exported_file.dart';

import 'cart_provider.dart';

final cartStateProvider =
    StateNotifierProvider<
      RepoStateController<CartItemModel>,
      AsyncValue<CartItemModel>
    >((ref) {
      final repo = ref.watch(cartRepoProvider);
      return repo.controller;
    });
