import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_market/features/home/presentation/manager/cubit/products_cubit.dart';
import 'package:super_market/features/home/presentation/view/widgets/offers_item.dart';

class OffersListView extends StatelessWidget {
  const OffersListView({super.key});

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
                return OffersItem(productsModel: state.products[index],);
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
