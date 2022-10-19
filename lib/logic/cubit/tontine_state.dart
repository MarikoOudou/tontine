// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'tontine_cubit.dart';

@immutable
abstract class TontineState {}

class TontineInitial extends TontineState {}

class TontineError extends TontineState {}

class TontineLoading extends TontineState {}

class TontineCreate extends TontineState {
  ModelReponse dataInfo;
  TontineCreate({
    required this.dataInfo,
  });
}

class TontineListe extends TontineState {
  List<dynamic> tontines;
  TontineListe({
    required this.tontines,
  });
}
