import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:volt_market/features/products/logic/cubit/product_cubit.dart';

class RatingDisplay extends StatefulWidget {
  RatingDisplay({super.key});

  @override
  State<RatingDisplay> createState() => _RatingDisplayState();
}

class _RatingDisplayState extends State<RatingDisplay> {
  double rating = 0.0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    rating = context.read<ProductCubit>().productRating;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Stars
        RatingBar.builder(
          itemBuilder: (context, _) => Icon(Icons.star, color: Colors.amber),
          itemCount: 5,
          itemSize: 20.0,
          initialRating: context.read<ProductCubit>().productRating,
          unratedColor: Colors.amber.withAlpha(50),
          direction: Axis.horizontal,
          onRatingUpdate: (value) {
            setState(() {
              rating = value;
              debugPrint(value.toString());
              context.read<ProductCubit>().submitRating(
                productId: context.read<ProductCubit>().currentProduct!.id,
                rating: value.toInt(),
              );
            });
          },
        ),
        // Rating text
        const SizedBox(width: 4),
        Text(
          rating.toStringAsFixed(1),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20 * 0.8),
        ),
      ],
    );
  }
}
