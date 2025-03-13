import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import 'package:products/models/product_model.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key, required this.product});

  final Product product;

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.product.title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      body: SafeArea(
        // Optional - ChangeMetricsObserver - Fun Observing Size Changes
        child: ChangeMetricsObserver(
          enableObserver: kIsWeb,
          didChangeMetricsCallback: (bool isWeb) {
            if (isWeb) {
              debugPrint('Size: ${MediaQuery.sizeOf(context).width}');
            }
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: ImageSizes.imageHeight,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Image.network(
                        widget.product.images[index],
                        fit: BoxFit.contain,
                        loadingBuilder: (
                          BuildContext context,
                          Widget image,
                          ImageChunkEvent? loadingProgress,
                        ) {
                          if (loadingProgress == null) return image;
                          return SizedBox(
                            height: ImageSizes.imageHeight,
                            child: Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            ),
                          );
                        },
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 3),
                    itemCount: widget.product.images.length,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product.title,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        widget.product.category,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        '${widget.product.price > 0 ? widget.product.price : ""}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        '${widget.product.rating > 0 ? widget.product.rating : ""}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}