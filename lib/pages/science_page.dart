import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cubit.dart';
import '../bloc/states.dart';
import '../components/News_item.dart';
import '../components/myseparator.dart';

class Science extends StatelessWidget {
  const Science({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit , NewsStates>(
        listener: ( context,  state) {  },
        builder: ( context, state) {
          var list = NewsCubit.get(context).science;
          if (state is NewsGetSearchLoadingState) {
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
