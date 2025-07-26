import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:interview/app/routes/route_names.dart';

class InterviewerScreen extends StatefulWidget {
  const InterviewerScreen({super.key});

  @override
  InterviewerScreenState createState() => InterviewerScreenState();
}

class InterviewerScreenState extends State<InterviewerScreen>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _glowController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _glowAnimation;

  int currentQuestion = 2;
  int totalQuestions = 5;
  int confidenceScore = 78;
  String eyeContact = "Maintained";
  String posture = "Slouched";
  bool isRecording = false;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _glowController = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _glowAnimation = Tween<double>(begin: 0.3, end: 0.8).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  Color _getConfidenceColor() {
    if (confidenceScore >= 70) return Color(0xFF4CAF50);
    if (confidenceScore >= 50) return Color(0xFFFFC107);
    return Color(0xFFFF5722);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFFBF0),
              Color(0xFFF8F4E6),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Stack(
              children: [
                // Timer Badge positioned at top left
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Color(0xFF8B4513),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(25),
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      'Timer',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                // Camera Feed Section taking full height
                Positioned.fill(
                  top: 60, // Space for timer
                  child: AnimatedBuilder(
                    animation: _glowAnimation,
                    builder: (context, child) {
                      return Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: _getConfidenceColor().withAlpha(102),
                              blurRadius: 20,
                              spreadRadius: 2,
                            ),
                            BoxShadow(
                              color: Colors.black.withAlpha(25),
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: Container(
                            color: Color(0xFFE0E0E0),
                            child: Stack(
                              children: [
                                Center(
                                  child: Text(
                                    'Camera',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 18,
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                // Face Bounding Box
                                Positioned(
                                  top: 80,
                                  left: 60,
                                  right: 60,
                                  bottom: 120,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: _getConfidenceColor(),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                                // Eye Contact Dots
                                Positioned(
                                  top: 120,
                                  left: 100,
                                  child: Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF4CAF50),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 120,
                                  right: 100,
                                  child: Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF4CAF50),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Bottom overlay content positioned over camera
                Positioned(
                  bottom: 24, // From bottom of screen
                  left: 0,
                  right: 0,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Question Panel
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(178),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withAlpha(76),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(13),
                              blurRadius: 20,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: Color(0xFF87CEEB).withAlpha(51),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Text(
                                    'Q$currentQuestion/$totalQuestions',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF4682B4),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Color(0xFF87CEEB).withAlpha(25),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.replay,
                                    size: 16,
                                    color: Color(0xFF4682B4),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12),
                            Text(
                              'Question',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF333333),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 20),

                      // Analytics Tiles
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white.withAlpha(153),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: Colors.white.withAlpha(76),
                                  width: 1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withAlpha(13),
                                    blurRadius: 15,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 8,
                                        height: 8,
                                        decoration: BoxDecoration(
                                          color: _getConfidenceColor(),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        'confidence',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 12,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'tone',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF333333),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white.withAlpha(153),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: Colors.white.withAlpha(76),
                                  width: 1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withAlpha(13),
                                    blurRadius: 15,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'eye',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'posture',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF333333),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 24),

                      // Bottom Buttons
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: AnimatedBuilder(
                              animation: _pulseAnimation,
                              builder: (context, child) {
                                return Transform.scale(
                                  scale: isRecording ? _pulseAnimation.value : 1.0,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isRecording = !isRecording;
                                      });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(vertical: 16),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xFF87CEEB).withAlpha(204),
                                            Color(0xFF98FB98).withAlpha(204),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                          color: Colors.white.withAlpha(76),
                                          width: 1,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withAlpha(25),
                                            blurRadius: 15,
                                            offset: Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.mic,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            'Tap to speak',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(width: 16),
                          GestureDetector(
                            onTap: ()=>context.pushNamed(RouteNames.finishInterview),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                              decoration: BoxDecoration(
                                color: Colors.white.withAlpha(204),
                                borderRadius: BorderRadius.circular(24),
                                border: Border.all(
                                  color: Color(0xFFFF6B6B).withAlpha(76),
                                  width: 1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withAlpha(13),
                                    blurRadius: 15,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Text(
                                'END\nINTERVIEW',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Color(0xFFFF6B6B),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  height: 1.2,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:interview/core/constants/colors.dart';
//
// class InterviewerScreen extends StatefulWidget {
//   const InterviewerScreen({super.key});
//
//   @override
//   State<InterviewerScreen> createState() => _InterviewerScreenState();
// }
//
// class _InterviewerScreenState extends State<InterviewerScreen>
//     with TickerProviderStateMixin {
//   late AnimationController _pulseController;
//   late AnimationController _glowController;
//   late Animation<double> _pulseAnimation;
//   late Animation<double> _glowAnimation;
//
//   int currentQuestion = 2;
//   int totalQuestions = 5;
//   int confidenceScore = 78;
//   String eyeContact = "Maintained";
//   String posture = "Slouched";
//   bool isRecording = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _pulseController = AnimationController(
//       duration: Duration(seconds: 2),
//       vsync: this,
//     )..repeat(reverse: true);
//
//     _glowController = AnimationController(
//       duration: Duration(milliseconds: 1500),
//       vsync: this,
//     )..repeat(reverse: true);
//
//     _pulseAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
//       CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
//     );
//
//     _glowAnimation = Tween<double>(begin: 0.3, end: 0.8).animate(
//       CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
//     );
//   }
//
//   @override
//   void dispose() {
//     _pulseController.dispose();
//     _glowController.dispose();
//     super.dispose();
//   }
//
//   Color _getConfidenceColor() {
//     if (confidenceScore >= 70) return Color(0xFF4CAF50);
//     if (confidenceScore >= 50) return Color(0xFFFFC107);
//     return Color(0xFFFF5722);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: AppColors.interviewerGradient,
//         ),
//         child: SafeArea(
//           child: Padding(
//             padding: EdgeInsets.all(20),
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     Container(
//                       padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                       decoration: BoxDecoration(
//                         color: Color(0xFF8B4513),
//                         borderRadius: BorderRadius.circular(20),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withAlpha(25),
//                             blurRadius: 8,
//                             offset: Offset(0, 2),
//                           ),
//                         ],
//                       ),
//                       child: Text(
//                         'Timer',
//                         style: TextStyle(
//                           fontFamily: 'Poppins',
//                           color: Colors.white,
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//
//                 SizedBox(height: 20),
//
//                 Expanded(
//                   flex: 6,
//                   child: AnimatedBuilder(
//                     animation: _glowAnimation,
//                     builder: (context, child) {
//                       return Container(
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(24),
//                           boxShadow: [
//                             BoxShadow(
//                               color: _getConfidenceColor().withAlpha(102),
//                               blurRadius: 20,
//                               spreadRadius: 2,
//                             ),
//                             BoxShadow(
//                               color: Colors.black.withAlpha(25),
//                               blurRadius: 10,
//                               offset: Offset(0, 4),
//                             ),
//                           ],
//                         ),
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(24),
//                           child: Container(
//                             color: Color(0xFFE0E0E0),
//                             child: Stack(
//                               children: [
//                                 Center(
//                                   child: Text(
//                                     'Camera',
//                                     style: TextStyle(
//                                       fontFamily: 'Poppins',
//                                       fontSize: 18,
//                                       color: Colors.grey[600],
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                                   ),
//                                 ),
//                                 Positioned(
//                                   top: 80,
//                                   left: 60,
//                                   right: 60,
//                                   bottom: 120,
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       border: Border.all(
//                                         color: _getConfidenceColor(),
//                                         width: 2,
//                                       ),
//                                       borderRadius: BorderRadius.circular(12),
//                                     ),
//                                   ),
//                                 ),
//                                 Positioned(
//                                   top: 120,
//                                   left: 100,
//                                   child: Container(
//                                     width: 8,
//                                     height: 8,
//                                     decoration: BoxDecoration(
//                                       color: Color(0xFF4CAF50),
//                                       shape: BoxShape.circle,
//                                     ),
//                                   ),
//                                 ),
//                                 Positioned(
//                                   top: 120,
//                                   right: 100,
//                                   child: Container(
//                                     width: 8,
//                                     height: 8,
//                                     decoration: BoxDecoration(
//                                       color: Color(0xFF4CAF50),
//                                       shape: BoxShape.circle,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//
//                 SizedBox(height: 24),
//
//                 Container(
//                   width: double.infinity,
//                   padding: EdgeInsets.all(20),
//                   decoration: BoxDecoration(
//                     color: Colors.white.withAlpha(178),
//                     borderRadius: BorderRadius.circular(20),
//                     border: Border.all(
//                       color: Colors.white.withAlpha(76),
//                       width: 1,
//                     ),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withAlpha(13),
//                         blurRadius: 20,
//                         offset: Offset(0, 4),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Container(
//                             padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                             decoration: BoxDecoration(
//                               color: Color(0xFF87CEEB).withAlpha(51),
//                               borderRadius: BorderRadius.circular(16),
//                             ),
//                             child: Text(
//                               'Q$currentQuestion/$totalQuestions',
//                               style: TextStyle(
//                                 fontFamily: 'Poppins',
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w600,
//                                 color: Color(0xFF4682B4),
//                               ),
//                             ),
//                           ),
//                           Container(
//                             padding: EdgeInsets.all(8),
//                             decoration: BoxDecoration(
//                               color: Color(0xFF87CEEB).withAlpha(25),
//                               shape: BoxShape.circle,
//                             ),
//                             child: Icon(
//                               Icons.replay,
//                               size: 16,
//                               color: Color(0xFF4682B4),
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 12),
//                       Text(
//                         'Question',
//                         style: TextStyle(
//                           fontFamily: 'Poppins',
//                           fontSize: 18,
//                           fontWeight: FontWeight.w600,
//                           color: Color(0xFF333333),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//
//                 SizedBox(height: 20),
//
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Container(
//                         padding: EdgeInsets.all(16),
//                         decoration: BoxDecoration(
//                           color: Colors.white.withAlpha(153),
//                           borderRadius: BorderRadius.circular(16),
//                           border: Border.all(
//                             color: Colors.white.withAlpha(76),
//                             width: 1,
//                           ),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withAlpha(13),
//                               blurRadius: 15,
//                               offset: Offset(0, 2),
//                             ),
//                           ],
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               children: [
//                                 Container(
//                                   width: 8,
//                                   height: 8,
//                                   decoration: BoxDecoration(
//                                     color: _getConfidenceColor(),
//                                     shape: BoxShape.circle,
//                                   ),
//                                 ),
//                                 SizedBox(width: 8),
//                                 Text(
//                                   'confidence',
//                                   style: TextStyle(
//                                     fontFamily: 'Poppins',
//                                     fontSize: 12,
//                                     color: Colors.grey[600],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 4),
//                             Text(
//                               'tone',
//                               style: TextStyle(
//                                 fontFamily: 'Poppins',
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w500,
//                                 color: Color(0xFF333333),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: 12),
//                     Expanded(
//                       child: Container(
//                         padding: EdgeInsets.all(16),
//                         decoration: BoxDecoration(
//                           color: Colors.white.withAlpha(153),
//                           borderRadius: BorderRadius.circular(16),
//                           border: Border.all(
//                             color: Colors.white.withAlpha(76),
//                             width: 1,
//                           ),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withAlpha(13),
//                               blurRadius: 15,
//                               offset: Offset(0, 2),
//                             ),
//                           ],
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'eye',
//                               style: TextStyle(
//                                 fontFamily: 'Poppins',
//                                 fontSize: 12,
//                                 color: Colors.grey[600],
//                               ),
//                             ),
//                             SizedBox(height: 4),
//                             Text(
//                               'posture',
//                               style: TextStyle(
//                                 fontFamily: 'Poppins',
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w500,
//                                 color: Color(0xFF333333),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//
//                 SizedBox(height: 24),
//
//                 Row(
//                   children: [
//                     Expanded(
//                       flex: 2,
//                       child: AnimatedBuilder(
//                         animation: _pulseAnimation,
//                         builder: (context, child) {
//                           return Transform.scale(
//                             scale: isRecording ? _pulseAnimation.value : 1.0,
//                             child: GestureDetector(
//                               onTap: () {
//                                 setState(() {
//                                   isRecording = !isRecording;
//                                 });
//                               },
//                               child: Container(
//                                 padding: EdgeInsets.symmetric(vertical: 16),
//                                 decoration: BoxDecoration(
//                                   gradient: LinearGradient(
//                                     colors: [
//                                       Color(0xFF87CEEB).withAlpha(204),
//                                       Color(0xFF98FB98).withAlpha(204),
//                                     ],
//                                   ),
//                                   borderRadius: BorderRadius.circular(16),
//                                   border: Border.all(
//                                     color: Colors.white.withAlpha(76),
//                                     width: 1,
//                                   ),
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Colors.black.withAlpha(25),
//                                       blurRadius: 15,
//                                       offset: Offset(0, 4),
//                                     ),
//                                   ],
//                                 ),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Icon(
//                                       Icons.mic,
//                                       color: Colors.white,
//                                       size: 20,
//                                     ),
//                                     SizedBox(width: 8),
//                                     Text(
//                                       'Tap to speak',
//                                       style: TextStyle(
//                                         fontFamily: 'Poppins',
//                                         color: Colors.white,
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                     SizedBox(width: 16),
//                     GestureDetector(
//                       onTap: () {
//                         // End interview
//                       },
//                       child: Container(
//                         padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//                         decoration: BoxDecoration(
//                           color: Colors.white.withAlpha(204),
//                           borderRadius: BorderRadius.circular(24),
//                           border: Border.all(
//                             color: Color(0xFFFF6B6B).withAlpha(76),
//                             width: 1,
//                           ),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withAlpha(13),
//                               blurRadius: 15,
//                               offset: Offset(0, 4),
//                             ),
//                           ],
//                         ),
//                         child: Text(
//                           'END\nINTERVIEW',
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             fontFamily: 'Poppins',
//                             color: Color(0xFFFF6B6B),
//                             fontSize: 10,
//                             fontWeight: FontWeight.w600,
//                             height: 1.2,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
