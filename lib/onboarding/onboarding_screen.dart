import 'package:flutter/material.dart';
import 'package:marchand/navigation/bottom_navigation.dart';

import '../screen/acceuil_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Même palette de couleurs que AcceuilScreen
  static const Color primaryColor = Color(0xFF2563EB); // Bleu vif
  static const Color secondaryColor = Color(0xFF059669); // Vert émeraude
  static const Color accentColor = Color(0xFFEA580C); // Orange vif
  static const Color backgroundLight = Color(0xFFF0F9FF); // Bleu très clair
  static const Color surfaceWhite = Color(0xFFFFFFFF); // Surface blanche
  static const Color textDark = Color(0xFF0F172A); // Texte foncé
  static const Color textGray = Color(0xFF475569); // Texte secondaire

  final List<OnboardingPage> _onboardingPages = [
    OnboardingPage(
      image: '💰',
      title: 'Bienvenue sur Ond Money',
      description: 'La solution de paiement mobile simple, sécurisée et rapide pour tous vos besoins financiers.',
      color: primaryColor,
    ),
    OnboardingPage(
      image: '⚡',
      title: 'Transactions Instantanées',
      description: 'Effectuez des paiements, retraits et transferts en quelques secondes, 24h/24 et 7j/7.',
      color: secondaryColor,
    ),
    OnboardingPage(
      image: '🔒',
      title: 'Sécurité Maximale',
      description: 'Vos transactions sont protégées par les meilleures technologies de sécurité et cryptage.',
      color: accentColor,
    ),
    OnboardingPage(
      image: '📱',
      title: 'Simple à Utiliser',
      description: 'Interface intuitive conçue pour une expérience utilisateur fluide et agréable.',
      color: primaryColor,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            // Header avec bouton skip
            _buildHeader(),

            // Contenu principal
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _onboardingPages.length,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemBuilder: (context, index) {
                  return _buildOnboardingPage(_onboardingPages[index]);
                },
              ),
            ),

            // Indicateurs et boutons
            _buildBottomSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo ou titre
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [primaryColor, Color(0xFF3B82F6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.account_balance_wallet_rounded,
              color: Colors.white,
              size: 24,
            ),
          ),

          // Bouton Skip
          if (_currentPage < _onboardingPages.length - 1)
            TextButton(
              onPressed: _goToLastPage,
              child: Text(
                'Passer',
                style: TextStyle(
                  color: textGray,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildOnboardingPage(OnboardingPage page) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Illustration
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: page.color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                page.image,
                style: const TextStyle(fontSize: 80),
              ),
            ),
          ),
          const SizedBox(height: 40),

          // Titre
          Text(
            page.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: textDark,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 20),

          // Description
          Text(
            page.description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: textGray,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Indicateurs de page
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _onboardingPages.length,
                  (index) => _buildPageIndicator(index == _currentPage),
            ),
          ),
          const SizedBox(height: 30),

          // Bouton principal
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _currentPage == _onboardingPages.length - 1
                  ? _completeOnboarding
                  : _goToNextPage,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 2,
              ),
              child: Text(
                _currentPage == _onboardingPages.length - 1
                    ? 'Commencer'
                    : 'Suivant',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          // Bouton secondaire pour la dernière page
          if (_currentPage == _onboardingPages.length - 1)
            TextButton(
              onPressed: _completeOnboarding,
              child: Text(
                'Créer un compte',
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPageIndicator(bool isActive) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: isActive ? 24 : 8,
      decoration: BoxDecoration(
        color: isActive ? primaryColor : textGray.withOpacity(0.3),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  void _goToNextPage() {
    if (_currentPage < _onboardingPages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToLastPage() {
    _pageController.animateToPage(
      _onboardingPages.length - 1,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _completeOnboarding() {
    // Navigation vers l'écran d'accueil principal
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const BottomNavigation(selectedIndex: 0)),
    );
  }
}

class OnboardingPage {
  final String image;
  final String title;
  final String description;
  final Color color;

  OnboardingPage({
    required this.image,
    required this.title,
    required this.description,
    required this.color,
  });
}