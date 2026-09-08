import 'package:flutter/material.dart';

class AppOverlay {
  static void show(
    BuildContext context, {
    required String message,
    bool isError = true,
    Duration duration = const Duration(seconds: 2),
    VoidCallback? onFinished,
  }) {
    final overlay = Overlay.of(context);
    late OverlayEntry entry;

    entry = OverlayEntry(
      builder: (context) => Positioned.fill(
        child: Center(
          child: Material(
            color: Colors.transparent,
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: 1),
              duration: const Duration(milliseconds: 250),
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: Transform.scale(
                    scale: 0.85 + (value * 0.15),
                    child: child,
                  ),
                );
              },
              child: Container(
                width: 160,
                height: 160,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isError ? Colors.red : Colors.green,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.25),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      isError
                          ? Icons.error_outline
                          : Icons.check_circle_outline,
                      color: Colors.white,
                      size: 36,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(entry);

    Future.delayed(duration, () {
      entry.remove();
      onFinished?.call();
    });
  }

  static void showError(
    BuildContext context,
    String message, {
    VoidCallback? onFinished,
  }) {
    show(context, message: message, isError: true, onFinished: onFinished);
  }

  static void showSuccess(
    BuildContext context,
    String message, {
    VoidCallback? onFinished,
  }) {
    show(context, message: message, isError: false, onFinished: onFinished);
  }
}
