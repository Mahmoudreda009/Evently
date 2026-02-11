import 'package:evently_assignment/ui/utils/app_colors.dart' show AppColors;
import 'package:flutter/material.dart';
import '../ui/utils/app_styles.dart';

class EventlyButton extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final Widget? icon;
  final VoidCallback onPress;

  const EventlyButton({
    super.key,
    required this.text,
    required this.onPress,
    this.textStyle = AppTextStyles.white18Medium,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style:ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor,
        padding: EdgeInsets.symmetric(vertical:14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))

      ) ,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[icon!, SizedBox(width: 16)],
          Text(text, style: textStyle),
        ],
      ),
    );
  }
}
