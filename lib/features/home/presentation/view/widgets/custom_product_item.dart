import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_market/features/home/data/model/products_model.dart';
import 'package:super_market/features/home/presentation/manager/cubit/products_cubit.dart';
import 'package:super_market/features/home/presentation/view/product_details_view.dart';

class CustomProductItem extends StatefulWidget {
  const CustomProductItem({super.key, required this.productModel});

  final ProductsModel productModel;

  @override
  State<CustomProductItem> createState() => _CustomProductItemState();
}

class _CustomProductItemState extends State<CustomProductItem> {
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          ProductDetailsView.productDetailsId,
          arguments: widget.productModel,
        );
      },
      child: Container(
        // width: 120,
        margin: EdgeInsets.symmetric(horizontal: 8),
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[200],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.star, color: Colors.amber),

                Text(
                  widget.productModel.rating.toString(),
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),

            Center(
              child: Container(
                width: 70,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(widget.productModel.image),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),

            Text(
              widget.productModel.name,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.productModel.description,
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "\$${widget.productModel.price}",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),

                widget.productModel.isOffers
                    ? Text(
                        "\$5",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                          decorationThickness: 3,
                          decorationColor: Colors.grey,
                        ),
                      )
                    : SizedBox.shrink(),

                IconButton(
                  onPressed: () {
                    final cubit = context.read<ProductsCubit>();
                    final productId = widget.productModel.id;

                    if (cubit.favoriteIds.contains(productId)) {
                      log("remove");
                      cubit.removeFavorite(productId);
                      
                    } else {
                      log("add");
                      cubit.addFavoriteProduct(
                        productId: widget.productModel.id,
                      );
                      
                    }
                  },
                  icon: BlocBuilder<ProductsCubit, ProductsState>(
                  
                    builder: (context, state) {
                      final cubit = context.read<ProductsCubit>();
                      final isFavorite =
                          cubit.favoriteIds.contains(widget.productModel.id);

                      return Icon(
                        isFavorite 
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color:
                        isFavorite 
                            ? Colors.red
                            : Colors.grey,
                        size: 20,
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
