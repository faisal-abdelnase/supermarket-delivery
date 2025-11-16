// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:skeletonizer/skeletonizer.dart';
// import 'package:super_market/features/home/data/model/products_model.dart';
// import 'package:super_market/features/home/presentation/manager/cubit/products_cubit.dart';
// import 'package:super_market/features/home/presentation/view/widgets/custom_product_item.dart';
// import 'package:super_market/features/home/presentation/view/widgets/offers_item.dart';

// class ProductToCategoryGridView extends StatelessWidget {
//   const ProductToCategoryGridView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SliverToBoxAdapter(
//       child: BlocBuilder<ProductsCubit, ProductsState>(
//         builder: (context, state) {

//           if(state is ProductsByCategorySuccess){
//             return GridView.builder(
//             padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//             itemCount: state.categoryProducts.length,
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               mainAxisSpacing: 16,
//               crossAxisSpacing: 8,
//               childAspectRatio: 0.7,
//             ),
//             physics: NeverScrollableScrollPhysics(),
//             shrinkWrap: true,
//             itemBuilder: (context, index) {
//                 return state.categoryProducts[index].isOffers 
//                 ? OffersItem(productsModel: state.categoryProducts[index]) 
//                 : CustomProductItem(productModel: state.categoryProducts[index]);
//             },
//           );
//           }





//           if(state is ProductsLodaing){
//             return Skeletonizer(
//               enabled: true,
//               child: GridView.builder(
//               padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//               itemCount: 10,
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 mainAxisSpacing: 16,
//                 crossAxisSpacing: 8,
//                 childAspectRatio: 0.7,
//               ),
//               physics: NeverScrollableScrollPhysics(),
//               shrinkWrap: true,
//               itemBuilder: (context, index) {
//                   return  CustomProductItem(productModel: ProductsModel.empty());
//               },
//                         ),
//             );
//           }

//           else if(state is ProductsError){
//             return Center(
//               child: Text(state.errorMessage),
//             );
//           }

//           else {
//             return Center(
//               child: Icon(Icons.warning, color: Colors.red, size: 50,),
//             );
//           }
//         },
        
//       ),
//     );
//   }
// }
