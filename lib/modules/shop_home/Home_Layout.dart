import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/component/component.dart';
import 'package:shop_app/modules/shop_home/Categories/CategoriesScreen.dart';
import 'package:shop_app/modules/shop_home/Cubit/HomeCubit.dart';
import 'package:shop_app/modules/shop_home/Favorite/FavoriteScreen.dart';
import 'package:shop_app/modules/shop_home/Settings/SettingsScreen.dart';
import 'package:shop_app/style/color.dart';
import 'Cubit/HomeStates.dart';
import 'Home/HomeScreen.dart';
import 'Search/SearchScreen.dart';

class Home_Layout extends StatelessWidget {
  List<Widget> screens = const [
    HomeScreen(),
    CategoriesScreen(),
    FavoriteScreen(),
    SettingsScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()
        ..getDataFromHomeModel()
        ..getDataFromCategoryModel()
        ..getFavoriteData()
        ..getProfileData(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubitObject = HomeCubit.get(context);
          return SafeArea(
            child: Scaffold(
                appBar: AppBar(
                  title: const Text(
                    "Salla ",
                    style: TextStyle(fontSize: 25, color: defaultColor),
                  ),
                  actions: [
                    IconButton(
                        onPressed: () {
                          NavigateTo(context, SearchScreen());
                        },
                        icon: const Icon(Icons.search))
                  ],
                ),
                bottomNavigationBar: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  currentIndex: cubitObject.currentIndex,
                  onTap: (value) {
                    cubitObject.changeBottomNavBarIndex(value);
                  },
                  items: const [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home), label: "Home"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.apps), label: "Categories"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.favorite), label: "Favorite"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.settings), label: "Settings"),
                  ],
                ),
                body: screens[cubitObject.currentIndex]),
          );
        },
      ),
    );
  }
}
