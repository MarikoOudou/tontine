// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'service_momo_cubit.dart';

@immutable
abstract class ServiceMomoState {}

class ServiceMomoInitial extends ServiceMomoState {}

class ServiceMomoError extends ServiceMomoState {
  dynamic message;
  ServiceMomoError({
    required this.message,
  });
}

class ServiceMomoLoading extends ServiceMomoState {}

class ServiceMomoSuccess extends ServiceMomoState {
  dynamic data;
  ServiceMomoSuccess({
    required this.data,
  });
}

// class ServiceMomoSuccess extends ServiceMomoState {}
