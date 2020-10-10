// // Copyright 2014 The Flutter Authors. All rights reserved.
// // Use of this source code is governed by a BSD-style license that can be
// // found in the LICENSE file.

// // @dart = 2.8

// import 'package:flutter/foundation.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter/gestures.dart' show DragStartBehavior;

// /// The possible alignments of a [Drawer].
// enum DrawerAlignment {
//   start,
//   end,
// }

// const double _kWidth = 304.0;
// const double _kEdgeDragWidth = 20.0;
// const double _kMinFlingVelocity = 365.0;
// const Duration _kBaseSettleDuration = Duration(milliseconds: 246);

//   ///
//   /// Typically used in the [Scaffold.drawer] property.
//   ///
//   /// The [elevation] must be non-negative.
//   const Drawer({
//     Key key,
//     this.elevation = 16.0,
//     this.child,
//     this.semanticLabel,
//   }) : assert(elevation != null && elevation >= 0.0),
//        super(key: key);

//   /// The z-coordinate at which to place this drawer relative to its parent.
//   ///
//   /// This controls the size of the shadow below the drawer.
//   ///
//   /// Defaults to 16, the appropriate elevation for drawers. The value is
//   /// always non-negative.
//   final double elevation;

//   /// The widget below this widget in the tree.
//   ///
//   /// Typically a [SliverList].
//   ///
//   /// {@macro flutter.widgets.child}
//   final Widget child;

//   /// The semantic label of the dialog used by accessibility frameworks to
//   /// announce screen transitions when the drawer is opened and closed.
//   ///
//   /// If this label is not provided, it will default to
//   /// [MaterialLocalizations.drawerLabel].
//   ///
//   /// See also:
//   ///
//   ///  * [SemanticsConfiguration.namesRoute], for a description of how this
//   ///    value is used.
//   final String semanticLabel;

//   @override
//   Widget build(BuildContext context) {
//     assert(debugCheckHasMaterialLocalizations(context));
//     String label = semanticLabel;
//     switch (Theme.of(context).platform) {
//       case TargetPlatform.iOS:
//       case TargetPlatform.macOS:
//         label = semanticLabel;
//         break;
//       case TargetPlatform.android:
//       case TargetPlatform.fuchsia:
//       case TargetPlatform.linux:
//       case TargetPlatform.windows:
//         label = semanticLabel ?? MaterialLocalizations.of(context)?.drawerLabel;
//     }
//     return Semantics(
//       scopesRoute: true,
//       namesRoute: true,
//       explicitChildNodes: true,
//       label: label,
//       child: ConstrainedBox(
//         constraints: const BoxConstraints.expand(width: _kWidth),
//         child: Material(
//           elevation: elevation,
//           child: child,
//         ),
//       ),
//     );
//   }
// }

// /// Signature for the callback that's called when a [DrawerController] is
// /// opened or closed.
// typedef DrawerCallback = void Function(bool isOpened);

// /// Provides interactive behavior for [Drawer] widgets.
// ///
// /// Rarely used directly. Drawer controllers are typically created automatically
// /// by [Scaffold] widgets.
// ///
// /// The draw controller provides the ability to open and close a drawer, either
// /// via an animation or via user interaction. When closed, the drawer collapses
// /// to a translucent gesture detector that can be used to listen for edge
// /// swipes.
// ///
// /// See also:
// ///
// ///  * [Drawer], a container with the default width of a drawer.
// ///  * [Scaffold.drawer], the [Scaffold] slot for showing a drawer.
// class DrawerController extends StatefulWidget {
//   /// Creates a controller for a [Drawer].
//   ///
//   /// Rarely used directly.
//   ///
//   /// The [child] argument must not be null and is typically a [Drawer].
//   const DrawerController({
//     GlobalKey key,
//     @required this.child,
//     @required this.alignment,
//     this.drawerCallback,
//     this.dragStartBehavior = DragStartBehavior.start,
//     this.scrimColor,
//     this.edgeDragWidth,
//     this.enableOpenDragGesture = true,
//   }) : assert(child != null),
//        assert(dragStartBehavior != null),
//        assert(alignment != null),
//        super(key: key);

//   /// The widget below this widget in the tree.
//   ///
//   /// Typically a [Drawer].
//   final Widget child;

//   /// The alignment of the [Drawer].
//   ///
//   /// This controls the direction in which the user should swipe to open and
//   /// close the drawer.
//   final DrawerAlignment alignment;

//   /// Optional callback that is called when a [Drawer] is opened or closed.
//   final DrawerCallback drawerCallback;

//   /// {@template flutter.material.drawer.dragStartBehavior}
//   /// Determines the way that drag start behavior is handled.
//   ///
//   /// If set to [DragStartBehavior.start], the drag behavior used for opening
//   /// and closing a drawer will begin upon the detection of a drag gesture. If
//   /// set to [DragStartBehavior.down] it will begin when a down event is first
//   /// detected.
//   ///
//   /// In general, setting this to [DragStartBehavior.start] will make drag
//   /// animation smoother and setting it to [DragStartBehavior.down] will make
//   /// drag behavior feel slightly more reactive.
//   ///
//   /// By default, the drag start behavior is [DragStartBehavior.start].
//   ///
//   /// See also:
//   ///
//   ///  * [DragGestureRecognizer.dragStartBehavior], which gives an example for
//   ///    the different behaviors.
//   ///
//   /// {@endtemplate}
//   final DragStartBehavior dragStartBehavior;

//   /// The color to use for the scrim that obscures primary content while a drawer is open.
//   ///
//   /// By default, the color used is [Colors.black54]
//   final Color scrimColor;

//   /// Determines if the [Drawer] can be opened with a drag gesture.
//   ///
//   /// By default, the drag gesture is enabled.
//   final bool enableOpenDragGesture;

//   /// The width of the area within which a horizontal swipe will open the
//   /// drawer.
//   ///
//   /// By default, the value used is 20.0 added to the padding edge of
//   /// `MediaQuery.of(context).padding` that corresponds to [alignment].
//   /// This ensures that the drag area for notched devices is not obscured. For
//   /// example, if [alignment] is set to [DrawerAlignment.start] and
//   /// `TextDirection.of(context)` is set to [TextDirection.ltr],
//   /// 20.0 will be added to `MediaQuery.of(context).padding.left`.
//   final double edgeDragWidth;

//   @override
//   DrawerControllerState createState() => DrawerControllerState();
// }

// /// State for a [DrawerController].
// ///
// /// Typically used by a [Scaffold] to [open] and [close] the drawer.
// class DrawerControllerState extends State<DrawerController> with SingleTickerProviderStateMixin {
//   @override
//   void initState() {
//     super.initState();
//     _scrimColorTween = _buildScrimColorTween();
//     _controller = AnimationController(duration: _kBaseSettleDuration, vsync: this)
//       ..addListener(_animationChanged)
//       ..addStatusListener(_animationStatusChanged);
//   }

//   @override
//   void dispose() {
//     _historyEntry?.remove();
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   void didUpdateWidget(DrawerController oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (widget.scrimColor != oldWidget.scrimColor)
//       _scrimColorTween = _buildScrimColorTween();
//   }

//   void _animationChanged() {
//     setState(() {
//       // The animation controller's state is our build state, and it changed already.
//     });
//   }

//   LocalHistoryEntry _historyEntry;
//   final FocusScopeNode _focusScopeNode = FocusScopeNode();

//   void _ensureHistoryEntry() {
//     if (_historyEntry == null) {
//       final ModalRoute<dynamic> route = ModalRoute.of(context);
//       if (route != null) {
//         _historyEntry = LocalHistoryEntry(onRemove: _handleHistoryEntryRemoved);
//         route.addLocalHistoryEntry(_historyEntry);
//         FocusScope.of(context).setFirstFocus(_focusScopeNode);
//       }
//     }
//   }

//   void _animationStatusChanged(AnimationStatus status) {
//     switch (status) {
//       case AnimationStatus.forward:
//         _ensureHistoryEntry();
//         break;
//       case AnimationStatus.reverse:
//         _historyEntry?.remove();
//         _historyEntry = null;
//         break;
//       case AnimationStatus.dismissed:
//         break;
//       case AnimationStatus.completed:
//         break;
//     }
//   }

//   void _handleHistoryEntryRemoved() {
//     _historyEntry = null;
//     close();
//   }

//   AnimationController _controller;

//   void _handleDragDown(DragDownDetails details) {
//     _controller.stop();
//     _ensureHistoryEntry();
//   }

//   void _handleDragCancel() {
//     if (_controller.isDismissed || _controller.isAnimating)
//       return;
//     if (_controller.value < 0.5) {
//       close();
//     } else {
//       open();
//     }
//   }

//   final GlobalKey _drawerKey = GlobalKey();

//   double get _width {
//     final RenderBox box = _drawerKey.currentContext?.findRenderObject() as RenderBox;
//     if (box != null)
//       return box.size.width;
//     return _kWidth; // drawer not being shown currently
//   }

//   bool _previouslyOpened = false;

//   void _move(DragUpdateDetails details) {
//     double delta = details.primaryDelta / _width;
//     switch (widget.alignment) {
//       case DrawerAlignment.start:
//         break;
//       case DrawerAlignment.end:
//         delta = -delta;
//         break;
//     }
//     switch (Directionality.of(context)) {
//       case TextDirection.rtl:
//         _controller.value -= delta;
//         break;
//       case TextDirection.ltr:
//         _controller.value += delta;
//         break;
//     }

//     final bool opened = _controller.value > 0.5;
//     if (opened != _previouslyOpened && widget.drawerCallback != null)
//       widget.drawerCallback(opened);
//     _previouslyOpened = opened;
//   }

//   void _settle(DragEndDetails details) {
//     if (_controller.isDismissed)
//       return;
//     if (details.velocity.pixelsPerSecond.dx.abs() >= _kMinFlingVelocity) {
//       double visualVelocity = details.velocity.pixelsPerSecond.dx / _width;
//       switch (widget.alignment) {
//         case DrawerAlignment.start:
//           break;
//         case DrawerAlignment.end:
//           visualVelocity = -visualVelocity;
//           break;
//       }
//       switch (Directionality.of(context)) {
//         case TextDirection.rtl:
//           _controller.fling(velocity: -visualVelocity);
//           if (widget.drawerCallback != null)
//             widget.drawerCallback(visualVelocity < 0.0);
//           break;
//         case TextDirection.ltr:
//           _controller.fling(velocity: visualVelocity);
//           if (widget.drawerCallback != null)
//             widget.drawerCallback(visualVelocity > 0.0);
//           break;
//       }
//     } else if (_controller.value < 0.5) {
//       close();
//     } else {
//       open();
//     }
//   }

//   /// Starts an animation to open the drawer.
//   ///
//   /// Typically called by [ScaffoldState.openDrawer].
//   void open() {
//     _controller.fling(velocity: 1.0);
//     if (widget.drawerCallback != null)
//       widget.drawerCallback(true);
//   }

//   /// Starts an animation to close the drawer.
//   void close() {
//     _controller.fling(velocity: -1.0);
//     if (widget.drawerCallback != null)
//       widget.drawerCallback(false);
//   }

//   ColorTween _scrimColorTween;
//   final GlobalKey _gestureDetectorKey = GlobalKey();

//   ColorTween _buildScrimColorTween() {
//     return ColorTween(begin: Colors.transparent, end: widget.scrimColor ?? Colors.black54);
//   }

//   AlignmentDirectional get _drawerOuterAlignment {
//     assert(widget.alignment != null);
//     switch (widget.alignment) {
//       case DrawerAlignment.start:
//         return AlignmentDirectional.centerStart;
//       case DrawerAlignment.end:
//         return AlignmentDirectional.centerEnd;
//     }
//     return null;
//   }

//   AlignmentDirectional get _drawerInnerAlignment {
//     assert(widget.alignment != null);
//     switch (widget.alignment) {
//       case DrawerAlignment.start:
//         return AlignmentDirectional.centerEnd;
//       case DrawerAlignment.end:
//         return AlignmentDirectional.centerStart;
//     }
//     return null;
//   }

//   Widget _buildDrawer(BuildContext context) {
//     final bool drawerIsStart = widget.alignment == DrawerAlignment.start;
//     final EdgeInsets padding = MediaQuery.of(context).padding;
//     final TextDirection textDirection = Directionality.of(context);

//     double dragAreaWidth = widget.edgeDragWidth;
//     if (widget.edgeDragWidth == null) {
//       switch (textDirection) {
//         case TextDirection.ltr:
//           dragAreaWidth = _kEdgeDragWidth +
//             (drawerIsStart ? padding.left : padding.right);
//           break;
//         case TextDirection.rtl:
//           dragAreaWidth = _kEdgeDragWidth +
//             (drawerIsStart ? padding.right : padding.left);
//           break;
//       }
//     }

//     if (_controller.status == AnimationStatus.dismissed) {
//       if (widget.enableOpenDragGesture) {
//         return Align(
//           alignment: _drawerOuterAlignment,
//           child: GestureDetector(
//             key: _gestureDetectorKey,
//             onHorizontalDragUpdate: _move,
//             onHorizontalDragEnd: _settle,
//             behavior: HitTestBehavior.translucent,
//             excludeFromSemantics: true,
//             dragStartBehavior: widget.dragStartBehavior,
//             child: Container(width: dragAreaWidth),
//           ),
//         );
//       } else {
//         return const SizedBox.shrink();
//       }
//     } else {
//       bool platformHasBackButton;
//       switch (Theme.of(context).platform) {
//         case TargetPlatform.android:
//           platformHasBackButton = true;
//           break;
//         case TargetPlatform.iOS:
//         case TargetPlatform.macOS:
//         case TargetPlatform.fuchsia:
//         case TargetPlatform.linux:
//         case TargetPlatform.windows:
//           platformHasBackButton = false;
//           break;
//       }
//       assert(platformHasBackButton != null);
//       return GestureDetector(
//         key: _gestureDetectorKey,
//         onHorizontalDragDown: _handleDragDown,
//         onHorizontalDragUpdate: _move,
//         onHorizontalDragEnd: _settle,
//         onHorizontalDragCancel: _handleDragCancel,
//         excludeFromSemantics: true,
//         dragStartBehavior: widget.dragStartBehavior,
//         child: RepaintBoundary(
//           child: Stack(
//             children: <Widget>[
//               BlockSemantics(
//                 child: ExcludeSemantics(
//                   // On Android, the back button is used to dismiss a modal.
//                   excluding: platformHasBackButton,
//                   child: GestureDetector(
//                     onTap: close,
//                     child: Semantics(
//                       label: MaterialLocalizations.of(context)?.modalBarrierDismissLabel,
//                       child: MouseRegion(
//                         opaque: true,
//                         child: Container( // The drawer's "scrim"
//                           color: _scrimColorTween.evaluate(_controller),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Align(
//                 alignment: _drawerOuterAlignment,
//                 child: Align(
//                   alignment: _drawerInnerAlignment,
//                   widthFactor: _controller.value,
//                   child: RepaintBoundary(
//                     child: FocusScope(
//                       key: _drawerKey,
//                       node: _focusScopeNode,
//                       child: widget.child,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     assert(debugCheckHasMaterialLocalizations(context));
//     return ListTileTheme(
//       style: ListTileStyle.drawer,
//       child: _buildDrawer(context),
//     );
//   }
// }
