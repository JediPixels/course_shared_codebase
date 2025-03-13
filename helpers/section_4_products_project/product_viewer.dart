import 'package:flutter/material.dart';
import 'package:products/pages/product_list_detail_split_screen.dart';
import 'package:shared/shared.dart';
import 'package:products/models/product_model.dart';
import 'package:products/pages/product_list.dart';
import 'package:products/services/product_service.dart';

class ProductViewer extends StatefulWidget {
  const ProductViewer({
    super.key,
  });

  @override
  State<ProductViewer> createState() => _ProductViewerState();
}

class _ProductViewerState extends State<ProductViewer> {
  late ConnectionService connectionService;
  ProductService productService = ProductService();
  final ValueNotifier<Product> _productDetailNotifier = ValueNotifier<Product>(
    Product.blankDefaultValues(),
  );
  final bool isSearchVisible = false;

  @override
  void initState() {
    super.initState();
    connectionService = ConnectionService(
      clearDataList: productService.clearProductList,
      getDataList: productService.getProductsList,
    );
    _checkConnectivityRetrieveProduct();
  }

  _checkConnectivityRetrieveProduct() async {
    connectionService.isInternetConnectionAvailable();
    connectionService.watchConnectivity();
  }

  @override
  void dispose() {
    productService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: StreamBuilder<List<Product>>(
          initialData: const [],
          stream: productService.productListStream,
          builder: (
            BuildContext context,
            AsyncSnapshot<List<Product>> snapshot,
          ) {
            if (snapshot.hasData == false) {
              return const Center(child: CircularProgressIndicator());
            }

            if (connectionService.isConnectionAvailable == false) {
              return const StatusMessage(
                message: 'Internet connection is not available',
                bannerMessage: 'none',
                bannerColor: Colors.yellow,
                textColor: Colors.black,
              );
            }

            List<Product> productList = snapshot.requireData;

            return ResponsiveLayoutBuilder(
              mobile: ProductList(
                isMobile: true,
                productList: productList,
                productDetailNotifier: _productDetailNotifier,
              ),
              webDesktopTablet: ProductListDetailSplitScreen(
                productList: productList,
                productDetailNotifier: _productDetailNotifier,
              ),
            );
          },
        ),
      ),
    );
  }
}
