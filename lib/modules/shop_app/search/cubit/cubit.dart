import 'package:ayop01/models/shop_login_models/seach_models.dart';
import 'package:ayop01/modules/shop_app/search/cubit/states.dart';
import 'package:ayop01/shared/components/constants.dart';
import 'package:ayop01/shared/network/end_point.dart';
import 'package:ayop01/shared/network/remote/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitalState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModels? searchModels;



  void search(String text) {
    emit(SearchLoadingState());
    DioHelper.postData(url: SEARCH, token: token, data: {
      'text': text,
    }).then((value) {
      searchModels =SearchModels.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((e) {
      emit(SearchErrorState());
    });
  }
}
