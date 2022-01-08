import 'package:flutter/material.dart';
import 'package:shopping_app/app/core/theme/color_theme.dart';
import 'package:shopping_app/app/core/theme/sizing_theme.dart';
import 'package:shopping_app/app/core/utils/helper.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomChip extends StatelessWidget {
  final void Function(bool)? onSelected;

  final bool isSelected;

  final String label;

  CustomChip({
    Key? key,
    required this.isSelected,
    required this.label,
    this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      padding: const EdgeInsets.all(8),
      labelStyle: TextStyle(
        fontSize: 16,
        color: MaterialStateColor.resolveWith(
          (state) {
            if (state.contains(MaterialState.selected)) {
              return Vx.white;
            } else {
              return ColorTheme.headerColor;
            }
          },
        ),
      ),
      selectedColor: primaryColor(context),
      selected: isSelected,
      backgroundColor: Vx.white,
      shape: SelectedBorder(),
      onSelected: onSelected,
    );
  }
}

class SelectedBorder extends RoundedRectangleBorder
    implements MaterialStateOutlinedBorder {
  @override
  OutlinedBorder? resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.selected)) {
      return const RoundedRectangleBorder(
        borderRadius: Sizing.borderRadiusXLL,
        side: BorderSide(
          width: 0.5,
          color: ColorTheme.primaryColor,
        ),
      );
    } else {
      return RoundedRectangleBorder(
        borderRadius: Sizing.borderRadiusXLL,
        side: BorderSide(
          width: 0.5,
          color: Colors.grey.shade200,
        ),
      );
    }
  }
}
