import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_colors.dart';

const String _primaryColorKey = 'primary_color';

/// Must be overridden in main() with SharedPreferences instance.
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError(
    'Override sharedPreferencesProvider in main() with SharedPreferences.getInstance()',
  );
});

final primaryColorProvider =
    StateNotifierProvider<PrimaryColorNotifier, Color>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return PrimaryColorNotifier(prefs);
});

class PrimaryColorNotifier extends StateNotifier<Color> {
  PrimaryColorNotifier(this._prefs, [Color? initialColor])
      : super(initialColor ?? _defaultColor) {
    if (initialColor == null) {
      _load();
    } else {
      AppColors.primaryColor = initialColor;
    }
  }

  static const Color _defaultColor = Color(0xff08431D);
  final SharedPreferences _prefs;

  Future<void> _load() async {
    final value = _prefs.getInt(_primaryColorKey) ?? _defaultColor.value;
    state = Color(value);
    AppColors.primaryColor = state;
  }

  /// Saves the selected color to SharedPreferences and updates the app theme.
  Future<void> setColor(Color color) async {
    await _prefs.setInt(_primaryColorKey, color.value);
    state = color;
    AppColors.primaryColor = color;
  }

  /// Default color used when none is saved.
  static Color get defaultColor => _defaultColor;
}
