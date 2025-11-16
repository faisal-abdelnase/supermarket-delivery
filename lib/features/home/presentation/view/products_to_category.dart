import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_market/core/utils/widgets/custom_arrow_back_button.dart';
import 'package:super_market/features/home/presentation/manager/cubit/products_cubit.dart';
import 'package:super_market/features/home/presentation/view/home_view.dart';
import 'package:super_market/features/home/presentation/view/widgets/all_product_grid_view.dart';


class ProductsToCategory extends StatelessWidget {
  const ProductsToCategory({super.key});

  static const String productsToCategoryId = 'productsToCategoryId';

  @override
  Widget build(BuildContext context) {
    final String categoryName =
        ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      body: SafeArea(
        top: true,
        child: BlocBuilder<ProductsCubit, ProductsState>(
          builder: (context, state) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      spacing: MediaQuery.of(context).size.width * 0.2,
                      children: [
                        CustomArrowBackButton(
                          onPressed: () {

                            BlocProvider.of<ProductsCubit>(context).getAllProducts();
                            Navigator.pushReplacementNamed(
                              context,
                              HomeView.homeId,
                            );
                          },
                        ),
                        Text(
                          categoryName,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                AllProductGridView(),
              ],
            );
          },
        ),
      ),
    );
  }
}
