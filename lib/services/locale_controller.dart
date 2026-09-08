import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit({Locale? initialLocale})
    : super(initialLocale ?? const Locale('en'));

  Future<void> setLanguage(String languageCode) async {
    if (state.languageCode == languageCode) return;

    emit(Locale(languageCode));
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString('language_code', languageCode);
  }
}