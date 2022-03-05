import 'package:flutter/material.dart';

import '../../../styles.dart';

class SinglePageHeader extends StatelessWidget {
  final Widget reusableWidget;
  const SinglePageHeader({Key? key, required this.reusableWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              top: 10,
            ),
            child: Text("Heading Movie", style: Styles.textSectionHeader,),
          ),
          Divider(
            color: Styles.primaryThemeColor,
            thickness: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              top: 5,
              bottom: 5,
              right: 5,
            ),
            child: reusableWidget,
          ),
        ],
      ),
    );
  }
}
