import 'package:best_news/bloc/cubit.dart';
import 'package:best_news/bloc/states.dart';
import 'package:best_news/components/News_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/myseparator.dart';

class Business extends StatelessWidget {
  const Business({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit , NewsStates>(
      listener: ( context,  state) {  },
      builder: ( context, state) {
        var list = NewsCubit.get(context).business;
        if (state is NewsGetBusinessLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
        else {
            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              separatorBuilder: (BuildContext context, int index)
              => separator(),
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index)
              => NewsItem(list: list[index]),
            );
          }
      }

    );

  }
}
