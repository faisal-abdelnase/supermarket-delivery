
import 'package:flutter/material.dart';

class SliverToBoxAdapterTextType extends StatelessWidget {
  const SliverToBoxAdapterTextType({
    super.key, required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

