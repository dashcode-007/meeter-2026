import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(0.2),
    builder: (_) {
      return Center(
        child: Container(
          width: 80,
          height: 70,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Center(
            child: SpinKitFadingCircle(
              color: Color(0xFFF7931E),
              size: 28,
            ),
          ),
        ),
      );
    },
  );
}
