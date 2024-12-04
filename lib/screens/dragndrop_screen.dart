import 'package:flutter/material.dart';
import 'package:flutter_practical/constants/app_colors.dart';
import 'package:flutter_practical/constants/app_strings.dart';

// Flutter Task 1:
// Drag and Drop Without Packages or Built-In Widgets
// Objective:
// Implement a custom drag-and-drop feature in Flutter without
// using external packages or built-in drag-and-drop widgets like Draggable or DragTarget.

class DragAndDropPage extends StatefulWidget {
  const DragAndDropPage({super.key});

  @override
  State<DragAndDropPage> createState() => _DragAndDropPageState();
}

class _DragAndDropPageState extends State<DragAndDropPage> {
  // Position of the draggable square
  Offset squarePosition = const Offset(50, 300);
  // Initial position to reset
  final Offset initialPosition = const Offset(50, 300);
  // Target area dimensions
  final Rect targetArea = const Rect.fromLTWH(200, 500, 150, 150);
  // Dragging state
  bool isDragging = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.customDragAndDrop),
      ),
      body: Stack(
        children: [
          // Target Square - Green Square
          Positioned(
            left: targetArea.left,
            top: targetArea.top,
            child: Container(
              width: targetArea.width,
              height: targetArea.height,
              color: AppColors.greenColor.withOpacity(0.5),
              child: const Center(child: Text(AppStrings.dropHere)),
            ),
          ),
          // Draggable Square - Blue Square
          Positioned(
            left: squarePosition.dx,
            top: squarePosition.dy,
            child: GestureDetector(
              onPanStart: (_) {
                setState(() {
                  isDragging = true;
                });
              },
              onPanUpdate: (details) {
                setState(() {
                  squarePosition += details.delta;
                });
              },
              onPanEnd: (_) {
                setState(() {
                  isDragging = false;
                  if (targetArea.contains(squarePosition + const Offset(50, 50))) {
                    // Dropped inside the target
                    squarePosition = Offset(
                      targetArea.left + (targetArea.width - 100) / 2,
                      targetArea.top + (targetArea.height - 100) / 2,
                    );
                  } else {
                    // Reset to initial position
                    squarePosition = initialPosition;
                  }
                });
              },
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: isDragging ? AppColors.redColor.withOpacity(0.7) : AppColors.redColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: isDragging ? [const BoxShadow(blurRadius: 10, color: Colors.black26)] : [],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
