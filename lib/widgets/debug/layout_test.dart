import 'package:flutter/material.dart';

class LayoutTest extends StatelessWidget {
  const LayoutTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Personal Expenses App"),
        ),
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(color: Colors.green),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(color: Colors.blue),
                  ),
                ],
              ),
            ),
            Divider(),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Text("A"),
                            color: Colors.red[300],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: Text("B"),
                      color: Colors.yellow[400],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
