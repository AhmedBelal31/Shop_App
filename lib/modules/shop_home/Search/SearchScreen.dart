import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Models/SearchModel.dart';
import 'package:shop_app/component/component.dart';
import 'package:shop_app/modules/shop_home/Cubit/HomeCubit.dart';
import 'package:shop_app/modules/shop_home/Cubit/HomeStates.dart';

import '../../../Models/FavoriteDataModel.dart';
import '../../../Models/SearchModel.dart';
import '../../../Models/SearchModel.dart';
import '../../../style/color.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var searchContrller = TextEditingController();
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubitobj = HomeCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    TextFormField(
                      key: formKey,
                      controller: searchContrller,
                      onChanged: (value) {
                        cubitobj.searchInProductData(text: value);
                      },
                      onFieldSubmitted: (String value) {
                        cubitobj.searchInProductData(text: value);
                      },
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search),
                          labelText: "Search",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12))),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    if (state is ShopSearchLoadingState)
                      const LinearProgressIndicator(),
                    const SizedBox(
                      height: 20,
                    ),
                    if (state is ShopSearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) =>
                              BuildSearchScreenItem(
                                  cubitobj.searchModel!.data!.data[index],
                                  context),
                          separatorBuilder: (context, index) => myDivider(),
                          itemCount: cubitobj.searchModel!.data!.data.length,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget BuildSearchScreenItem(SearchDataItemModel model, context) => Padding(
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
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            HomeCubit.get(context)
                                .changeFavoriteItem(model.id!);
                          },
                          icon: CircleAvatar(
                            radius: 12,
                            backgroundColor: defaultColor,
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
        ),
      );
}
