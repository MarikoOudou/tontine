import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:tontino/models/MomoService.dart';
import 'package:tontino/models/user.dart';
import 'package:tontino/services/ServiceHttp.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  User _userRepositorie = User();
  MomoService _momoService = MomoService();

  AppCubit() : super(AppInitial()) {
    getInfoUser();
    getHistorique();
  }

  rechargement(int montant) {
    emit(AppLoading());

    _momoService.rechargement(montant).then((value) {
      print("VALEUR SERVEUR $value");
      if (value["code"] != 200 && value["code"] != 201) {
        emit(AppError());
      } else if (value["code"] == 200 || value["code"] == 201) {
        emit(AppDepot(message: value));
      }
    });
  }

  login(User user) {
    _userRepositorie = user;
    emit(AppLoading());
    _userRepositorie
        .login(
            telephone: _userRepositorie.tel,
            motDpass: _userRepositorie.password)
        .then((value) => {
              if (value["code"] != 200)
                {emit(AppError())}
              else if (value["code"] == 200)
                {emit(AppLogin(data: value))}
            });
  }

  getInfoUser() async {
    if (await ServiceHttp().getToken() != null) {
      emit(AppLoading());
      _userRepositorie.getUser().then((value) {
        if (value["code"] != 200) {
          emit(AppError());
        } else if (value["code"] == 200) {
          emit(AppUserInfo(user: value["data"]));
        }
      });
    }
  }

  getHistorique() async {
    if (await ServiceHttp().getToken() != null) {
      emit(AppLoading());
      _userRepositorie.historique().then((value) => {
            if (value["code"] != 200)
              {emit(AppError())}
            else if (value["code"] == 200)
              {emit(AppHistorique(historique: value))}
          });
    }
  }
}
