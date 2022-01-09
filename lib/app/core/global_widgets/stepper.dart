import 'package:custom_utils/spacing_utils.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/app/core/theme/sizing_theme.dart';
import 'package:velocity_x/velocity_x.dart';

const _kButtonWidth = 32.0;
const _kButtonHeight = 32.0;

class CustomStepper extends StatelessWidget {
  final int value;
  final VoidCallback onDecrementTap;
  final VoidCallback onIncrementTap;
  final double textSize;
  final double buttonHeight;
  final double buttonWidth;

  const CustomStepper({
    Key? key,
    required this.value,
    required this.onDecrementTap,
    required this.onIncrementTap,
    this.textSize = 18,
    this.buttonHeight = _kButtonHeight,
    this.buttonWidth = _kButtonWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Vx.white,
      shape: RoundedRectangleBorder(
        borderRadius: Sizing.borderRadiusS,
        side: BorderSide(
          width: 0.5,
          color: Colors.grey.shade200,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _StepperButton(
            icon: Icons.remove,
            onTap: onDecrementTap,
            buttonHeight: buttonHeight,
            buttonWidth: buttonWidth,
          ),
          horSpacing10,
          "$value".text.bold.size(textSize).make(),
          horSpacing10,
          _StepperButton(
            buttonHeight: buttonHeight,
            buttonWidth: buttonWidth,
            icon: Icons.add,
            onTap: onIncrementTap,
          ),
        ],
      ),
    );
  }
}

class _StepperButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final double buttonHeight;
  final double buttonWidth;

  const _StepperButton({
    Key? key,
    required this.icon,
    required this.onTap,
    required this.buttonHeight,
    required this.buttonWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.zero,
      shape: Sizing.cardShape,
      onPressed: onTap,
      child: Icon(icon, size: 20),
    ).box.size(_kButtonWidth, _kButtonHeight).make();
  }
}
