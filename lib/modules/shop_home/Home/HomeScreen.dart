import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Models/CategoryModel.dart';
import 'package:shop_app/Models/HomeModel.dart';
import 'package:shop_app/modules/shop_home/Cubit/HomeCubit.dart';
import 'package:shop_app/modules/shop_home/Cubit/HomeStates.dart';
import 'package:shop_app/style/color.dart';
import '../../../component/component.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubitObject = HomeCubit.get(context);
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) => {
        if (state is ShopFavoriteSuccessState)
          {
            if (!state.changeFavoriteModel.status!)
              {showToast(msg: state.changeFavoriteModel.message!)}
          }
      },
      builder: (context, state) {
        return ConditionalBuilder(
            condition: cubitObject.homeModel != null &&
                cubitObject.categoryModel != null,
            builder: (context) => ProductsBuilder(
                cubitObject.homeModel!, cubitObject.categoryModel!, context),
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()));
      },
    );
  }

  Widget ProductsBuilder(HomeModel model, CategoryModel catmodel, context) =>
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
                // items: model.data!.banners.map((e) => Image(
                //   image:
                //   NetworkImage("${e.image}") ,
                //   width: double.infinity,
                //   fit: BoxFit.cover,
                // )).toList(),

                items: const [
                  Image(
                    image: AssetImage("lib/assets/images/onboarding1.jpg"),
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Image(
                    image: AssetImage("lib/assets/images/shopping1.png"),
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ],
                options: CarouselOptions(
                    height: 200,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    scrollDirection: Axis.horizontal,
                    autoPlayCurve: Curves.easeInOut,
                    viewportFraction: 1)),
            const SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(
                start: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Categories ",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  //Build List

                  Container(
                    height: 100,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) =>
                            BuildCategoryItem(catmodel.data!.data[index]),
                        separatorBuilder: (context, index) => const SizedBox(
                              width: 10,
                            ),
                        itemCount: catmodel.data!.data.length),
                  ),

                  const SizedBox(
                    height: 22.0,
                  ),
                  const Text(
                    "New Products ",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
                childAspectRatio: 1 / 1.97,
                children: List.generate(
                    model.data!.products.length,
                    (index) => BuildGridViewItem(
                        model.data!.products[index], context)),
              ),
            )
          ],
        ),
      );

  Widget BuildGridViewItem(ProductModel productModel, context) => Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(alignment: Alignment.bottomLeft, children: [
              Image(
                image: NetworkImage("${productModel.image}"),
                width: double.infinity,
                height: 200,
              ),
              if (productModel.discount != 0)
                Container(
                    color: Colors.red,
                    child: const Text(
                      "DISCOUNT",
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    ))
            ]),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${productModel.name}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(),
                  ),
                  Row(
                    children: [
                      Text(
                        "${productModel.price.round()}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style:
                            const TextStyle(fontSize: 14, color: defaultColor),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      if (productModel.discount != 0)
                        Text(
                          "${productModel.oldPrice.round()}",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                        ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          HomeCubit.get(context)
                              .changeFavoriteItem(productModel.id!);
                          // HomeCubit.get(context).changeFavoriteItem();
                          print(productModel.id!);
                        },
                        icon: CircleAvatar(
                          radius: 12,
                          backgroundColor:
                              HomeCubit.get(context).favorite[productModel.id!]!
                                  ? defaultColor
                                  : Colors.grey[400],
                          child: const Icon(
                            Icons.favorite_border,
                            size: 14,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget BuildCategoryItem(CategoryItemDataModel model) => Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(
            image: NetworkImage(model.image!),
            fit: BoxFit.cover,
            width: 100,
            height: 100,
          ),
          Container(
              width: 100,
              alignment: Alignment.bottomCenter,
              color: Colors.black.withOpacity(.6),
              height: 30,
              child: Text(
                model.name!,
                maxLines: 1,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  overflow: TextOverflow.ellipsis,
                ),
              )),
        ],
      );
}
