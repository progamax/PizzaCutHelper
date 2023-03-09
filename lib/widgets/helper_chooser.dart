import 'package:flutter/material.dart';

class HelperChooser extends StatefulWidget {
  final List<Icon> icons;
  final double size;
  final void Function(int)? onSelectedIcon;
  const HelperChooser(this.icons, {super.key, this.size = 24.0, this.onSelectedIcon});
  @override
  State<HelperChooser> createState() => _HelperChooserState();
}

class _HelperChooserState extends State<HelperChooser> {
  int selectedButtonIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    return Material(
      elevation: 25.0,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(widget.icons.length, (index) {
          bool isSelected = (index == selectedButtonIndex);
          Icon icon = widget.icons[index];

          return IconButton(
            isSelected: isSelected,
            onPressed: () {
              setState(() {
                selectedButtonIndex = index;
              });
              widget.onSelectedIcon?.call(index);
            },
            icon: icon,
            iconSize: widget.size,
            style: IconButton.styleFrom(
                foregroundColor: isSelected ? colors.onPrimary : colors.primary,
                backgroundColor: isSelected ? colors.primary : colors.surfaceVariant,
                disabledBackgroundColor: colors.onSurface.withOpacity(0.12),
                hoverColor: colors.onPrimary.withOpacity(0.08),
                focusColor: colors.onPrimary.withOpacity(0.12),
                highlightColor: colors.onPrimary.withOpacity(0.12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.horizontal(
                        left: index == 0 ? const Radius.circular(15) : Radius.zero,
                        right: index == (widget.icons.length - 1) ? const Radius.circular(15) : Radius.zero))),
          );
        }),
      ),
    );
  }
}
