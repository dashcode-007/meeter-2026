import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter_app/view/auth/Login/login_screen.dart';

class TopographicSurveyScreen extends StatelessWidget {
  final String? name;
  const TopographicSurveyScreen({super.key, this.name});

  static const Color accentColor = Color(0xFFF28C28);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // light background like modal
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            child: Center(
              child: Container(
                height: 500,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                         Text(
                          name.toString(),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    /// Benefits
                    const Text(
                      'Benefits:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),

                    _bullet('Professional service delivery'),
                    _bullet('Expert technical support'),
                    _bullet('Quality assurance'),
                    _bullet('Timely completion'),

                    const SizedBox(height: 20),

                    /// When needed
                    const Text(
                      'When do you need the  Topographic Survey service?',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),

                    _bullet('When you need professional consultation'),
                    _bullet('For project planning and execution'),
                    _bullet('When quality standards are required'),

                    const Spacer(),

                    /// Buttons
                    Row(
                      children: [
                        Expanded(
                          child: _outlinedButton(
                            text: 'Provide service',
                            onTap: () {
                              Get.to(
                                LoginScreen()
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _outlinedButton(
                            text: 'Request Service',
                            onTap: () {
                              Get.to(
                                  LoginScreen()
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Bullet Item
  static Widget _bullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '• ',
            style: TextStyle(
              color: accentColor,
              fontSize: 18,
              height: 1.3,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: accentColor,
                fontSize: 14,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Outlined Button
  static Widget _outlinedButton({
    required String text,
    required VoidCallback onTap,
  }) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        foregroundColor: accentColor,
        side: const BorderSide(color: accentColor),
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: onTap,
      child: Text(text),
    );
  }
}
