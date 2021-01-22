import 'package:flutter/material.dart';

class ProductFeature extends StatelessWidget {
  final String iconName;
  final String value;
  final String units;
  const ProductFeature({
    @required this.iconName,
    @required this.value,
    @required this.units,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(16)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[600].withOpacity(0.5),
            blurRadius: 12,
          ),
        ],
      ),
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset('assets/$iconName.png'),
          Text(
            '$value $units',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
