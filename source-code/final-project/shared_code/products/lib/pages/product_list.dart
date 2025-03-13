import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:products/models/product_model.dart';
import 'package:products/pages/product_detail.dart';
import 'package:shared/shared.dart';

class ProductList extends StatefulWidget {
  const ProductList({
    super.key,
    required this.isMobile,
    required this.productList,
    required this.productDetailNotifier,
  });

  final bool isMobile;
  final List<Product> productList;
  final ValueNotifier<Product> productDetailNotifier;

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    return kIsWeb
        ? Navigator(
            onGenerateRoute: (settings) {
              return MaterialPageRoute(
                builder: (context) => ProductListCustomScrollView(
                  isMobile: widget.isMobile,
                  productList: widget.productList,
                  productDetailNotifier: widget.productDetailNotifier,
                ),
              );
            },
          )
        : ProductListCustomScrollView(
            isMobile: widget.isMobile,
            productList: widget.productList,
            productDetailNotifier: widget.productDetailNotifier,
          );
  }
}

class ProductListCustomScrollView extends StatefulWidget {
  const ProductListCustomScrollView({
    super.key,
    required this.isMobile,
    required this.productList,
    required this.productDetailNotifier,
  });

  final bool isMobile;
  final List<Product> productList;
  final ValueNotifier<Product> productDetailNotifier;

  @override
  State<ProductListCustomScrollView> createState() =>
      _ProductListCustomScrollViewState();
}

class _ProductListCustomScrollViewState
    extends State<ProductListCustomScrollView> {
  List<Product> _searchProductList = [];
  bool _isSearchVisible = false;
  final TextEditingController _searchEditingController =
      TextEditingController();

  void _searchChangedCallback(String filter) {
    setState(() {
      _searchProductList = widget.productList
          .where((product) =>
              product.title.toLowerCase().contains(filter.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.white.withOpacity(0.50),
              child: IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: ThemeColors.black,
                ),
                onPressed: () {
                  showAboutDialog(
                    context: context,
                    applicationName: 'Product Viewer',
                    applicationVersion: 'v1.0',
                    applicationIcon: const Icon(Icons.self_improvement_rounded),
                  );
                },
              ),
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.white.withOpacity(0.50),
                child: IconButton(
                  icon: const Icon(
                    Icons.search,
                    color: ThemeColors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      _isSearchVisible = !_isSearchVisible;
                      if (_isSearchVisible == false) {
                        _searchEditingController.text = '';
                      } else {
                        _searchProductList = widget.productList;
                      }
                    });
                  },
                ),
              ),
            )
          ],
          stretch: true,
          pinned: true,
          forceElevated: true,
          expandedHeight: MediaQuery.sizeOf(context).height / 4,
          collapsedHeight: 60.0,
          flexibleSpace: FlexibleSpaceBar(
            stretchModes: const <StretchMode>[
              StretchMode.zoomBackground,
              StretchMode.fadeTitle,
            ],
            title: Text(
              'Products Viewer',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).indicatorColor,
                decorationThickness: 0.0,
                shadows: <Shadow>[
                  const Shadow(
                    color: ThemeColors.black,
                    offset: Offset(1, 1),
                    blurRadius: 12,
                  ),
                ],
              ),
            ),
            centerTitle: true,
            background: Image.asset(
              'assets/images/products.png',
              fit: BoxFit.none,
            ),
          ),
        ),
        const SliverPadding(padding: EdgeInsets.all(4.0)),

        // Search
        SliverAnimatedOpacity(
          opacity: _isSearchVisible ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
          sliver: _isSearchVisible
              ? SliverPersistentHeader(
                  delegate: SearchStickyHeaderDelegate(
                    searchEditingController: _searchEditingController,
                    searchOnChangedCallback: _searchChangedCallback,
                  ),
                  pinned: true,
                )
              : const SliverToBoxAdapter(child: SizedBox()),
        ),

        SliverList.separated(
          itemCount: _isSearchVisible
              ? _searchProductList.length
              : widget.productList.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(
                _isSearchVisible
                    ? _searchProductList[index].title
                    : widget.productList[index].title,
              ),
              onTap: () {
                widget.productDetailNotifier.value = _isSearchVisible
                    ? _searchProductList[index]
                    : widget.productList[index];
                if (widget.isMobile) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ProductDetail(
                        product: _isSearchVisible
                            ? _searchProductList[index]
                            : widget.productList[index],
                      ),
                    ),
                  );
                }
              },
            );
          },
          separatorBuilder: (context, index) => const Divider(),
        ),
      ],
    );
  }
}
