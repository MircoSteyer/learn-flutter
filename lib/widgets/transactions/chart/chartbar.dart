import 'package:flutter/material.dart';

class Chartbar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPercentageOfTotal;

  const Chartbar(
      {required this.label,
      required this.spendingAmount,
      required this.spendingPercentageOfTotal,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (layoutContext, constraints) {
      return Column(
        children: [
          Container(
              height: constraints.maxHeight * .15,
              child: FittedBox(
                  child: Text("\$${spendingAmount.toStringAsFixed(0)}"))),
          SizedBox(height: constraints.maxHeight * .05),
          // test if fractionsizedbox also works
          Container(
            height: constraints.maxHeight * .6,
            width: constraints.maxWidth * .8,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).colorScheme.primary,
                          width: 1),
                      borderRadius: BorderRadius.circular(10)),
                ),
                FractionallySizedBox(
                  heightFactor: spendingPercentageOfTotal,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * .05,
          ),
          SizedBox(
              height: constraints.maxHeight * .15,
              child: FittedBox(child: Text(label)))
        ],
      );
    });
  }
}
