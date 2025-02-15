import 'package:flutter/material.dart';

import 'cliper.dart';

enum _CardVariant { elevated, filled, outlined }

class NotchedCard extends StatefulWidget {
  final GlobalKey guestKey;
  final double notchMargin;
  final NotchedShape? shapeNotch;

  final Color? color;

  final Color? shadowColor;

  final Color? surfaceTintColor;
  final double? elevation;

  final ShapeBorder? shape;

  final bool borderOnForeground;
  final Clip? clipBehavior;
  final EdgeInsetsGeometry? margin;
  final bool semanticContainer;
  final Widget? child;
  final _CardVariant _variant;

  const NotchedCard({
    super.key,
    required this.guestKey,
    this.notchMargin = 2,
    this.shapeNotch,
    this.color,
    this.shadowColor,
    this.surfaceTintColor,
    this.elevation,
    this.shape,
    this.borderOnForeground = true,
    this.margin,
    this.clipBehavior,
    this.child,
    this.semanticContainer = true,
  })  : assert(elevation == null || elevation >= 0.0),
        _variant = _CardVariant.elevated;

  /// Create a filled variant of Card.
  ///
  /// Filled cards provide subtle separation from the background. This has less
  /// emphasis than elevated(default) or outlined cards.
  const NotchedCard.filled({
    super.key,
    required this.guestKey,
    this.notchMargin = 2,
    this.shapeNotch,
    this.color,
    this.shadowColor,
    this.surfaceTintColor,
    this.elevation,
    this.shape,
    this.borderOnForeground = true,
    this.margin,
    this.clipBehavior,
    this.child,
    this.semanticContainer = true,
  })  : assert(elevation == null || elevation >= 0.0),
        _variant = _CardVariant.filled;

  /// Create an outlined variant of Card.
  ///
  /// Outlined cards have a visual boundary around the container. This can
  /// provide greater emphasis than the other types.
  const NotchedCard.outlined({
    super.key,
    required this.guestKey,
    this.notchMargin = 2,
    this.shapeNotch,
    this.color,
    this.shadowColor,
    this.surfaceTintColor,
    this.elevation,
    this.shape,
    this.borderOnForeground = true,
    this.margin,
    this.clipBehavior,
    this.child,
    this.semanticContainer = true,
  })  : assert(elevation == null || elevation >= 0.0),
        _variant = _CardVariant.outlined;

  @override
  State<NotchedCard> createState() => _NotchedCardState();
}

class _NotchedCardState extends State<NotchedCard> {
  final GlobalKey materialKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final CardThemeData cardTheme = CardTheme.of(context);
    final CardThemeData defaults;
    bool isMaterial3 = Theme.of(context).useMaterial3;

    if (isMaterial3) {
      defaults = switch (widget._variant) {
        _CardVariant.elevated => _CardDefaultsM3(context),
        _CardVariant.filled => _FilledCardDefaultsM3(context),
        _CardVariant.outlined => _OutlinedCardDefaultsM3(context),
      };
    } else {
      defaults = _CardDefaultsM2(context);
    }

    final color =
        widget.color ?? cardTheme.color ?? defaults.color ?? theme.cardColor;

    final elevation =
        widget.elevation ?? cardTheme.elevation ?? defaults.elevation!;
    final shadowColor =
        widget.shadowColor ?? cardTheme.shadowColor ?? defaults.shadowColor;
    final Color effectiveColor = isMaterial3
        ? ElevationOverlay.applySurfaceTint(
            color,
            widget.surfaceTintColor ??
                cardTheme.surfaceTintColor ??
                defaults.surfaceTintColor,
            elevation)
        : ElevationOverlay.applyOverlay(context, color, elevation);
    final borderShape = widget.shape ?? cardTheme.shape ?? defaults.shape!;

    final CustomClipper<Path> clipper = widget.shapeNotch != null
        ? NotchCardClipper(
            hostKey: materialKey,
            guestKey: widget.guestKey,
            shape: widget.shapeNotch!,
            notchMargin: widget.notchMargin,
            borderShap: borderShape,
            textDirection: Directionality.maybeOf(context))
        : ShapeBorderClipper(shape: borderShape);

    return Padding(
      padding: widget.margin ?? cardTheme.margin ?? defaults.margin!,
      child: PhysicalShape(
        clipBehavior: widget.clipBehavior ??
            cardTheme.clipBehavior ??
            defaults.clipBehavior!,
        elevation: elevation,
        color: effectiveColor,
        shadowColor: shadowColor ?? Colors.transparent,
        clipper: clipper,
        child: Semantics(
          container: widget.semanticContainer,
          child: Material(
            key: materialKey,
            type: MaterialType.transparency,
            borderOnForeground: widget.borderOnForeground,
            child: Semantics(
              explicitChildNodes: !widget.semanticContainer,
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}

// Hand coded defaults based on Material Design 2.
class _CardDefaultsM2 extends CardThemeData {
  const _CardDefaultsM2(this.context)
      : super(
            clipBehavior: Clip.none,
            elevation: 1.0,
            margin: const EdgeInsets.all(4.0),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
            ));

  final BuildContext context;

  @override
  Color? get color => Theme.of(context).cardColor;

  @override
  Color? get shadowColor => Theme.of(context).shadowColor;
}

// BEGIN GENERATED TOKEN PROPERTIES - Card

// Do not edit by hand. The code between the "BEGIN GENERATED" and
// "END GENERATED" comments are generated from data in the Material
// Design token database by the script:
//   dev/tools/gen_defaults/bin/gen_defaults.dart.

class _CardDefaultsM3 extends CardThemeData {
  _CardDefaultsM3(this.context)
      : super(
          clipBehavior: Clip.none,
          elevation: 1.0,
          margin: const EdgeInsets.all(4.0),
        );

  final BuildContext context;
  late final ColorScheme _colors = Theme.of(context).colorScheme;

  @override
  Color? get color => _colors.surfaceContainerLow;

  @override
  Color? get shadowColor => _colors.shadow;

  @override
  Color? get surfaceTintColor => Colors.transparent;

  @override
  ShapeBorder? get shape => const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12.0)));
}

// END GENERATED TOKEN PROPERTIES - Card

// BEGIN GENERATED TOKEN PROPERTIES - FilledCard

// Do not edit by hand. The code between the "BEGIN GENERATED" and
// "END GENERATED" comments are generated from data in the Material
// Design token database by the script:
//   dev/tools/gen_defaults/bin/gen_defaults.dart.

class _FilledCardDefaultsM3 extends CardThemeData {
  _FilledCardDefaultsM3(this.context)
      : super(
          clipBehavior: Clip.none,
          elevation: 0.0,
          margin: const EdgeInsets.all(4.0),
        );

  final BuildContext context;
  late final ColorScheme _colors = Theme.of(context).colorScheme;

  @override
  Color? get color => _colors.surfaceContainerHighest;

  @override
  Color? get shadowColor => _colors.shadow;

  @override
  Color? get surfaceTintColor => Colors.transparent;

  @override
  ShapeBorder? get shape => const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12.0)));
}

// END GENERATED TOKEN PROPERTIES - FilledCard

// BEGIN GENERATED TOKEN PROPERTIES - OutlinedCard

// Do not edit by hand. The code between the "BEGIN GENERATED" and
// "END GENERATED" comments are generated from data in the Material
// Design token database by the script:
//   dev/tools/gen_defaults/bin/gen_defaults.dart.

class _OutlinedCardDefaultsM3 extends CardThemeData {
  _OutlinedCardDefaultsM3(this.context)
      : super(
          clipBehavior: Clip.none,
          elevation: 0.0,
          margin: const EdgeInsets.all(4.0),
        );

  final BuildContext context;
  late final ColorScheme _colors = Theme.of(context).colorScheme;

  @override
  Color? get color => _colors.surface;

  @override
  Color? get shadowColor => _colors.shadow;

  @override
  Color? get surfaceTintColor => Colors.transparent;

  @override
  ShapeBorder? get shape => const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)))
      .copyWith(side: BorderSide(color: _colors.outlineVariant));
}

// END GENERATED TOKEN PROPERTIES - OutlinedCard
