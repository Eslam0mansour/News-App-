import 'package:best_news/bloc/states.dart';
import 'package:best_news/network/Dio.dart';
import 'package:best_news/network/cache_helper.dart';
import 'package:best_news/pages/business_page.dart';
import 'package:best_news/pages/sports_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../pages/science_page.dart';
import '../pages/settings_page.dart';

class NewsCubit extends Cubit<NewsStates>
{
  NewsCubit (): super (NewsInitialState());
  static NewsCubit get(context) => BlocProvider.of(context);
  var searchController = TextEditingController();

   int currentIndex = 0 ;
  List<BottomNavigationBarItem> bottomItem = [
    const BottomNavigationBarItem(
      label: 'business',
      icon: Icon(
        Icons.business,
      ),
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.sports_baseball_outlined,
      ),
      label: 'sports',

    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.science,
      ),
      label: 'science',

    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.settings,
      ),
      label: 'settings',

    ),
  ];
  List<Widget> screens = [
    const Business(),
    const Sports(),
    const Science(),
    const Settings(),
  ];
  void changebottomnavnbar (int index)
  {
    currentIndex = index ;
    emit(NewsbtnnavState());

    if (index == 1) {
      getSport();
    } else if (index==2) {
        getScience();
      }
  }
  List<dynamic> business = [];
void getBusiness ()
{
  emit(NewsGetBusinessLoadingState());

  DioHelper.getDate(url: 'v2/top-headlines',
      query: {
        'country':'eg',
        'category':'business',
        'apiKey':'be59d8d000724ce3b35e232d9de19393',
      }
  ).then((value) {
               business = value.data['articles'];
               print(business[0]['title']);
               emit(NewsGetBusinessSuccessState());
  }).catchError((error){
    emit(NewsGetBusinessErrorState(error.toString()));
    print(error.toString());
  });
}
  List<dynamic> sports = [];
  void getSport ()
  {
    emit(NewsGetSportsLoadingState());

    DioHelper.getDate(url: 'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'sports',
          'apiKey':'be59d8d000724ce3b35e232d9de19393',
        }
    ).then((value) {
      sports = value.data['articles'];
      print(sports[0]['title']);
      emit(NewsGetSportsSuccessState());
    }).catchError((error){
      emit(NewsGetSportsErrorState(error.toString()));
      print(error.toString());
    });
  }
  List<dynamic> science = [];
  void getScience ()
  {
    emit(NewsGetScienceLoadingState());

    DioHelper.getDate(url: 'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'science',
          'apiKey':'be59d8d000724ce3b35e232d9de19393',
        }
    ).then((value) {
      science = value.data['articles'];
      print(science[0]['title']);
      emit(NewsGetScienceSuccessState());
    }).catchError((error){
      emit(NewsGetScienceErrorState(error.toString()));
      print(error.toString());
    });
  }

  List<dynamic> search = [];
  void getSearch (String value)
  {
    emit(NewsGetSearchLoadingState());

    DioHelper.getDate(url: 'v2/everything',
        query: {
          'q':'$value',
          'apiKey':'be59d8d000724ce3b35e232d9de19393',
        }
    ).then((value) {
      search = value.data['articles'];
      print(search[0]['title']);
      emit(NewsGetSearchSuccessState());
    }).catchError((error){
      emit(NewsGetSearchErrorState(error.toString()));
      print(error.toString());
    });
  }

  bool isDark = false ;
  void changemode({bool? fromShared})
  {
    if(fromShared != null) {
      isDark = fromShared ;
      emit(NewsChangeModeState());

    } else {
      isDark = !isDark;
      CachHelper.put(key: 'isDark', value: isDark ).then((value) {
        emit(NewsChangeModeState());
      });
    }

  }

  }












