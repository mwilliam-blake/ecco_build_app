import 'dart:convert';

import 'package:ecco_build/data/remote/api/app_exception.dart';
import 'package:ecco_build/ui/screens/bloc/register/register_event.dart';
import 'package:ecco_build/ui/screens/bloc/register/register_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/remote/api/api_helper.dart';
import '../../../../data/remote/api/url_helper.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {

  ApiHelper apiHelper;
  RegisterBloc({required this.apiHelper}):super(RegisterInitialState()) {
    on<RegisterUserEvent>((event, emit) async {
      emit(RegisterLoadingState());
        try {
              dynamic res = await apiHelper.postAPI(url: Urls.RegAPIUrl, bodyParams: {
            "fname": event.fname,
            "lname": event.lname,
            "username": event.uname,
            "email": event.email,
            "phone": event.mobNo,
            "position": event.position,
            "primary": event.pTrade,
            "secondary": event.sTrade,
            "third": event.tTrade,
            "agency_name": event.client,
            "comments": event.notes,
          });


          if (res['status']==200) {
            emit(RegisterLoadedState());
          } else {
            print("issue");
            emit(RegisterErrorState(errorMsg: res['message']));
          }
        } catch (e) {
          print("New issue");
          emit(RegisterErrorState(errorMsg: (e as AppExceptions).toErrorMsg()));
        }

    });
  }
}