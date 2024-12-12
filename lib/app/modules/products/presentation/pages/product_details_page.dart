import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:tezda_task/app/modules/Products/presentation/providers/get_Products_provider.dart';
import 'package:tezda_task/app/modules/products/data/models/platzi_product_data.dart';
import 'package:tezda_task/core/framework/theme/colors/app_theme_provider.dart';

import '../../../../../core/navigation/navigator.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../shared/presentation/widgets/tezda_task_icon.dart';

class ProductDetailsPage extends ConsumerStatefulWidget {
  final PlatziProductData productData;
  const ProductDetailsPage({super.key, required this.productData});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends ConsumerState<ProductDetailsPage> {

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final colors = ref.read(appThemeProvider).colors;
    final topMargin = MediaQuery.of(context).padding.top;
    final productsState = ref.watch(getProductsProvider);
    return Scaffold(
      backgroundColor: colors.alwaysBlack,
      key: const Key("product_details_page"),
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: tezda_taskIcon(
            icon: Icons.arrow_back,
            key: const Key("arrow_back"),
            onTap: () {
              pop(context);
            },
          ),
        ),
        title: Text(
          "${widget.productData.title}",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            fontFamily: 'DM Sans',
            color: colors.alwaysBlack,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 32.0,bottom: 50.0,left: 8,right: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: (widget.productData.images ?? []).isNotEmpty
                  ? CachedNetworkImage(
                  imageUrl: (widget.productData.images ?? []).first ?? "",
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(image: imageProvider),
                      // borderRadius: const BorderRadius.all(
                      //   Radius.circular(50),
                      // ),
                    ),
                  ),
                  placeholder: (context, url) =>
                  const SizedBox(height: 24, width: 24, child: CupertinoActivityIndicator()),
                  errorWidget: (context, url, error) => Center(
                    child: Image.asset(
                      Assets.images.noProductImage.path,
                      height: 300,
                      width: 300,
                    ),
                  ))
                  : Center(
                    child: Image.asset(
                                    Assets.images.noProductImage.path,
                                    // height: 45,
                                    // width: 45,
                                  ),
                  ),
            ),
            Center(
              child: Text(
                "\$${widget.productData.price}",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'DM Sans',
                  color: Colors.teal,
                ),
              ),
            ),
            const Gap(20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Description",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w700,
                    color: Colors.blueAccent,
                  ),
                ),
                const Gap(10),
                Text(
                  "${widget.productData.description}",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w700,
                      color: colors.alwaysWhite,
                      fontStyle: FontStyle.italic
                  ),
                ),
              ],
            ),

            const Gap(20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Category",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w700,
                      color: Colors.blueAccent,
                  ),
                ),
                const Gap(10),
                Text(
                  "${widget.productData.category?.name}",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w700,
                      color: colors.alwaysWhite,
                      fontStyle: FontStyle.italic
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
