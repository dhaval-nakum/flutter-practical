import 'package:flutter/material.dart';

import 'package:flutter_practical/constants/app_strings.dart';
import 'package:flutter_practical/utils/extension.dart';

import '../models/page_flip/page_content_model.dart';

class PageFlipScreen extends StatefulWidget {
  const PageFlipScreen({super.key});

  @override
  State<PageFlipScreen> createState() => _PageFlipScreenState();
}

class _PageFlipScreenState extends State<PageFlipScreen> {
  Offset? _dragPosition;
  int _currentPage = 0;
  bool _isDragging = false;

  final List<PageContent> _pages = [
    PageContent(
      title: 'Welcome to Flipbook',
      content: 'Drag from top-right corner to flip pages',
      description: 'This is the first page of the flipbook.',
      color: Colors.blue.shade50,
      image: Icons.auto_stories,
    ),
    PageContent(
      title: 'Interactive Pages',
      content: 'Experience realistic page turning',
      description: 'This page showcases the interactive features.',
      color: Colors.green.shade50,
      image: Icons.touch_app,
    ),
    PageContent(
      title: 'Smooth Animations',
      content: 'Feel the natural page curl effect',
      description: 'Enjoy the smooth animations as you flip through.',
      color: Colors.orange.shade50,
      image: Icons.animation,
    ),
    PageContent(
      title: 'Beautiful Design',
      content: 'Enjoy the carefully crafted visuals',
      description: 'This page highlights the beautiful design elements.',
      color: Colors.purple.shade50,
      image: Icons.design_services,
    ),
  ];

  void _handlePanStart(DragStartDetails details) {
    final topRightCorner = Offset(MediaQuery.of(context).size.width - 100, 0);
    if ((details.localPosition - topRightCorner).distance < 100) {
      setState(() {
        _isDragging = true;
        _dragPosition = details.localPosition;
      });
    }
  }

  void _handlePanUpdate(DragUpdateDetails details) {
    if (_isDragging) {
      setState(() {
        _dragPosition = details.localPosition;
      });
    }
  }

  void _handlePanEnd(DragEndDetails details) {
    if (_isDragging) {
      final velocity = details.velocity.pixelsPerSecond;
      final shouldTurnPage = velocity.dx.abs() > 200 || (_dragPosition?.dx ?? 0) < MediaQuery.of(context).size.width * 0.5;

      setState(() {
        if (shouldTurnPage && _currentPage < _pages.length - 1) {
          _currentPage++;
        }
        _isDragging = false;
        _dragPosition = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(AppStrings.pageFlip),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
      ),
      body: GestureDetector(
        onPanStart: _handlePanStart,
        onPanUpdate: _handlePanUpdate,
        onPanEnd: _handlePanEnd,
        child: Stack(
          children: [
            // Next page (showing underneath)
            if (_currentPage < _pages.length - 1) _buildPage(_currentPage + 1),

            // Current page with curl effect
            if (_currentPage < _pages.length)
              ClipPath(
                clipper: PageClipper(
                  dragPosition: _dragPosition,
                  isDragging: _isDragging,
                ),
                child: Stack(
                  children: [
                    _buildPage(_currentPage),
                    if (_isDragging && _dragPosition != null)
                      CustomPaint(
                        painter: CurlEffectPainter(
                          dragPosition: _dragPosition!,
                        ),
                        size: Size.infinite,
                      ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(int index) {
    final page = _pages[index];
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: page.color,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter: BackgroundPatternPainter(
                  color: page.color.darker(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  Center(
                    child: Icon(
                      page.image,
                      size: 80,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 60),
                  Text(
                    page.title,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    page.content,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black54,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    page.description,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black45,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 24,
              right: 24,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${index + 1}/${_pages.length}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PageClipper extends CustomClipper<Path> {
  final Offset? dragPosition;
  final bool isDragging;

  PageClipper({
    required this.dragPosition,
    required this.isDragging,
  });

  @override
  Path getClip(Size size) {
    if (!isDragging || dragPosition == null) {
      return Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    }

    final path = Path();
    final radius = (Offset(size.width, 0) - dragPosition!).distance * 0.2;

    path.moveTo(0, 0);
    path.lineTo(size.width - radius, 0);
    path.quadraticBezierTo(
      size.width - radius / 2,
      radius / 2,
      dragPosition!.dx,
      dragPosition!.dy,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class CurlEffectPainter extends CustomPainter {
  final Offset dragPosition;

  CurlEffectPainter({required this.dragPosition});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withOpacity(0.3)
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

    final radius = (Offset(size.width, 0) - dragPosition).distance * 0.2;

    final shadowPath = Path()
      ..moveTo(dragPosition.dx, dragPosition.dy)
      ..lineTo(size.width - radius, 0)
      ..quadraticBezierTo(
        size.width - radius / 2,
        radius / 2,
        dragPosition.dx + 20,
        dragPosition.dy + 20,
      );

    canvas.drawPath(shadowPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class BackgroundPatternPainter extends CustomPainter {
  final Color color;

  BackgroundPatternPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    const spacing = 20.0;
    for (double i = 0; i < size.width; i += spacing) {
      canvas.drawLine(
        Offset(i, 0),
        Offset(i, size.height),
        paint,
      );
    }

    for (double i = 0; i < size.height; i += spacing) {
      canvas.drawLine(
        Offset(0, i),
        Offset(size.width, i),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
