import 'package:flutter/material.dart';
import '../../screens/favorite_pg_screen.dart';
import '../../themes/firefly_theme.dart';

class FavoritesButton extends StatelessWidget {
  const FavoritesButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 20,
      left: 20,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FavoritePgScreen()),
          );
        },
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: FireflyTheme.jacket.withOpacity(0.7),
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Image.asset(
              'assets/images/like-firefly.gif',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  Icons.favorite,
                  color: FireflyTheme.turquoise,
                  size: 30,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}