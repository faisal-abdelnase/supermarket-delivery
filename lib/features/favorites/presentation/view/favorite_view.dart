import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_market/core/utils/widgets/custom_arrow_back_button.dart';
import 'package:super_market/features/home/data/model/products_model.dart';
import 'package:super_market/features/home/presentation/manager/cubit/products_cubit.dart';
import 'package:super_market/features/home/presentation/view/home_view.dart';
import 'package:super_market/features/home/presentation/view/widgets/custom_product_item.dart';
import 'package:super_market/features/home/presentation/view/widgets/offers_item.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                spacing: MediaQuery.of(context).size.width * 0.2,
                children: [
                  CustomArrowBackButton(
                    onPressed: (){
                      Navigator.pushReplacementNamed(context, HomeView.homeId);
                    },
                  ),
                  Text("My Favorite", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                ],
                
              ),


              SizedBox(height: 24,),
            
            
            
              FutureBuilder<List<ProductsModel>>(
                future: context.read<ProductsCubit>().getFavoriteProducts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator());
                  }
              
                  if (snapshot.hasError) {
                    return const Center(
                        child: Text("Something went wrong"));
                  }
              
                  final favoriteProducts = snapshot.data ?? [];
              
                  if (favoriteProducts.isEmpty) {
                    return const Center(
                        child: Center(child: Text("No favorite products")));
                  }
              
                  return GridView.builder(
                    itemCount: favoriteProducts.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 8,
                      childAspectRatio: 0.7,
                    ),
                    itemBuilder: (context, index) {
                      final product = favoriteProducts[index];
              
                      return product.isOffers
                          ? OffersItem(productsModel: product)
                          : CustomProductItem(
                              productModel: product);
                    },
                  );
                },
              ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}








































