import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/ProfilePicture_Cubit/profile_picture_cubit.dart';
import '../../bloc/ProfilePicture_Cubit/profile_picture_state.dart';
import '../../themes/firefly_theme.dart';
import 'profile_picture_item.dart';

class ProfilePictureGrid extends StatelessWidget {
  const ProfilePictureGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfilePictureCubit, ProfilePictureState>(
      builder: (context, state) {
        final currentItems = context.read<ProfilePictureCubit>().getCurrentPageItems();
        
        return Column(
          children: [
            // Grid of profile pictures
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: currentItems.length,
              itemBuilder: (context, index) {
                final picture = currentItems[index];
                return ProfilePictureItem(
                  picture: picture,
                  isSelected: picture == state.selectedProfilePicture,
                  onTap: () => context.read<ProfilePictureCubit>().selectProfilePicture(picture),
                );
              },
            ),
            
            const SizedBox(height: 16),
            
            // Pagination controls
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Previous page button
                IconButton(
                  onPressed: state.currentPage > 0
                      ? () => context.read<ProfilePictureCubit>().previousPage()
                      : null,
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: state.currentPage > 0
                        ? FireflyTheme.turquoise
                        : FireflyTheme.turquoise.withOpacity(0.3),
                  ),
                ),
                
                // Page indicator
                Text(
                  'Page ${state.currentPage + 1} of ${state.totalPages}',
                  style: TextStyle(
                    color: FireflyTheme.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                // Next page button
                IconButton(
                  onPressed: state.currentPage < state.totalPages - 1
                      ? () => context.read<ProfilePictureCubit>().nextPage()
                      : null,
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    color: state.currentPage < state.totalPages - 1
                        ? FireflyTheme.turquoise
                        : FireflyTheme.turquoise.withOpacity(0.3),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}