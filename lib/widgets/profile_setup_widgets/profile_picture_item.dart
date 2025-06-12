import 'package:flutter/material.dart';
import '../../themes/firefly_theme.dart';
import '../../data/profile_pictures_data.dart';

class ProfilePictureItem extends StatelessWidget {
  final String picture;
  final bool isSelected;
  final VoidCallback onTap;

  const ProfilePictureItem({
    super.key,
    required this.picture,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? FireflyTheme.turquoise : Colors.transparent,
            width: 3,
          ),
        ),
        child: CircleAvatar(
          radius: 40,
          backgroundColor: Colors.transparent,
          backgroundImage: AssetImage(ProfilePicturesData.getProfilePicturePath(picture)),
        ),
      ),
    );
  }
}