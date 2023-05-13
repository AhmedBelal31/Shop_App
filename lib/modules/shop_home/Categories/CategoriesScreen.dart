import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Models/HomeModel.dart';
import 'package:shop_app/component/component.dart';
import 'package:shop_app/modules/shop_home/Cubit/HomeCubit.dart';
import 'package:shop_app/modules/shop_home/Cubit/HomeStates.dart';
import '../../../Models/CategoryModel.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cuboj = HomeCubit.get(context);
          return ConditionalBuilder(
            condition: cuboj.categoryModel != null,
            builder: (context) => Padding(
              padding: const EdgeInsetsDirectional.only(top: 20),
              child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) =>
                      BuildCatItem(cuboj.categoryModel!.data!.data[index]),
                  separatorBuilder: (context, index) => myDivider(),
                  itemCount: cuboj.categoryModel!.data!.data.length),
            ),
            fallback: (Context) => Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }

  Widget BuildCatItem(CategoryItemDataModel model) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image(
                image: NetworkImage(model.image!),
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              model.name!,
              maxLines: 1,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios)
          ],
        ),
      );
}
