import 'package:flutter/material.dart';
import 'package:products/models/product_model.dart';
import 'package:products/pages/product_detail.dart';
import 'package:products/pages/product_list.dart';
import 'package:shared/shared.dart';

class ProductListDetailSplitScreen extends StatelessWidget {
  const ProductListDetailSplitScreen({
    super.key,
    required this.productList,
    required ValueNotifier<Product> productDetailNotifier,
  }) : _productDetailNotifier = productDetailNotifier;

  final List<Product> productList;
  final ValueNotifier<Product> _productDetailNotifier;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // List
        SizedBox(
          width: ResponsiveSizes.sidebarWidth.value,
          child: ProductList(
            isMobile: false,
            productList: productList,
            productDetailNotifier: _productDetailNotifier,
          ),
        ),

        const VerticalDivider(width: 1.0),

        // Details
        Expanded(
          child: ValueListenableBuilder<Product>(
            valueListenable: _productDetailNotifier,
            builder: (
              BuildContext context,
              Product product,
              Widget? child,
            ) {
              return ProductDetail(
                product: product,
              );
            },
          ),
        ),
      ],
    );
  }
}
