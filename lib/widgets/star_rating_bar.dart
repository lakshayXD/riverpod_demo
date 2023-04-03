import 'package:flutter/material.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:infinity_box_task/utils/color_constants.dart';

class StarRatingBar extends StatelessWidget {
  final double productRating;
  final Color ratingBarBackgroundColor;
  const StarRatingBar(
      {Key? key,
      required this.productRating,
      required this.ratingBarBackgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: ratingBarBackgroundColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          RatingBarIndicator(
              rating: productRating,
              itemCount: 5,
              itemSize: 12.0,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, _) {
                return Row(
                  children: const <Widget>[
                    Icon(Icons.star, color: ColorConstants.golden),
                    SizedBox(
                      width: 3,
                    )
                  ],
                );
              }),
          const SizedBox(
            width: 4.0,
          ),
          Text(
            '$productRating/5',
            style: Theme.of(context).textTheme.headline4,
          ),
        ],
      ),
    );
  }
}
