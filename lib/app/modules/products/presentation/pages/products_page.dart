import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:tezda_task/app/modules/Products/presentation/providers/get_Products_provider.dart';
import 'package:tezda_task/app/modules/products/presentation/pages/product_details_page.dart';
import 'package:tezda_task/app/shared/functions/app_functions.dart';
import 'package:tezda_task/app/shared/presentation/widgets/custom_button.dart';
import 'package:tezda_task/app/shared/presentation/widgets/loader.dart';
import 'package:tezda_task/core/framework/theme/colors/app_theme_provider.dart';

import '../../../../../core/navigation/navigator.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../shared/helpers/classes/preferences/preferences.dart';
import '../../../../shared/helpers/classes/preferences/preferences_strings.dart';
import '../../../../shared/presentation/widgets/tezda_task_icon.dart';
import '../../../profile/presentation/pages/profile_page.dart';

class ProductsPage extends ConsumerStatefulWidget {
  const ProductsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductsPageState();
}

class _ProductsPageState extends ConsumerState<ProductsPage> {
  @override
  void initState() {
    onInit(
          () {
        getProducts();
      },
    );
    super.initState();
  }

  void getProducts() {
    final notifier = ref.read(getProductsProvider.notifier);
    notifier.getProducts();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final colors = ref.read(appThemeProvider).colors;
    final topMargin = MediaQuery.of(context).padding.top;
    final productsState = ref.watch(getProductsProvider);
    return Scaffold(
      backgroundColor: colors.alwaysBlack,
      key: const Key("product_page"),
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: tezda_taskIcon(
            icon: Icons.person_rounded,
            key: const Key("profileButton"),
            onTap: () {
              pushTo(context, const ProfilePage());
            },
          ),
        ),
        title: Text(
          "Platzi Products",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            fontFamily: 'DM Sans',
            color: colors.alwaysBlack,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 8),
        child: productsState.when(
          initial: () {
            return const SizedBox();
          },
          loading: () {
            return Center(child: Loader.large());
          },
          success: (products) {
            return GridView.builder(
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: (){
                    pushTo(context, ProductDetailsPage(productData: products[index]));
                  },
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(23),
                          side: BorderSide(
                            width: 0.2,
                            color: colors.alwaysBlack.withOpacity(0.5),
                          ),
                        ),
                        child: Container(
                            padding: const EdgeInsets.only(
                              left: 15,
                              right: 15,
                              top: 13.15,
                              bottom: 15,
                            ),
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(23),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(23),
                                      ),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(23),
                                      ),
                                      child: (products[index].images ?? []).isNotEmpty
                                          ? CachedNetworkImage(
                                          imageUrl: (products[index].images ?? []).first ?? "",
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
                                          errorWidget: (context, url, error) => Image.asset(
                                            Assets.images.noProductImage.path,
                                            height: 100,
                                            width: 100,
                                          ))
                                          : Image.asset(
                                        Assets.images.noProductImage.path,
                                        // height: 45,
                                        // width: 45,
                                      ),
                                    ),
                                  ),
                                ),
                                const Gap(10),
                                Expanded(
                                  child: Text(
                                    "${products[index].title}",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'DM Sans',
                                      fontWeight: FontWeight.w700,
                                      color: colors.always1d1a20
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "\$${products[index].price}",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'DM Sans',
                                        fontWeight: FontWeight.w700,
                                        color: Colors.blueAccent
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ),
                      Positioned(
                        top: 0,
                        right: 5,
                        child: tezda_taskIcon(
                          icon: Icons.favorite_border,
                          key: const Key("profileButton"),
                          color: Colors.red,
                          onTap: () {
                            // Preferences.setModel(
                            //   key: PreferencesStrings.favoriteProducts,
                            //   model: products[index],
                            // );
                          },
                        ),
                      )
                    ],
                  ),
                );
              },
              itemCount: products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.8,
                crossAxisSpacing: 22.0,
                mainAxisSpacing: 12.0,
                crossAxisCount: mediaQuery.width > 650 ? 4 : 2,
              ),
            );
          },
          error: (message) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  message,
                  style: TextStyle(
                    color: colors.alwaysWhite,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 20),
                CustomButton(
                  text: "Retry",
                  onPressed: getProducts,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
