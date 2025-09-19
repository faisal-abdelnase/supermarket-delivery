import 'package:flutter/material.dart';
import 'package:super_market/features/home/presentation/view/widgets/bottom_buttons_to_product_details.dart';
import 'package:super_market/features/home/presentation/view/widgets/product_details_body.dart';


class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({super.key});

  static const String productDetailsId = '/productDetailsView';

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {

  ScrollController scrollController = ScrollController();
  bool isBottom = false;

  @override
  void initState() {
    scrollController.addListener((){
      isBottom = scrollController.position.pixels >= 
      scrollController.position.maxScrollExtent - 500;  
      

      setState(() {
      });
    });
    super.initState();
  }

  void scrollToTop() {
    scrollController.animateTo(
      0,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        child: Stack(
          children: [
            SingleChildScrollView(
              controller: scrollController,
              child: ProductsDetailsBody()),


              
                Visibility(
                  visible: isBottom,
                  child: Positioned(
                    bottom: 80, 
                    right: 20,
                    child: FloatingActionButton(
                      onPressed: scrollToTop,
                      backgroundColor: Colors.blue,
                      child: Icon(Icons.arrow_upward, color: Colors.white),
                    ),
                  ),
                ) ,
        
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: BottomButtonsToProductDetails(),
            ),
          ],
        ),
      ),

    

      
    );
  }
}

