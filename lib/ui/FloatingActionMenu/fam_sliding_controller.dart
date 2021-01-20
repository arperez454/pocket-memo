import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';

class SlidingOptionListController extends ChangeNotifier {
  final double firstItemAngle;
  final double lastItemAngle;
  final double startSlidingAngle;
  final AnimateDirection animateDirection;

  final int itemCount;
  final AnimationController _slideController;
  final List<Animation<double>> _slidePositions;

  SlidingState _state = SlidingState.closed;
  Completer onOpenedCompleter;
  Completer onClosedCompleter;

  SlidingOptionListController(
      {@required TickerProvider vsync,
      @required this.itemCount,
      this.animateDirection = AnimateDirection.DOWN})
      : _slideController = new AnimationController(
          vsync: vsync,
          duration: Duration(milliseconds: 1200),
        ),
        _slidePositions = [],
        firstItemAngle =
            (animateDirection == AnimateDirection.DOWN ? -1 : 1) * 4 * pi / 3,
        lastItemAngle =
            (animateDirection == AnimateDirection.DOWN ? -1 : 1) * 2 * pi / 3,
        startSlidingAngle =
            (animateDirection == AnimateDirection.DOWN ? -1 : 1) * pi / 3 {
    _slideController
      ..addListener(() => notifyListeners())
      ..addStatusListener((status) {
        switch (status) {
          case AnimationStatus.forward:
            _state = SlidingState.opening;
            notifyListeners();
            break;
          case AnimationStatus.completed:
            _state = SlidingState.open;
            notifyListeners();
            onOpenedCompleter.complete();
            break;
          case AnimationStatus.reverse:
            _state = SlidingState.closing;
            notifyListeners();
            break;
          case AnimationStatus.dismissed:
            _state = SlidingState.closed;
            notifyListeners();
            onClosedCompleter.complete();
            break;
        }
      });

    final delayInterval = 0.1;
    final slideInterval = delayInterval * itemCount;
    final angleDeltaPerItem =
        (lastItemAngle - firstItemAngle) / (itemCount - 1);

    for (var i = 0; i < itemCount; ++i) {
      final start = delayInterval * i;
      final end = start + slideInterval;

      final endSlideAngle = firstItemAngle + (angleDeltaPerItem * i);

      _slidePositions.add(new Tween(
        begin: startSlidingAngle,
        end: endSlideAngle,
      ).animate(new CurvedAnimation(
          parent: _slideController,
          curve: new Interval(start, end, curve: Curves.easeInOut))));
    }
  }

  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }

  double getItemAngle(int index) {
    return _slidePositions[index].value;
  }

  bool isOpened() {
    return _state == SlidingState.open;
  }

  get percentOpen => _slideController.value;

  Future open() {
    if (_state == SlidingState.closed) {
      print('openning...');
      _slideController.forward();
      onOpenedCompleter = new Completer();
      return onOpenedCompleter.future;
    }
    return null;
  }

  Future close() {
    if (_state == SlidingState.open) {
      print('closing...');
      _slideController.reverse();
      onClosedCompleter = new Completer();
      return onClosedCompleter.future;
    }
    return null;
  }
}

enum SlidingState {
  closed,
  opening,
  open,
  closing,
}

enum AnimateDirection { UP, DOWN }
