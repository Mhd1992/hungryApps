import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hungry/core/theme/primary_color_provider.dart';

/// Preset theme colors the user can choose from.
final List<Color> _presetColors = [
  const Color(0xff08431D), // default green
  const Color(0xff1B5E20),
  const Color(0xff0D47A1),
  const Color(0xff4A148C),
  const Color(0xffB71C1C),
  const Color(0xffE65100),
  const Color(0xffF57F17),
  const Color(0xff00695C),
  const Color(0xff37474F),
  const Color(0xff6A1B9A),
];

class SettingsView extends ConsumerWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentColor = ref.watch(primaryColorProvider);
    final notifier = ref.read(primaryColorProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: currentColor,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Primary color',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Choose a color to change the app theme.',
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
          const SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1,
            ),
            itemCount: _presetColors.length,
            itemBuilder: (context, index) {
              final color = _presetColors[index];
              final isSelected = currentColor.value == color.value;

              return GestureDetector(
                onTap: () => notifier.setColor(color),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected ? Colors.white : Colors.transparent,
                      width: 3,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: color.withOpacity(0.5),
                        blurRadius: isSelected ? 8 : 4,
                        spreadRadius: isSelected ? 2 : 0,
                      ),
                    ],
                  ),
                  child: isSelected
                      ? const Icon(Icons.check, color: Colors.white, size: 28)
                      : null,
                ),
              );
            },
          ),
          const SizedBox(height: 24),
          OutlinedButton.icon(
            onPressed: () => notifier.setColor(PrimaryColorNotifier.defaultColor),
            icon: const Icon(Icons.restore),
            label: const Text('Reset to default'),
            style: OutlinedButton.styleFrom(
              foregroundColor: currentColor,
              side: BorderSide(color: currentColor),
            ),
          ),
        ],
      ),
    );
  }
}
