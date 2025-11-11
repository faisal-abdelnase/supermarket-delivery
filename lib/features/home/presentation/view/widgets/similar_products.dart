import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_market/features/home/presentation/manager/cubit/products_cubit.dart';
import 'package:super_market/features/home/presentation/view/widgets/custom_product_item.dart';

class SimilarProducts extends StatelessWidget {
  const SimilarProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      child: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, state) {
          if(state is ProductsSuccess){
            return AspectRatio(
              aspectRatio: 1.4,
              child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (context, index) {
                return AspectRatio(
                  aspectRatio: 0.8,
                  child: CustomProductItem(productModel: state.products[index]));
              },
                        ),
            );
          }
          else if(state is ProductsError){
            return Center(
              child: Text(state.errorMessage),
            );
          }

          else {
            return Center(
              child: Icon(Icons.warning, color: Colors.red, size: 50,),
            );
          }
        },
      ),
    );
  }
}
