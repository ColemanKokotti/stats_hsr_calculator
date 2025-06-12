import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../firebase_service/fireabese_service.dart';
import 'favorits_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final FirebaseAuth _auth;
  StreamSubscription? _favoritesSubscription;

  FavoritesCubit({FirebaseAuth? auth}) 
      : _auth = auth ?? FirebaseAuth.instance,
        super(const FavoritesState(favoriteIds: {}, isLoading: true)) {
    // Initialize favorites when the cubit is created
    _initFavorites();
  }

  // Initialize favorites from Firestore
  Future<void> _initFavorites() async {
    try {
      final user = _auth.currentUser;
      
      if (user == null) {
        // User is not authenticated, use empty favorites
        emit(const FavoritesState(favoriteIds: {}, isLoading: false));
        return;
      }
      
      // Subscribe to real-time updates for favorites
      _subscribeToFavorites(user.uid);
    } catch (e) {
      print('Error initializing favorites: $e');
      emit(FavoritesState(
        favoriteIds: state.favoriteIds, 
        isLoading: false,
        error: 'Failed to load favorites: $e',
      ));
    }
  }

  // Subscribe to real-time updates for favorites
  void _subscribeToFavorites(String userId) {
    // Cancel any existing subscription
    _favoritesSubscription?.cancel();
    
    // Subscribe to favorites stream
    _favoritesSubscription = FirebaseService.getUserFavoritesStream(userId)
        .listen((favoriteIds) {
      emit(FavoritesState(
        favoriteIds: favoriteIds,
        isLoading: false,
      ));
    }, onError: (error) {
      print('Error in favorites stream: $error');
      emit(FavoritesState(
        favoriteIds: state.favoriteIds,
        isLoading: false,
        error: 'Error loading favorites: $error',
      ));
    });
  }

  // Toggle favorite status
  Future<void> toggleFavorite(String characterId) async {
    try {
      final user = _auth.currentUser;
      
      if (user == null) {
        emit(FavoritesState(
          favoriteIds: state.favoriteIds,
          isLoading: false,
          error: 'You must be logged in to save favorites',
        ));
        return;
      }
      
      // Optimistic update - update UI immediately
      final currentFavorites = Set<String>.from(state.favoriteIds);
      final isCurrentlyFavorite = currentFavorites.contains(characterId);
      
      if (isCurrentlyFavorite) {
        currentFavorites.remove(characterId);
      } else {
        currentFavorites.add(characterId);
      }
      
      emit(FavoritesState(
        favoriteIds: currentFavorites,
        isLoading: true,
      ));
      
      // Update in Firestore
      if (isCurrentlyFavorite) {
        await FirebaseService.removeFromFavorites(user.uid, characterId);
      } else {
        await FirebaseService.addToFavorites(user.uid, characterId);
      }
      
      // Note: We don't need to emit again here because the stream subscription
      // will automatically update the state when Firestore changes
      
    } catch (e) {
      print('Error toggling favorite: $e');
      
      // Revert to previous state on error
      emit(FavoritesState(
        favoriteIds: state.favoriteIds,
        isLoading: false,
        error: 'Failed to update favorite: $e',
      ));
      
      // Reload favorites to ensure consistency
      _reloadFavorites();
    }
  }

  // Reload favorites from Firestore
  Future<void> _reloadFavorites() async {
    try {
      final user = _auth.currentUser;
      
      if (user == null) {
        emit(const FavoritesState(favoriteIds: {}, isLoading: false));
        return;
      }
      
      emit(FavoritesState(favoriteIds: state.favoriteIds, isLoading: true));
      
      final favorites = await FirebaseService.getUserFavorites(user.uid);
      
      emit(FavoritesState(favoriteIds: favorites, isLoading: false));
    } catch (e) {
      print('Error reloading favorites: $e');
      emit(FavoritesState(
        favoriteIds: state.favoriteIds,
        isLoading: false,
        error: 'Failed to reload favorites: $e',
      ));
    }
  }

  // Check if a character is in favorites
  bool isFavorite(String characterId) {
    return state.favoriteIds.contains(characterId);
  }

  // Get list of favorite IDs
  List<String> get favoriteIds => state.favoriteIds.toList();

  // Handle user authentication changes
  void onUserChanged(User? user) {
    if (user == null) {
      // User logged out, clear favorites
      _favoritesSubscription?.cancel();
      emit(const FavoritesState(favoriteIds: {}, isLoading: false));
    } else {
      // User logged in, load their favorites
      _subscribeToFavorites(user.uid);
    }
  }

  @override
  Future<void> close() {
    _favoritesSubscription?.cancel();
    return super.close();
  }
}