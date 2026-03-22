import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty_characters/core/constants/app_colors.dart';
import 'package:rick_and_morty_characters/core/constants/app_styles.dart';
import 'package:rick_and_morty_characters/core/shared/domain/entities/character_entity.dart';

class CharacterCard extends StatelessWidget {
  const CharacterCard({
    super.key,
    required this.character,
    required this.onFavoriteTap,
    required this.isFavorite,
  });

  final CharacterEntity character;
  final bool isFavorite;
  final VoidCallback onFavoriteTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.lPurple,
      ),
      child: Row(
        children: [
          CachedNetworkImage(
            imageUrl: character.imagUrl,
            width: 80,
            height: 80,
            fit: BoxFit.cover,
            placeholder: (context, url) => const SizedBox(
              width: 80,
              height: 80,
              child: Center(child: CircularProgressIndicator.adaptive()),
            ),
            errorWidget: (context, url, error) => const SizedBox(
              width: 80,
              height: 80,
              child: Center(child: Icon(Icons.broken_image)),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Text(
                    character.name,
                    overflow: TextOverflow.ellipsis,
                    style: AppStyles.headerH4.copyWith(color: AppColors.grey),
                  ),
                ),
                Text(
                  character.gender.name,
                  style: AppStyles.body2.copyWith(color: AppColors.grey),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onFavoriteTap,
            icon: Icon(isFavorite ? Icons.star : Icons.star_border),
          ),
        ],
      ),
    );
  }
}
