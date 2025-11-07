import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_market/features/home/presentation/manager/cubit/products_cubit.dart';
import 'package:super_market/features/home/presentation/view/widgets/custom_product_item.dart';
import 'package:super_market/features/home/presentation/view/widgets/offers_item.dart';

class AllProductGridView extends StatelessWidget {
  const AllProductGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, state) {
          if(state is ProductsSuccess){
            return GridView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            itemCount: state.products.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 8,
              childAspectRatio: 0.7,
            ),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return state.products[index].isOffers 
              ? OffersItem(productsModel: state.products[index]) 
              : CustomProductItem(productModel: state.products[index]);
            },
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
