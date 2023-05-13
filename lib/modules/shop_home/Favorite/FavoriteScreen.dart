import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/component/component.dart';
import 'package:shop_app/modules/shop_home/Cubit/HomeCubit.dart';
import 'package:shop_app/modules/shop_home/Cubit/HomeStates.dart';

import '../../../Models/FavoriteDataModel.dart';
import '../../../style/color.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubitobj = HomeCubit.get(context);
        return Scaffold(
          body: ConditionalBuilder(
              condition: state is! ShopFavoriteLoadingState &&
                  cubitobj.favoriteModel != null,
              builder: (context) => ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => BuildFavoriteScreenItem(
                        cubitobj.favoriteModel!.data!.data[index]
                            .favoriteProductDataModel!,
                        context),
                    separatorBuilder: (context, index) => myDivider(),
                    itemCount: cubitobj.favoriteModel!.data!.data.length,
                  ),
              fallback: (context) =>
                  const Center(child: CircularProgressIndicator())),
        );
      },
    );
  }

  Widget BuildFavoriteScreenItem(ProductDataModel model, context) => Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          height: 150,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(alignment: Alignment.bottomLeft, children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image(
                    image: NetworkImage(model.image!),
                    width: 150,
                    height: 150,
                  ),
                ),
                if (model.discount != 0)
                  Container(
                      color: Colors.red,
                      child: const Text(
                        "DISCOUNT",
                        style: TextStyle(fontSize: 10, color: Colors.white),
                      ))
              ]),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      model.name!,
                      maxLines: 2,
                      style: const TextStyle(
                          height: 1.6,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          overflow: TextOverflow.ellipsis),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Text(
                          "${model.price}",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 14, color: defaultColor),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        if (model.discount != 0)
                          Text(
                            "${model.oldPrice}",
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
                                .changeFavoriteItem(model.id!);
                          },
                          icon: CircleAvatar(
                            radius: 12,
                            backgroundColor:
                                HomeCubit.get(context).favorite[model.id!]!
                                    ? defaultColor
                                    : Colors.grey[400],
                            child: Icon(
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
        ),
      );
}
