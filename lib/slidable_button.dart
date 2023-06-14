import 'package:flutter/material.dart';
import 'package:khamidjon_kyla/slidable_simulation.dart';

enum SlidableButtonPosition {
  start,
  end,
}

class VerticalSlidableButton extends StatefulWidget {
  final Widget icon;
  final Color? buttonColor;
  final BorderRadius borderRadius;
  final double slideHeight;
  final double width;
  final double? buttonHeight;
  final ValueChanged<SlidableButtonPosition>? onChanged;

  const VerticalSlidableButton({
    super.key,
    required this.onChanged,
    required this.icon,
    this.buttonColor,
    this.borderRadius = const BorderRadius.all(Radius.circular(60.0)),
    this.slideHeight = 300.0,
    this.width = 48.0,
    this.buttonHeight = 48.0,
  });

  @override
  State<VerticalSlidableButton> createState() => _VerticalSlidableButtonState();
}

class _VerticalSlidableButtonState extends State<VerticalSlidableButton>
    with SingleTickerProviderStateMixin {
  final GlobalKey _containerKey = GlobalKey();
  final GlobalKey _positionedKey = GlobalKey();

  late final AnimationController _controller;
  Offset _start = Offset.zero;

  RenderBox? get _positioned =>
      _positionedKey.currentContext!.findRenderObject() as RenderBox?;

  RenderBox? get _container =>
      _containerKey.currentContext!.findRenderObject() as RenderBox?;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController.unbounded(
      vsync: this,
    );
    _controller.value = 0.0;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.slideHeight,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(32.0)),
      ),
      child: AnimatedBuilder(
        key: _containerKey,
        animation: _controller,
        builder: (context, child) => Align(
          alignment: Alignment(0.0, (_controller.value * 2.0) - 1.0),
          child: child,
        ),
        child: Container(
          key: _positionedKey,
          height: widget.buttonHeight,
          width: widget.width,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(32.0)),
            color: widget.onChanged == null ? Colors.grey : widget.buttonColor,
          ),
          child: widget.onChanged == null
              ? Center(child: widget.icon)
              : GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onHorizontalDragStart: _onDragStart,
                  onHorizontalDragUpdate: _onDragUpdate,
                  onHorizontalDragEnd: _onDragEnd,
                  child: Center(child: widget.icon),
                ),
        ),
      ),
    );
  }

  void _onDragStart(DragStartDetails details) {
    final pos = _positioned!.globalToLocal(details.globalPosition);
    _start = Offset(0.0, pos.dy);
    _controller.stop(canceled: true);
  }

  void _onDragUpdate(DragUpdateDetails details) {
    final pos = _container!.globalToLocal(details.globalPosition) - _start;
    final extent = _container!.size.height - _positioned!.size.height;
    _controller.value = (pos.dy.clamp(0.0, extent) / extent);
  }

  void _onDragEnd(DragEndDetails details) {
    final extent = _container!.size.height - _positioned!.size.height;
    double fractionalVelocity = (details.primaryVelocity! / extent).abs();
    if (fractionalVelocity < 0.5) {
      fractionalVelocity = 2;
    }

    double acceleration, velocity;
    if (_controller.value >= 0.5) {
      acceleration = 0.5;
      velocity = fractionalVelocity;
    } else {
      acceleration = -0.5;
      velocity = -fractionalVelocity;
    }

    final simulation = SlidableSimulation(
      acceleration,
      _controller.value,
      1.0,
      velocity,
    );

    _controller.animateWith(simulation).whenComplete(_afterDragEnd);
  }

  void _afterDragEnd() {
    final SlidableButtonPosition position;

    if (_controller.value > 0.5) {
      position = SlidableButtonPosition.end;
    } else {
      position = SlidableButtonPosition.start;
    }

    _onChanged(position);
  }

  void _onChanged(SlidableButtonPosition position) {
    if (widget.onChanged != null) {
      widget.onChanged!(position);
    }
  }
}
