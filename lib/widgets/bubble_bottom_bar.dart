import 'package:flutter/material.dart';

enum BubbleBottomBarFabLocation { end, center }

/// An individual item in [BubbleBottomBar].
class BubbleBottomBarItem {
  final Widget icon;
  final Widget? activeIcon;
  final Widget? title;
  final Color? backgroundColor;
  final bool showBadge;
  final Color badgeColor;
  final Widget? badge;

  const BubbleBottomBarItem({
    required this.icon,
    this.activeIcon,
    this.title,
    this.backgroundColor,
    this.showBadge = false,
    this.badgeColor = const Color(0xFFEF4444),
    this.badge,
  });
}

/// A modern, responsive animated bubble navigation bar.
///
/// Features smooth expanding pill capsules for active items,
/// distinct per-tab active accent colors, responsive text truncation
/// for multilingual labels (Sinhala, Tamil, English), and safe-area compliance.
class BubbleBottomBar extends StatelessWidget {
  final List<BubbleBottomBarItem> items;
  final int currentIndex;
  final ValueChanged<int?>? onTap;
  final double elevation;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final double opacity;
  final bool hasInk;
  final Color? inkColor;
  final double? iconSize;
  final EdgeInsets? tilesPadding;
  final bool hasNotch;
  final BubbleBottomBarFabLocation? fabLocation;

  const BubbleBottomBar({
    super.key,
    required this.items,
    required this.currentIndex,
    this.onTap,
    this.elevation = 10.0,
    this.borderRadius,
    this.backgroundColor,
    this.opacity = 0.15,
    this.hasInk = true,
    this.inkColor,
    this.iconSize = 22.0,
    this.tilesPadding,
    this.hasNotch = false,
    this.fabLocation,
  }) : assert(items.length >= 2, 'BubbleBottomBar must have at least 2 items');

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final barBg = backgroundColor ??
        (isDark ? const Color(0xFF1E293B) : Colors.white);
    final borderColor = isDark
        ? const Color(0xFF334155)
        : const Color(0xFFE2E8F0);

    return Container(
      decoration: BoxDecoration(
        color: barBg,
        borderRadius: borderRadius ??
            const BorderRadius.vertical(top: Radius.circular(22)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.35 : 0.06),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.20 : 0.02),
            blurRadius: 4,
            offset: const Offset(0, -1),
          ),
        ],
        border: Border(
          top: BorderSide(color: borderColor, width: 1),
        ),
      ),
      child: SafeArea(
        top: false,
        bottom: true,
        child: Padding(
          padding: tilesPadding ??
              const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(items.length, (index) {
              return _BubbleTabTile(
                item: items[index],
                isSelected: index == currentIndex,
                opacity: opacity,
                hasInk: hasInk,
                inkColor: inkColor,
                iconSize: iconSize ?? 22.0,
                isDark: isDark,
                onTap: () => onTap?.call(index),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _BubbleTabTile extends StatelessWidget {
  final BubbleBottomBarItem item;
  final bool isSelected;
  final double opacity;
  final bool hasInk;
  final Color? inkColor;
  final double iconSize;
  final bool isDark;
  final VoidCallback onTap;

  const _BubbleTabTile({
    required this.item,
    required this.isSelected,
    required this.opacity,
    required this.hasInk,
    required this.inkColor,
    required this.iconSize,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final activeColor = item.backgroundColor ?? Theme.of(context).primaryColor;
    final inactiveColor = isDark
        ? const Color(0xFF94A3B8)
        : const Color(0xFF64748B);

    Widget iconWidget = isSelected ? (item.activeIcon ?? item.icon) : item.icon;

    if (item.showBadge) {
      iconWidget = Badge(
        backgroundColor: item.badgeColor,
        label: item.badge,
        child: iconWidget,
      );
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        splashColor: hasInk
            ? (inkColor ?? activeColor.withValues(alpha: 0.16))
            : Colors.transparent,
        highlightColor: Colors.transparent,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          padding: isSelected
              ? const EdgeInsets.symmetric(horizontal: 14, vertical: 8)
              : const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? activeColor.withValues(alpha: opacity)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: isSelected
                  ? activeColor.withValues(alpha: 0.28)
                  : Colors.transparent,
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconTheme(
                data: IconThemeData(
                  color: isSelected ? activeColor : inactiveColor,
                  size: iconSize,
                ),
                child: iconWidget,
              ),
              AnimatedCrossFade(
                alignment: Alignment.centerLeft,
                firstChild: Padding(
                  padding: const EdgeInsets.only(left: 7),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 140),
                    child: DefaultTextStyle.merge(
                      style: TextStyle(
                        color: activeColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 12.5,
                        letterSpacing: 0.1,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      child: item.title ?? const SizedBox.shrink(),
                    ),
                  ),
                ),
                secondChild: const SizedBox.shrink(),
                crossFadeState: isSelected
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                duration: const Duration(milliseconds: 250),
                firstCurve: Curves.easeOutCubic,
                secondCurve: Curves.easeInCubic,
                sizeCurve: Curves.easeOutCubic,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
