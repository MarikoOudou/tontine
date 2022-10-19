// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'app_cubit.dart';

@immutable
abstract class AppState {}

class AppInitial extends AppState {}

class AppLoading extends AppState {}

class AppError extends AppState {}

class AppDepot extends AppState {
  dynamic message;
  AppDepot({
    required this.message,
  });
}

class AppLogin extends AppState {
  Map<String, dynamic> data;
  AppLogin({
    required this.data,
  });
}

class AppSingUp extends AppState {}

class AppUserInfo extends AppState {
  final User user;
  // Map<String, dynamic> historiquesr;
  AppUserInfo({
    required this.user,
    // required this.historiquesr,
  }) {
    ServiceHttp().setTel(user.tel);
  }
}

class AppHistorique extends AppState {
  // final User user;
  Map<String, dynamic> historique;
  AppHistorique({
    // required this.user,
    required this.historique,
  });
}

class AppCreateTontine extends AppState {}
