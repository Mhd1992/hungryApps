export 'package:flutter/material.dart';
// to exclude RefreshCallback in cupertino.dart
export 'package:flutter/cupertino.dart' hide RefreshCallback;
export 'package:flutter_gap/flutter_gap.dart';
export 'package:flutter_svg/svg.dart';

/// root file
export 'package:hungry/root.dart';
export 'package:hungry/splash_view.dart';

///core and shared files
export 'package:hungry/core/constants/app_colors.dart';
export 'package:hungry/shared/custom_text.dart';
export 'package:hungry/shared/custom_button.dart';
export 'package:hungry/shared/logo_image.dart';
export 'package:hungry/shared/custom_text_form_field.dart';

///features/feat/widgets
export 'package:hungry/features/auth/widgets/custom_auth_btn.dart';
export 'package:hungry/features/product/widgets/spicy_slider.dart';
export 'package:hungry/features/product/widgets/topping_card.dart';
export 'package:hungry/features/home/widgets/card_item.dart';
export 'package:hungry/features/home/widgets//filter_ships/custom_filter_wrap_choice.dart';
export 'package:hungry/features/home/widgets/search_field.dart';
export 'package:hungry/features/home/widgets/user_header.dart';
export 'package:hungry/features/cart/widgets/cart_item.dart';
export 'package:hungry/features/orderHistory/widgets/history_card.dart';
export 'package:hungry/features/checkout/widgets/order_detail.dart';
export 'package:hungry/features/checkout/widgets/visa_list_tile.dart';
export 'package:hungry/features/checkout/widgets/payment_list_tile.dart';
export 'package:hungry/features/checkout/widgets/success_dialog.dart';

///features/feat/views
export 'package:hungry/features/auth/view/profile_view.dart';
export 'package:hungry/features/auth/view/login_view.dart';
export 'package:hungry/features/auth/view/signup_view.dart';
export 'package:hungry/features/home/views/home_view.dart';
export 'package:hungry/features/cart/views/cart_view.dart';
export 'package:hungry/features/orderHistory/views/order_history_view.dart';
export 'package:hungry/features/product/view/product_detail_view.dart';
export 'package:hungry/features/checkout/view/check_out_view.dart';
