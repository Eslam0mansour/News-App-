import 'package:best_news/bloc/states.dart';
import 'package:best_news/network/Dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/cubit.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit , NewsStates>(
      listener: ( context,  state) {},
      builder: ( context, state) {
        var appCubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(

            title: const Text(
                'News app '
            ),
            actions: [
              IconButton(
                  onPressed: (){
                    Navigator.pushNamed(context, 'Search');
                  },
                  icon: const Icon(
                    Icons.search,
                  )
              ),
              IconButton(
                  onPressed: (){
                    appCubit.changemode();
                  },
                  icon: const Icon(
                    Icons.dark_mode_outlined,
                  )
              ),
            ],
          ),
          body: appCubit.screens[appCubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index){
              appCubit.changebottomnavnbar(index);
            },
            currentIndex: appCubit.currentIndex,
            items: appCubit.bottomItem,
          ),
        );
      },
    );
  }
}
