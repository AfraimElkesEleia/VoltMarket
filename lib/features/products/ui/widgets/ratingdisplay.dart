import 'package:flutter/material.dart';

class RatingDisplay extends StatelessWidget {
  final double rating;
  final double starSize;
  final Color color;

  const RatingDisplay({
    super.key,
    required this.rating,
    this.starSize = 20,
    this.color = Colors.amber,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Stars
        Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(5, (index) {
            return Icon(
              index < rating.floor()
                  ? Icons.star
                  : (index < rating ? Icons.star_half : Icons.star_border),
              color: color,
              size: starSize,
            );
          }),
        ),
        // Rating text
        const SizedBox(width: 4),
        Text(
          rating.toStringAsFixed(1),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: starSize * 0.8,
          ),
        ),
      ],
    );
  }
}
