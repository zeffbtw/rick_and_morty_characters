import 'package:flutter/material.dart';
import 'package:rick_and_morty_characters/core/constants/app_colors.dart';

abstract final class AppStyles {
  static const TextStyle headerH1 = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.w700,
    height: 44 / 36,
    color: AppColors.white,
  );

  static const TextStyle headerH2 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    height: 40 / 32,
    color: AppColors.white,
  );

  static const TextStyle headerH3 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 32 / 24,
    color: AppColors.white,
  );

  static const TextStyle headerH4 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 28 / 18,
    color: AppColors.white,
  );

  static const TextStyle headerH5 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 24 / 16,
    color: AppColors.white,
  );

  static const TextStyle body1 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 20 / 14,
    color: AppColors.white,
  );

  static const TextStyle body2 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 20 / 12,
    color: AppColors.white,
  );

  static const TextStyle body3 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 20 / 12,
    color: AppColors.white,
  );
}
