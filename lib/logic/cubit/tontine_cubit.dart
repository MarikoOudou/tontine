// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import 'package:tontino/models/Tontine.dart';

part 'tontine_state.dart';

class TontineCubit extends Cubit<TontineState> {
  Tontine _tontineRepositorie = Tontine();

  TontineCubit() : super(TontineInitial());

  createTontine(RegisterModelTontine _registerModel) {
    emit(TontineLoading());

    _tontineRepositorie.create(_registerModel).then((value) {
      if (value.code >= 400) {
        emit(TontineError());
      } else if (value.code == 200 || value.code == 201) {
        emit(TontineCreate(dataInfo: value));
      }
    });
  }
}

class RegisterModelTontine {
  String nom;
  int periodicite;
  int montant;
  int type;
  RegisterModelTontine({
    required this.nom,
    required this.periodicite,
    required this.montant,
    required this.type,
  });

  RegisterModelTontine copyWith({
    String? nom,
    int? periodicite,
    int? montant,
    int? type,
  }) {
    return RegisterModelTontine(
      nom: nom ?? this.nom,
      periodicite: periodicite ?? this.periodicite,
      montant: montant ?? this.montant,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nom': nom,
      'periodicite': periodicite,
      'montant': montant,
      'type': type,
    };
  }

  factory RegisterModelTontine.fromMap(Map<String, dynamic> map) {
    return RegisterModelTontine(
      nom: map['nom'] as String,
      periodicite: map['periodicite'] as int,
      montant: map['montant'] as int,
      type: map['type'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory RegisterModelTontine.fromJson(String source) =>
      RegisterModelTontine.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RegisterModelTontine(nom: $nom, periodicite: $periodicite, montant: $montant, type: $type)';
  }

  @override
  bool operator ==(covariant RegisterModelTontine other) {
    if (identical(this, other)) return true;

    return other.nom == nom &&
        other.periodicite == periodicite &&
        other.montant == montant &&
        other.type == type;
  }

  @override
  int get hashCode {
    return nom.hashCode ^
        periodicite.hashCode ^
        montant.hashCode ^
        type.hashCode;
  }
}
