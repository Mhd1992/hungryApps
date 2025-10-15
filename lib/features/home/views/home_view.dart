import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/features/home/widgets/custom_filter_wrap_choice.dart';
import 'package:hungry/features/home/widgets/primitive_grid_view.dart';
import 'package:hungry/shared/custom_text.dart';
import 'package:hungry/shared/logo_image.dart';

import '../widgets/card_item.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: PrimitiveGridView(),
    );
  }
}
