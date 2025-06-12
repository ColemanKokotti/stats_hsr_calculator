import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/ProfileEdit_Cubit/profile_edit_cubit.dart';
import '../../../bloc/ProfileEdit_Cubit/profile_edit_state.dart';
import '../../../bloc/Profile_Cubit/profile_cubit.dart';
import '../../../bloc/Profile_Cubit/profile_state.dart';
import '../../../themes/firefly_theme.dart';
import 'section_card.dart';

class EditProfilePictureSection extends StatefulWidget {
  const EditProfilePictureSection({super.key});

  @override
  State<EditProfilePictureSection> createState() => _EditProfilePictureSectionState();
}

class _EditProfilePictureSectionState extends State<EditProfilePictureSection> {
  bool _isExpanded = false;
  String _selectedImage = '';
  int _currentPage = 0;
  final int _itemsPerPage = 6; // 3x2 grid
  
  // List of available profile pictures
  final List<String> _profilePictures = [
    'Profile_Picture_March_7th_-_Welcome.webp',
    'Profile_Picture_Himeko_-_Welcome.webp',
    'Profile_Picture_Dan_Heng_-_Welcome.webp',
    'Profile_Picture_Welt_-_Welcome.webp',
    'Profile_Picture_Bronya_-_Celebration.webp',
    'Profile_Picture_Gepard_-_Celebration.webp',
    'Profile_Picture_Kafka_-_Dinner_Party.webp',
    'Profile_Picture_Blade_-_Dinner_Party.webp',
    'Profile_Picture_Jingliu_-_Odyssey.webp',
    'Profile_Picture_Yanqing_-_Odyssey.webp',
    'Profile_Picture_Fu_Xuan_-_In_Leisure.webp',
    'Profile_Picture_Jing_Yuan_-_In_Leisure.webp',
    'Profile_Picture_Firefly_-_Vision.webp',
    'Profile_Picture_Caelus_-_Welcome.webp',
    'Profile_Picture_Stelle_-_Welcome.webp',
    'Profile_Picture_Acheron_-_Ambush.webp',
    'Profile_Picture_Anaxa_-_Ingenuity.webp',
    'Profile_Picture_Aventurine_-_Bullseye.webp',
    'Profile_Picture_Bailu_-_Medical_Practice.webp',
    'Profile_Picture_Ball_Bat_by_Name.webp',
    'Profile_Picture_Boothill_-_Ambush.webp',
    'Profile_Picture_Brother_Hanu.webp',
    'Profile_Picture_Caelus_-_Star_Rail.webp',
    'Profile_Picture_Castorice_-_Ingenuity.webp',
    'Profile_Picture_Chef_Pom-Pom.webp',
    'Profile_Picture_Cipher_-_Sweet_Slumber.webp',
    'Profile_Picture_Clockie.webp',
    'Profile_Picture_Diting.webp',
    'Profile_Picture_Dr._Ratio_-_Academia.webp',
    'Profile_Picture_Dream_Ticker.webp',
    'Profile_Picture_Feixiao_-_Fitness.webp',
    'Profile_Picture_Hamster_Ball_Knight.webp',
    'Profile_Picture_Herta_-_Tea_Break.webp',
    'Profile_Picture_Hi_Come_for_a_Test.webp',
    'Profile_Picture_Hyacine_-_Sweet_Slumber.webp',
    'Profile_Picture_Janus_Steed.webp',
    'Profile_Picture_Jiaoqiu_-_Medical_Practice.webp',
    'Profile_Picture_Junjun.webp',
    'Profile_Picture_Kakavasha.webp',
    'Profile_Picture_March_7th_-_Festival.webp',
    'Profile_Picture_Moze_-_Fitness.webp',
    'Profile_Picture_Mydei_-_Delicacies.webp',
    'Profile_Picture_One-Year_Anniversary_Commemoration.webp',
    'Profile_Picture_Origami_Bird.webp',
    'Profile_Picture_Owlbert_-_Bath.webp',
    'Profile_Picture_Peppy.webp',
    'Profile_Picture_Polyxia.webp',
    'Profile_Picture_Rappa_-_Opening.webp',
    'Profile_Picture_Robin_-_Brilliant_Youth.webp',
    'Profile_Picture_Ruan_Mei_-_Academia.webp',
    'Profile_Picture_SAM_-_Vision.webp',
    'Profile_Picture_Sampo_-_Illusion.webp',
    'Profile_Picture_Silver_Wolf_-_Opening.webp',
    'Profile_Picture_Snack_Life.webp',
    'Profile_Picture_Sparkle_-_Illusion.webp',
    'Profile_Picture_Sparkle_Doll.webp',
    'Profile_Picture_Spirithief.webp',
    'Profile_Picture_Stelle_-_Star_Rail.webp',
    'Profile_Picture_Sunday_-_Brilliant_Youth.webp',
    'Profile_Picture_The_Herta_-_Tea_Break.webp',
    'Profile_Picture_Topaz_-_Bullseye.webp',
    'Profile_Picture_Trash_Can.webp',
    'Profile_Picture_Trianne_Doll.webp',
    'Profile_Picture_Tribbie_-_Delicacies.webp',
    'Profile_Picture_Wanted_Poster.webp',
    'Profile_Picture_Wubbaboo.webp',
    'Profile_Picture_Yanqing_-_Dreamland.webp',
    'Profile_Picture_You_Can_t_See_Me.webp',
  ];

  // Get total number of pages
  int get _totalPages => (_profilePictures.length / _itemsPerPage).ceil();

  // Get current page items
  List<String> _getCurrentPageItems() {
    final startIndex = _currentPage * _itemsPerPage;
    final endIndex = startIndex + _itemsPerPage > _profilePictures.length
        ? _profilePictures.length
        : startIndex + _itemsPerPage;
    
    return _profilePictures.sublist(startIndex, endIndex);
  }

  // Navigate to next page
  void _nextPage() {
    if (_currentPage < _totalPages - 1) {
      setState(() {
        _currentPage++;
      });
    }
  }

  // Navigate to previous page
  void _previousPage() {
    if (_currentPage > 0) {
      setState(() {
        _currentPage--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, profileState) {
        // Get current profile picture if available
        if (profileState is ProfileLoaded && 
            profileState.profile.profilePicture != null && 
            _selectedImage.isEmpty) {
          // Extract just the filename if it's a full path
          String currentPicture = profileState.profile.profilePicture!;
          if (currentPicture.contains('assets/profile_images/')) {
            currentPicture = currentPicture.replaceAll('assets/profile_images/', '');
          }
          _selectedImage = currentPicture;
        }

        return SectionCard(
          title: 'Profile Picture',
          icon: Icons.image,
          isExpanded: _isExpanded,
          onToggle: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          expandedContent: BlocConsumer<ProfileEditCubit, ProfileEditState>(
            listener: (context, state) {
              if (state is ProfileEditSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
                // Reset state after showing success message
                context.read<ProfileEditCubit>().resetState();
                // Close the expanded section
                setState(() {
                  _isExpanded = false;
                });
              } else if (state is ProfileEditError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            builder: (context, state) {
              final currentItems = _getCurrentPageItems();
              
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select a new profile picture:',
                    style: TextStyle(
                      color: FireflyTheme.white,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Grid of profile pictures (3x2)
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: currentItems.length,
                    itemBuilder: (context, index) {
                      final imagePath = currentItems[index];
                      final isSelected = _selectedImage == imagePath;
                      
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedImage = imagePath;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected ? FireflyTheme.gold : Colors.transparent,
                              width: 3,
                            ),
                            boxShadow: [
                              if (isSelected)
                                BoxShadow(
                                  color: FireflyTheme.gold.withOpacity(0.5),
                                  blurRadius: 8,
                                  spreadRadius: 2,
                                ),
                            ],
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              'assets/profile_images/$imagePath',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: FireflyTheme.jacket,
                                  child: Icon(
                                    Icons.broken_image,
                                    color: FireflyTheme.white,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
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
                        onPressed: _currentPage > 0 ? _previousPage : null,
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: _currentPage > 0
                              ? FireflyTheme.turquoise
                              : FireflyTheme.turquoise.withOpacity(0.3),
                        ),
                      ),
                      
                      // Page indicator
                      Text(
                        'Page ${_currentPage + 1} of $_totalPages',
                        style: TextStyle(
                          color: FireflyTheme.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      
                      // Next page button
                      IconButton(
                        onPressed: _currentPage < _totalPages - 1 ? _nextPage : null,
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          color: _currentPage < _totalPages - 1
                              ? FireflyTheme.turquoise
                              : FireflyTheme.turquoise.withOpacity(0.3),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: state is ProfileEditLoading || _selectedImage.isEmpty
                          ? null
                          : _updateProfilePicture,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        backgroundColor: FireflyTheme.turquoise,
                      ),
                      child: state is ProfileEditLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text('Update Profile Picture'),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  void _updateProfilePicture() {
    if (_selectedImage.isNotEmpty) {
      // Add the full path to the profile picture
      final fullPath = 'assets/profile_images/$_selectedImage';
      context.read<ProfileEditCubit>().updateProfilePicture(fullPath);
    }
  }
}