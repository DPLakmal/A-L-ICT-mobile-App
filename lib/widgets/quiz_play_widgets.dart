import 'package:almcq/theme/app_theme.dart';
import 'package:flutter/material.dart';

class OptionTile extends StatelessWidget {
  final String option;
  final String description;
  final String correctAnswer;
  final String optionSelected;

  const OptionTile({
    super.key,
    required this.description,
    required this.correctAnswer,
    required this.option,
    required this.optionSelected,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = optionSelected == description;
    final bool isCorrect = description == correctAnswer;

    Color borderColor = AppTheme.lightCardBorder;
    Color bgColor = Colors.white;
    Color textColor = AppTheme.lightTextPrimary;

    if (optionSelected.isNotEmpty) {
      if (isSelected) {
        if (isCorrect) {
          borderColor = AppTheme.success;
          bgColor = AppTheme.success.withValues(alpha: 0.12);
          textColor = AppTheme.success;
        } else {
          borderColor = AppTheme.error;
          bgColor = AppTheme.error.withValues(alpha: 0.12);
          textColor = AppTheme.error;
        }
      } else if (isCorrect) {
        borderColor = AppTheme.success;
        bgColor = AppTheme.success.withValues(alpha: 0.08);
      }
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: borderColor, width: 1.5),
      ),
      child: Row(
        children: [
          Container(
            height: 30,
            width: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isSelected ? textColor : AppTheme.lightBackground,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              option,
              style: TextStyle(
                color: isSelected ? Colors.white : AppTheme.lightTextSecondary,
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              description,
              style: const TextStyle(
                fontSize: 14.5,
                color: AppTheme.lightTextPrimary,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NoOfQuestionTile extends StatelessWidget {
  final String text;
  final int number;

  const NoOfQuestionTile({
    super.key,
    required this.text,
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
              color: AppTheme.primaryColor,
            ),
            child: Text(
              '$number',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              color: AppTheme.primaryColor.withValues(alpha: 0.15),
            ),
            child: Text(
              text,
              style: const TextStyle(
                color: AppTheme.primaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
