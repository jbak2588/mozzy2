import 'dart:async';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// A widget that tracks how long its child has been visible in the viewport.
/// If the child is visible for at least [visibilityThreshold] and [dwellMsThreshold],
/// it triggers [onImpression].
class ViewportImpressionTracker extends StatefulWidget {
  final String feedItemId;
  final String sourceId;
  final String sourceType;
  final Widget child;
  final void Function(double visibleRatio, int dwellMs) onImpression;

  /// The minimum fraction of the widget that must be visible (0.0 to 1.0).
  final double visibilityThreshold;

  /// The minimum duration the widget must remain visible above the threshold.
  final int dwellMsThreshold;

  const ViewportImpressionTracker({
    super.key,
    required this.feedItemId,
    required this.sourceId,
    required this.sourceType,
    required this.child,
    required this.onImpression,
    this.visibilityThreshold = 0.5,
    this.dwellMsThreshold = 800,
  });

  @override
  State<ViewportImpressionTracker> createState() => _ViewportImpressionTrackerState();
}

class _ViewportImpressionTrackerState extends State<ViewportImpressionTracker> {
  Timer? _dwellTimer;
  bool _hasLoggedImpression = false;

  @override
  void dispose() {
    _dwellTimer?.cancel();
    super.dispose();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (_hasLoggedImpression) return;

    if (widget.feedItemId.isEmpty || widget.sourceId.isEmpty || widget.sourceType.isEmpty) {
      return;
    }

    if (info.visibleFraction >= widget.visibilityThreshold) {
      if (_dwellTimer == null) {
        final currentRatio = info.visibleFraction;
        _dwellTimer = Timer(Duration(milliseconds: widget.dwellMsThreshold), () {
          if (!_hasLoggedImpression && mounted) {
            _hasLoggedImpression = true;
            widget.onImpression(currentRatio, widget.dwellMsThreshold);
          }
          _dwellTimer = null;
        });
      }
    } else {
      _dwellTimer?.cancel();
      _dwellTimer = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('visibility_${widget.feedItemId}'),
      onVisibilityChanged: _onVisibilityChanged,
      child: widget.child,
    );
  }
}
