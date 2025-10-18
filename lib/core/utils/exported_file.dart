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

///product features files
export 'package:hungry/features/product/widgets/spicy_slider.dart';
export 'package:hungry/features/product/widgets/topping_card.dart';

export 'package:hungry/features/home/widgets/card_item.dart';
export 'package:hungry/features/home/widgets//filter_ships/custom_filter_wrap_choice.dart';

export 'package:hungry/features/auth/view/profile_view.dart';
export 'package:hungry/features/home/views/home_view.dart';
export 'package:hungry/features/cart/views/cart_view.dart';
export 'package:hungry/features/orderHistory/views/order_history_view.dart';
