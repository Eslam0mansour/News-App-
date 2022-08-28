import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cubit.dart';
import '../bloc/states.dart';
import '../components/News_item.dart';
import '../components/myseparator.dart';

class Sports extends StatelessWidget {
  const Sports({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit , NewsStates>(
        listener: ( context,  state) {  },
        builder: ( context, state) {
          var list = NewsCubit.get(context).sports;
          if (state is NewsGetSportsLoadingState) {
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
