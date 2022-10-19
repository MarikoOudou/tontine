import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tontino/logic/cubit/app_cubit.dart';
import 'package:tontino/models/MomoService.dart';

part 'service_momo_state.dart';

class ServiceMomoCubit extends Cubit<ServiceMomoState> {
  ServiceMomoCubit() : super(ServiceMomoInitial());

  MomoService _momoService = MomoService();

  rechargement(int montant) {
    emit(ServiceMomoLoading());

    _momoService.rechargement(montant).then((value) {
      print("VALEUR SERVEUR $value");
      if (value["code"] != 200 && value["code"] != 201) {
        emit(ServiceMomoError(message: value));
      } else if (value["code"] == 200 || value["code"] == 201) {
        // AppCubit().getHistorique();
        // BlocProvider.value(value: AppCubit());

        emit(ServiceMomoSuccess(data: value));
      }
    });
  }

  retrait(int montant) {
    emit(ServiceMomoLoading());

    _momoService.retrait(montant).then((value) {
      print("VALEUR SERVEUR $value");
      if (value["code"] != 200 && value["code"] != 201) {
        emit(ServiceMomoError(message: value));
      } else if (value["code"] == 200 || value["code"] == 201) {
        emit(ServiceMomoSuccess(data: value));
      }
    });
  }
}
