
import 'package:flutter/material.dart';

class SliverToBoxAdapterTextType extends StatelessWidget {
  const SliverToBoxAdapterTextType({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          "Categories",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

