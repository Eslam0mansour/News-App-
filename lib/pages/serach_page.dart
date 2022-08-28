import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/cubit.dart';
import '../bloc/states.dart';
import '../components/News_item.dart';
import '../components/myseparator.dart';

class Search extends StatelessWidget {
   Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit , NewsStates>(
        listener: ( context,  state) {  },
        builder: ( context, state) {

          var list = NewsCubit.get(context).search;

      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              size: 30, color: Colors.black,
            ),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 10,
                  right: 10
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    5.0,
                  ),
                  border: Border.all(
                    color: Colors.grey,
                  ),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 15.0,
                ),
                child: TextFormField(
                  controller: NewsCubit
                      .get(context)
                      .searchController,
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    NewsCubit.get(context).getSearch(value);
                  },
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ConditionalBuilder(
              condition: list.isNotEmpty,
              fallback: (BuildContext context) {
                return Center(child: CircularProgressIndicator());
              },
              builder: (BuildContext context) {
                return Expanded(
                  child: ListView.separated(
                    separatorBuilder: (BuildContext context, int index) =>
                        separator(),
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, int index) =>
                        NewsItem(list: list[index]),
                  ),
                );
              },

            ),
          ],
        ),
      );
    }
    );
  }
}
