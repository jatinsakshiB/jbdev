// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// @docImport 'dart:ui';
library;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'jb_modal_barrier.dart';


const Duration _bottomSheetEnterDuration = Duration(milliseconds: 250);
const Duration _bottomSheetExitDuration = Duration(milliseconds: 200);
const Curve _modalBottomSheetCurve = Easing.legacyDecelerate;

const double _defaultScrollControlDisabledMaxHeightRatio = 9.0 / 16.0;



class _BottomSheetLayoutWithSizeListener extends SingleChildRenderObjectWidget {
  const _BottomSheetLayoutWithSizeListener({
    required this.onChildSizeChanged,
    required this.animationValue,
    required this.isScrollControlled,
    required this.scrollControlDisabledMaxHeightRatio,
    super.child,
  });

  final ValueChanged<Size> onChildSizeChanged;
  final double animationValue;
  final bool isScrollControlled;
  final double scrollControlDisabledMaxHeightRatio;

  @override
  _RenderBottomSheetLayoutWithSizeListener createRenderObject(BuildContext context) {
    return _RenderBottomSheetLayoutWithSizeListener(
      onChildSizeChanged: onChildSizeChanged,
      animationValue: animationValue,
      isScrollControlled: isScrollControlled,
      scrollControlDisabledMaxHeightRatio: scrollControlDisabledMaxHeightRatio,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context,
      _RenderBottomSheetLayoutWithSizeListener renderObject,
      ) {
    renderObject.onChildSizeChanged = onChildSizeChanged;
    renderObject.animationValue = animationValue;
    renderObject.isScrollControlled = isScrollControlled;
    renderObject.scrollControlDisabledMaxHeightRatio = scrollControlDisabledMaxHeightRatio;
  }
}

class _RenderBottomSheetLayoutWithSizeListener extends RenderShiftedBox {
  _RenderBottomSheetLayoutWithSizeListener({
    RenderBox? child,
    required ValueChanged<Size> onChildSizeChanged,
    required double animationValue,
    required bool isScrollControlled,
    required double scrollControlDisabledMaxHeightRatio,
  }) : _onChildSizeChanged = onChildSizeChanged,
        _animationValue = animationValue,
        _isScrollControlled = isScrollControlled,
        _scrollControlDisabledMaxHeightRatio = scrollControlDisabledMaxHeightRatio,
        super(child);

  Size _lastSize = Size.zero;

  ValueChanged<Size> get onChildSizeChanged => _onChildSizeChanged;
  ValueChanged<Size> _onChildSizeChanged;
  set onChildSizeChanged(ValueChanged<Size> newCallback) {
    if (_onChildSizeChanged == newCallback) {
      return;
    }

    _onChildSizeChanged = newCallback;
    markNeedsLayout();
  }

  double get animationValue => _animationValue;
  double _animationValue;
  set animationValue(double newValue) {
    if (_animationValue == newValue) {
      return;
    }

    _animationValue = newValue;
    markNeedsLayout();
  }

  bool get isScrollControlled => _isScrollControlled;
  bool _isScrollControlled;
  set isScrollControlled(bool newValue) {
    if (_isScrollControlled == newValue) {
      return;
    }

    _isScrollControlled = newValue;
    markNeedsLayout();
  }

  double get scrollControlDisabledMaxHeightRatio => _scrollControlDisabledMaxHeightRatio;
  double _scrollControlDisabledMaxHeightRatio;
  set scrollControlDisabledMaxHeightRatio(double newValue) {
    if (_scrollControlDisabledMaxHeightRatio == newValue) {
      return;
    }

    _scrollControlDisabledMaxHeightRatio = newValue;
    markNeedsLayout();
  }

  @override
  double computeMinIntrinsicWidth(double height) => 0.0;

  @override
  double computeMaxIntrinsicWidth(double height) => 0.0;

  @override
  double computeMinIntrinsicHeight(double width) => 0.0;

  @override
  double computeMaxIntrinsicHeight(double width) => 0.0;

  @override
  Size computeDryLayout(BoxConstraints constraints) => constraints.biggest;

  @override
  double? computeDryBaseline(covariant BoxConstraints constraints, TextBaseline baseline) {
    final RenderBox? child = this.child;
    if (child == null) {
      return null;
    }
    final BoxConstraints childConstraints = _getConstraintsForChild(constraints);
    final double? result = child.getDryBaseline(childConstraints, baseline);
    if (result == null) {
      return null;
    }
    final Size childSize =
    childConstraints.isTight ? childConstraints.smallest : child.getDryLayout(childConstraints);
    return result + _getPositionForChild(constraints.biggest, childSize).dy;
  }

  BoxConstraints _getConstraintsForChild(BoxConstraints constraints) {
    return BoxConstraints(
      minWidth: constraints.maxWidth,
      maxWidth: constraints.maxWidth,
      maxHeight:
      isScrollControlled
          ? constraints.maxHeight
          : constraints.maxHeight * scrollControlDisabledMaxHeightRatio,
    );
  }

  Offset _getPositionForChild(Size size, Size childSize) {
    return Offset(0.0, size.height - childSize.height * animationValue);
  }

  @override
  void performLayout() {
    size = constraints.biggest;
    final RenderBox? child = this.child;
    if (child == null) {
      return;
    }

    final BoxConstraints childConstraints = _getConstraintsForChild(constraints);
    assert(childConstraints.debugAssertIsValid(isAppliedConstraint: true));
    child.layout(childConstraints, parentUsesSize: !childConstraints.isTight);
    final BoxParentData childParentData = child.parentData! as BoxParentData;
    final Size childSize = childConstraints.isTight ? childConstraints.smallest : child.size;
    childParentData.offset = _getPositionForChild(size, childSize);

    if (_lastSize != childSize) {
      _lastSize = childSize;
      _onChildSizeChanged.call(_lastSize);
    }
  }
}

class _ModalBottomSheet<T> extends StatefulWidget {
  const _ModalBottomSheet({
    super.key,
    required this.route,
    this.backgroundColor,
    this.elevation,
    this.shape,
    this.clipBehavior,
    this.constraints,
    this.isScrollControlled = false,
    this.scrollControlDisabledMaxHeightRatio = _defaultScrollControlDisabledMaxHeightRatio,
    this.enableDrag = true,
    this.showDragHandle = false,
  });

  final JBModalBottomSheetRoute<T> route;
  final bool isScrollControlled;
  final double scrollControlDisabledMaxHeightRatio;
  final Color? backgroundColor;
  final double? elevation;
  final ShapeBorder? shape;
  final Clip? clipBehavior;
  final BoxConstraints? constraints;
  final bool enableDrag;
  final bool showDragHandle;

  @override
  _ModalBottomSheetState<T> createState() => _ModalBottomSheetState<T>();
}

class _ModalBottomSheetState<T> extends State<_ModalBottomSheet<T>> {
  ParametricCurve<double> animationCurve = _modalBottomSheetCurve;

  String _getRouteLabel(MaterialLocalizations localizations) {
    switch (Theme.of(context).platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return '';
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return localizations.dialogLabel;
    }
  }

  EdgeInsets _getNewClipDetails(Size topLayerSize) {
    return EdgeInsets.fromLTRB(0, 0, 0, topLayerSize.height);
  }

  void handleDragStart(DragStartDetails details) {
    // Allow the bottom sheet to track the user's finger accurately.
    animationCurve = Curves.linear;
  }

  void handleDragEnd(DragEndDetails details, {bool? isClosing}) {
    // Allow the bottom sheet to animate smoothly from its current position.
    animationCurve = Split(widget.route.animation!.value, endCurve: _modalBottomSheetCurve);
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMediaQuery(context));
    assert(debugCheckHasMaterialLocalizations(context));
    final MaterialLocalizations localizations = MaterialLocalizations.of(context);
    final String routeLabel = _getRouteLabel(localizations);

    return AnimatedBuilder(
      animation: widget.route.animation!,
      child: BottomSheet(
        animationController: widget.route._animationController,
        onClosing: () {
          if (widget.route.isCurrent) {
            Navigator.pop(context);
          }
        },
        builder: widget.route.builder,
        backgroundColor: widget.backgroundColor,
        elevation: widget.elevation,
        shape: widget.shape,
        clipBehavior: widget.clipBehavior,
        constraints: widget.constraints,
        enableDrag: widget.enableDrag,
        showDragHandle: widget.showDragHandle,
        onDragStart: handleDragStart,
        onDragEnd: handleDragEnd,
      ),
      builder: (BuildContext context, Widget? child) {
        final double animationValue = animationCurve.transform(widget.route.animation!.value);
        return Semantics(
          scopesRoute: true,
          namesRoute: true,
          label: routeLabel,
          explicitChildNodes: true,
          child: ClipRect(
            child: _BottomSheetLayoutWithSizeListener(
              onChildSizeChanged: (Size size) {
                widget.route._didChangeBarrierSemanticsClip(_getNewClipDetails(size));
              },
              animationValue: animationValue,
              isScrollControlled: widget.isScrollControlled,
              scrollControlDisabledMaxHeightRatio: widget.scrollControlDisabledMaxHeightRatio,
              child: child,
            ),
          ),
        );
      },
    );
  }
}

/// A route that represents a Material Design modal bottom sheet.
///
/// {@template flutter.material.ModalBottomSheetRoute}
/// A modal bottom sheet is an alternative to a menu or a dialog and prevents
/// the user from interacting with the rest of the app.
///
/// A closely related widget is a persistent bottom sheet, which shows
/// information that supplements the primary content of the app without
/// preventing the user from interacting with the app. Persistent bottom sheets
/// can be created and displayed with the [showBottomSheet] function or the
/// [ScaffoldState.showBottomSheet] method.
///
/// The [isScrollControlled] parameter specifies whether this is a route for
/// a bottom sheet that will utilize [DraggableScrollableSheet]. Consider
/// setting this parameter to true if this bottom sheet has
/// a scrollable child, such as a [ListView] or a [GridView],
/// to have the bottom sheet be draggable.
///
/// The [isDismissible] parameter specifies whether the bottom sheet will be
/// dismissed when user taps on the scrim.
///
/// The [enableDrag] parameter specifies whether the bottom sheet can be
/// dragged up and down and dismissed by swiping downwards.
///
/// The [useSafeArea] parameter specifies whether the sheet will avoid system
/// intrusions on the top, left, and right. If false, no [SafeArea] is added;
/// and [MediaQuery.removePadding] is applied to the top,
/// so that system intrusions at the top will not be avoided by a [SafeArea]
/// inside the bottom sheet either.
/// Defaults to false.
///
/// The optional [backgroundColor], [elevation], [shape], [clipBehavior],
/// [constraints] and [transitionAnimationController]
/// parameters can be passed in to customize the appearance and behavior of
/// modal bottom sheets (see the documentation for these on [JBBottomSheet]
/// for more details).
///
/// The [transitionAnimationController] controls the bottom sheet's entrance and
/// exit animations. It's up to the owner of the controller to call
/// [AnimationController.dispose] when the controller is no longer needed.
///
/// The optional `settings` parameter sets the [RouteSettings] of the modal bottom sheet
/// sheet. This is particularly useful in the case that a user wants to observe
/// [PopupRoute]s within a [NavigatorObserver].
/// {@endtemplate}
///
/// {@macro flutter.widgets.RawDialogRoute}
///
/// See also:
///
///  * [showModalBottomSheet], which is a way to display a ModalBottomSheetRoute.
///  * [JBBottomSheet], which becomes the parent of the widget returned by the
///    function passed as the `builder` argument to [showModalBottomSheet].
///  * [showBottomSheet] and [ScaffoldState.showBottomSheet], for showing
///    non-modal bottom sheets.
///  * [DraggableScrollableSheet], creates a bottom sheet that grows
///    and then becomes scrollable once it reaches its maximum size.
///  * [DisplayFeatureSubScreen], which documents the specifics of how
///    [DisplayFeature]s can split the screen into sub-screens.
///  * The Material 2 spec at <https://m2.material.io/components/sheets-bottom>.
///  * The Material 3 spec at <https://m3.material.io/components/bottom-sheets/overview>.
class JBModalBottomSheetRoute<T> extends PopupRoute<T> {
  /// A modal bottom sheet route.
  JBModalBottomSheetRoute({
    required this.builder,
    this.capturedThemes,
    this.barrierLabel,
    this.barrierOnTapHint,
    this.backgroundColor,
    this.elevation,
    this.shape,
    this.clipBehavior,
    this.constraints,
    this.modalBarrierColor,
    this.barrierBlur,
    this.isDismissible = true,
    this.enableDrag = true,
    this.showDragHandle,
    required this.isScrollControlled,
    this.scrollControlDisabledMaxHeightRatio = _defaultScrollControlDisabledMaxHeightRatio,
    super.settings,
    super.requestFocus,
    this.transitionAnimationController,
    this.anchorPoint,
    this.useSafeArea = false,
    this.sheetAnimationStyle,
  });

  /// A builder for the contents of the sheet.
  ///
  /// The bottom sheet will wrap the widget produced by this builder in a
  /// [Material] widget.
  final WidgetBuilder builder;

  /// Stores a list of captured [InheritedTheme]s that are wrapped around the
  /// bottom sheet.
  ///
  /// Consider setting this attribute when the [JBModalBottomSheetRoute]
  /// is created through [Navigator.push] and its friends.
  final CapturedThemes? capturedThemes;

  /// Specifies whether this is a route for a bottom sheet that will utilize
  /// [DraggableScrollableSheet].
  ///
  /// Consider setting this parameter to true if this bottom sheet has
  /// a scrollable child, such as a [ListView] or a [GridView],
  /// to have the bottom sheet be draggable.
  final bool isScrollControlled;

  /// The max height constraint ratio for the bottom sheet
  /// when [isScrollControlled] is set to false,
  /// no ratio will be applied when [isScrollControlled] is set to true.
  ///
  /// Defaults to 9 / 16.
  final double scrollControlDisabledMaxHeightRatio;

  /// The bottom sheet's background color.
  ///
  /// Defines the bottom sheet's [Material.color].
  ///
  /// If this property is not provided, it falls back to [Material]'s default.
  final Color? backgroundColor;

  /// The z-coordinate at which to place this material relative to its parent.
  ///
  /// This controls the size of the shadow below the material.
  ///
  /// Defaults to 0, must not be negative.
  final double? elevation;

  /// The shape of the bottom sheet.
  ///
  /// Defines the bottom sheet's [Material.shape].
  ///
  /// If this property is not provided, it falls back to [Material]'s default.
  final ShapeBorder? shape;

  /// {@macro flutter.material.Material.clipBehavior}
  ///
  /// Defines the bottom sheet's [Material.clipBehavior].
  ///
  /// Use this property to enable clipping of content when the bottom sheet has
  /// a custom [shape] and the content can extend past this shape. For example,
  /// a bottom sheet with rounded corners and an edge-to-edge [Image] at the
  /// top.
  ///
  /// If this property is null, the [BottomSheetThemeData.clipBehavior] of
  /// [ThemeData.bottomSheetTheme] is used. If that's null, the behavior defaults to [Clip.none]
  /// will be [Clip.none].
  final Clip? clipBehavior;

  /// Defines minimum and maximum sizes for a [JBBottomSheet].
  ///
  /// If null, the ambient [ThemeData.bottomSheetTheme]'s
  /// [BottomSheetThemeData.constraints] will be used. If that
  /// is null and [ThemeData.useMaterial3] is true, then the bottom sheet
  /// will have a max width of 640dp. If [ThemeData.useMaterial3] is false, then
  /// the bottom sheet's size will be constrained by its parent
  /// (usually a [Scaffold]). In this case, consider limiting the width by
  /// setting smaller constraints for large screens.
  ///
  /// If constraints are specified (either in this property or in the
  /// theme), the bottom sheet will be aligned to the bottom-center of
  /// the available space. Otherwise, no alignment is applied.
  final BoxConstraints? constraints;

  /// Specifies the color of the modal barrier that darkens everything below the
  /// bottom sheet.
  ///
  /// Defaults to `Colors.black54` if not provided.
  final Color? modalBarrierColor;

  final double? barrierBlur;

  /// Specifies whether the bottom sheet will be dismissed
  /// when user taps on the scrim.
  ///
  /// If true, the bottom sheet will be dismissed when user taps on the scrim.
  ///
  /// Defaults to true.
  final bool isDismissible;

  /// Specifies whether the bottom sheet can be dragged up and down
  /// and dismissed by swiping downwards.
  ///
  /// If true, the bottom sheet can be dragged up and down and dismissed by
  /// swiping downwards.
  ///
  /// This applies to the content below the drag handle, if showDragHandle is true.
  ///
  /// Defaults is true.
  final bool enableDrag;

  /// Specifies whether a drag handle is shown.
  ///
  /// The drag handle appears at the top of the bottom sheet. The default color is
  /// [ColorScheme.onSurfaceVariant] with an opacity of 0.4 and can be customized
  /// using dragHandleColor. The default size is `Size(32,4)` and can be customized
  /// with dragHandleSize.
  ///
  /// If null, then the value of [BottomSheetThemeData.showDragHandle] is used. If
  /// that is also null, defaults to false.
  final bool? showDragHandle;

  /// The animation controller that controls the bottom sheet's entrance and
  /// exit animations.
  ///
  /// The BottomSheet widget will manipulate the position of this animation, it
  /// is not just a passive observer.
  final AnimationController? transitionAnimationController;

  /// {@macro flutter.widgets.DisplayFeatureSubScreen.anchorPoint}
  final Offset? anchorPoint;

  /// Whether to avoid system intrusions on the top, left, and right.
  ///
  /// If true, a [SafeArea] is inserted to keep the bottom sheet away from
  /// system intrusions at the top, left, and right sides of the screen.
  ///
  /// If false, the bottom sheet will extend through any system intrusions
  /// at the top, left, and right.
  ///
  /// If false, then moreover [MediaQuery.removePadding] will be used
  /// to remove top padding, so that a [SafeArea] widget inside the bottom
  /// sheet will have no effect at the top edge. If this is undesired, consider
  /// setting [useSafeArea] to true. Alternatively, wrap the [SafeArea] in a
  /// [MediaQuery] that restates an ambient [MediaQueryData] from outside [builder].
  ///
  /// In either case, the bottom sheet extends all the way to the bottom of
  /// the screen, including any system intrusions.
  ///
  /// The default is false.
  final bool useSafeArea;

  /// Used to override the modal bottom sheet animation duration and reverse
  /// animation duration.
  ///
  /// If [AnimationStyle.duration] is provided, it will be used to override
  /// the modal bottom sheet animation duration in the underlying
  /// [JBBottomSheet.createAnimationController].
  ///
  /// If [AnimationStyle.reverseDuration] is provided, it will be used to
  /// override the modal bottom sheet reverse animation duration in the
  /// underlying [JBBottomSheet.createAnimationController].
  ///
  /// To disable the modal bottom sheet animation, use [AnimationStyle.noAnimation].
  final AnimationStyle? sheetAnimationStyle;

  /// {@template flutter.material.ModalBottomSheetRoute.barrierOnTapHint}
  /// The semantic hint text that informs users what will happen if they
  /// tap on the widget. Announced in the format of 'Double tap to ...'.
  ///
  /// If the field is null, the default hint will be used, which results in
  /// announcement of 'Double tap to activate'.
  /// {@endtemplate}
  ///
  /// See also:
  ///
  ///  * [barrierDismissible], which controls the behavior of the barrier when
  ///    tapped.
  ///  * [ModalBarrier], which uses this field as onTapHint when it has an onTap action.
  final String? barrierOnTapHint;

  final ValueNotifier<EdgeInsets> _clipDetailsNotifier = ValueNotifier<EdgeInsets>(EdgeInsets.zero);

  @override
  void dispose() {
    _clipDetailsNotifier.dispose();
    super.dispose();
  }

  /// Updates the details regarding how the [SemanticsNode.rect] (focus) of
  /// the barrier for this [JBModalBottomSheetRoute] should be clipped.
  ///
  /// Returns true if the clipDetails did change and false otherwise.
  bool _didChangeBarrierSemanticsClip(EdgeInsets newClipDetails) {
    if (_clipDetailsNotifier.value == newClipDetails) {
      return false;
    }
    _clipDetailsNotifier.value = newClipDetails;
    return true;
  }

  @override
  Duration get transitionDuration =>
      transitionAnimationController?.duration ??
          sheetAnimationStyle?.duration ??
          _bottomSheetEnterDuration;

  @override
  Duration get reverseTransitionDuration =>
      transitionAnimationController?.reverseDuration ??
          transitionAnimationController?.duration ??
          sheetAnimationStyle?.reverseDuration ??
          _bottomSheetExitDuration;

  @override
  bool get barrierDismissible => isDismissible;

  @override
  final String? barrierLabel;

  @override
  Color get barrierColor => modalBarrierColor ?? Colors.black54;

  AnimationController? _animationController;

  @override
  AnimationController createAnimationController() {
    assert(_animationController == null);
    if (transitionAnimationController != null) {
      _animationController = transitionAnimationController;
      willDisposeAnimationController = false;
    } else {
      _animationController = BottomSheet.createAnimationController(
        navigator!,
        sheetAnimationStyle: sheetAnimationStyle,
      );
    }
    return _animationController!;
  }

  @override
  Widget buildPage(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      ) {
    final Widget content = DisplayFeatureSubScreen(
      anchorPoint: anchorPoint,
      child: Builder(
        builder: (BuildContext context) {
          final BottomSheetThemeData sheetTheme = Theme.of(context).bottomSheetTheme;
          final BottomSheetThemeData defaults =
          Theme.of(context).useMaterial3
              ? _BottomSheetDefaultsM3(context)
              : const BottomSheetThemeData();
          return _ModalBottomSheet<T>(
            route: this,
            backgroundColor:
            backgroundColor ??
                sheetTheme.modalBackgroundColor ??
                sheetTheme.backgroundColor ??
                defaults.backgroundColor,
            elevation:
            elevation ??
                sheetTheme.modalElevation ??
                sheetTheme.elevation ??
                defaults.modalElevation,
            shape: shape,
            clipBehavior: clipBehavior,
            constraints: constraints,
            isScrollControlled: isScrollControlled,
            scrollControlDisabledMaxHeightRatio: scrollControlDisabledMaxHeightRatio,
            enableDrag: enableDrag,
            showDragHandle: showDragHandle ?? (enableDrag && (sheetTheme.showDragHandle ?? false)),
          );
        },
      ),
    );

    final Widget bottomSheet =
    useSafeArea
        ? SafeArea(bottom: false, child: content)
        : MediaQuery.removePadding(context: context, removeTop: true, child: content);

    return capturedThemes?.wrap(bottomSheet) ?? bottomSheet;
  }

  @override
  Widget buildModalBarrier() {
    if (barrierColor.a != 0 && !offstage) {
      // changedInternalState is called if barrierColor or offstage updates
      assert(barrierColor != barrierColor.withValues(alpha: 0.0));
      final Animation<Color?> color = animation!.drive(
        ColorTween(
          begin: barrierColor.withValues(alpha: 0.0),
          end: barrierColor, // changedInternalState is called if barrierColor updates
        ).chain(
          CurveTween(curve: barrierCurve),
        ), // changedInternalState is called if barrierCurve updates
      );

      final Animation<double?>? blur = (barrierBlur != null && barrierBlur! > 0) ? animation!.drive(
        Tween<double>(begin: 0.0, end: barrierBlur).chain(
          CurveTween(curve: barrierCurve),
        ),
      ) : null;

      return JBAnimatedModalBarrier(
        color: color,
        blur: blur,
        dismissible: barrierDismissible, // changedInternalState is called if barrierDismissible updates
        semanticsLabel: barrierLabel, // changedInternalState is called if barrierLabel updates
        barrierSemanticsDismissible: semanticsDismissible,
        clipDetailsNotifier: _clipDetailsNotifier,
        semanticsOnTapHint: barrierOnTapHint,
      );
    } else {
      return JBModalBarrier(
        dismissible: barrierDismissible, // changedInternalState is called if barrierDismissible updates
        semanticsLabel: barrierLabel, // changedInternalState is called if barrierLabel updates
        barrierSemanticsDismissible: semanticsDismissible,
        clipDetailsNotifier: _clipDetailsNotifier,
        semanticsOnTapHint: barrierOnTapHint,
      );
    }
  }
}


class _BottomSheetDefaultsM3 extends BottomSheetThemeData {
  _BottomSheetDefaultsM3(this.context)
      : super(
    elevation: 1.0,
    modalElevation: 1.0,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(28.0))),
    constraints: const BoxConstraints(maxWidth: 640),
  );

  final BuildContext context;
  late final ColorScheme _colors = Theme.of(context).colorScheme;

  @override
  Color? get backgroundColor => _colors.surfaceContainerLow;

  @override
  Color? get surfaceTintColor => Colors.transparent;

  @override
  Color? get shadowColor => Colors.transparent;

  @override
  Color? get dragHandleColor => _colors.onSurfaceVariant;

  @override
  Size? get dragHandleSize => const Size(32, 4);

  @override
  BoxConstraints? get constraints => const BoxConstraints(maxWidth: 640.0);
}

