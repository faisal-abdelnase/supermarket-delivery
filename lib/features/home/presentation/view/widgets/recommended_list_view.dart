import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_market/features/home/presentation/manager/cubit/products_cubit.dart';
import 'package:super_market/features/home/presentation/view/widgets/custom_product_item.dart';

class RecommendedListView extends StatefulWidget {
  const RecommendedListView({super.key});

  @override
  State<RecommendedListView> createState() => _RecommendedListViewState();
}

class _RecommendedListViewState extends State<RecommendedListView> {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, state) {
          if(state is ProductsSuccess){
            return AspectRatio(
              aspectRatio: 1.5,
              child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              scrollDirection: Axis.horizontal,
              
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (context, index) {
                return AspectRatio(
                  aspectRatio: 0.7,
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
