import 'package:flutter/material.dart';
import 'package:marchand/auth/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  // Même palette de couleurs premium
  static const Color primaryBlue = Color(0xFF2563EB);
  static const Color primaryLightBlue = Color(0xFF3B82F6);
  static const Color primaryOrange = Color(0xFFEA580C);
  static const Color lightBlue = Color(0xFFE0F2FE);
  static const Color successGreen = Color(0xFF10B981);
  static const Color surfaceWhite = Color(0xFFFFFFFF);
  static const Color textDark = Color(0xFF0F172A);
  static const Color textGray = Color(0xFF64748B);

  final List<OnboardingPage> _onboardingPages = [
    OnboardingPage(
      image: '💸',
      title: 'Bienvenue sur\nOnd Money',
      description: 'La solution de paiement mobile révolutionnaire pour les commerçants sénégalais.',
      color: primaryBlue,
      gradient: [primaryBlue, primaryLightBlue],
    ),
    OnboardingPage(
      image: '⚡',
      title: 'Transactions\nInstantanées',
      description: 'Paiements, retraits et transferts en quelques secondes, 24h/24 et 7j/7.',
      color: successGreen,
      gradient: [successGreen, const Color(0xFF34D399)],
    ),
    OnboardingPage(
      image: '🔒',
      title: 'Sécurité\nMaximale',
      description: 'Vos transactions sont protégées par un cryptage bancaire de niveau militaire.',
      color: primaryOrange,
      gradient: [primaryOrange, const Color(0xFFFB923C)],
    ),
    OnboardingPage(
      image: '🚀',
      title: 'Prêt à\nDécoller ?',
      description: 'Rejoignez des milliers de commerçants qui révolutionnent leur business.',
      color: primaryBlue,
      gradient: [primaryBlue, primaryLightBlue],
    ),
  ];

  @override
  void initState() {
    super.initState();

    // Initialisation des animations
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeInOut),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.2, 0.8, curve: Curves.elasticOut),
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Scaffold(
          backgroundColor: surfaceWhite,
          body: SafeArea(
            child: Stack(
              children: [
                // Arrière-plan avec effets
                Positioned(
                  top: -100,
                  right: -100,
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          primaryBlue.withOpacity(0.15),
                          primaryOrange.withOpacity(0.08),
                          Colors.transparent,
                        ],
                        stops: const [0.1, 0.5, 0.8],
                        radius: 0.8,
                      ),
                    ),
                  ),
                ),

                Positioned(
                  bottom: -150,
                  left: -100,
                  child: Container(
                    width: 400,
                    height: 400,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          primaryOrange.withOpacity(0.1),
                          primaryBlue.withOpacity(0.05),
                          Colors.transparent,
                        ],
                        stops: const [0.1, 0.6, 0.9],
                      ),
                    ),
                  ),
                ),

                // Contenu principal
                Column(
                  children: [
                    // Header avec effet
                    _buildHeader(),

                    // Contenu principal avec animation
                    Expanded(
                      child: Opacity(
                        opacity: _fadeAnimation.value,
                        child: Transform.scale(
                          scale: _scaleAnimation.value,
                          child: PageView.builder(
                            controller: _pageController,
                            itemCount: _onboardingPages.length,
                            onPageChanged: (int page) {
                              setState(() {
                                _currentPage = page;
                              });
                            },
                            itemBuilder: (context, index) {
                              return _buildOnboardingPage(_onboardingPages[index], screenHeight);
                            },
                          ),
                        ),
                      ),
                    ),

                    // Section du bas avec effet
                    _buildBottomSection(screenWidth),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo animé
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryBlue, primaryLightBlue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: primaryBlue.withOpacity(0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: const Icon(
              Icons.account_balance_wallet_rounded,
              color: Colors.white,
              size: 24,
            ),
          ),

          // Bouton Skip avec effet
          if (_currentPage < _onboardingPages.length - 1)
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  colors: [
                    Colors.grey[100]!,
                    Colors.grey[50]!,
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(16),
                child: InkWell(
                  onTap: _goToLastPage,
                  borderRadius: BorderRadius.circular(16),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    child: Text(
                      'Passer',
                      style: TextStyle(
                        color: textGray,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildOnboardingPage(OnboardingPage page, double screenHeight) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: screenHeight * 0.7,
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Illustration avec effet de halo
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: page.color.withOpacity(0.3),
                      blurRadius: 40,
                      spreadRadius: 10,
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    // Cercle de fond avec gradient
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: page.gradient,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    ),

                    // Emoji au centre
                    Center(
                      child: Text(
                        page.image,
                        style: const TextStyle(fontSize: 80),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // Titre avec effet
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: BoxDecoration(
                  color: surfaceWhite,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      page.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: textDark,
                        letterSpacing: -1,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 16),

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
              ),

              // Indicateur de progression en bas de la carte
              const SizedBox(height: 20),
              _buildPageIndicator(),
              const SizedBox(height: 20), // Espace supplémentaire
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _onboardingPages.length,
            (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 8,
          width: index == _currentPage ? 24 : 8,
          decoration: BoxDecoration(
            color: index == _currentPage
                ? _onboardingPages[_currentPage].color
                : Colors.grey[300],
            borderRadius: BorderRadius.circular(4),
            boxShadow: index == _currentPage
                ? [
              BoxShadow(
                color: _onboardingPages[_currentPage].color.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ]
                : [],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomSection(double screenWidth) {
    final isSmallScreen = screenWidth < 600;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Bouton principal avec effet
          SizedBox(
            width: double.infinity,
            child: Material(
              borderRadius: BorderRadius.circular(20),
              elevation: 0,
              child: Container(
                height: 68,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: _onboardingPages[_currentPage].gradient,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: _onboardingPages[_currentPage].color.withOpacity(0.4),
                      blurRadius: 30,
                      offset: const Offset(0, 15),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: _currentPage == _onboardingPages.length - 1
                        ? _goToLogin
                        : _goToNextPage,
                    child: Stack(
                      children: [
                        // Effet de brillance
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                colors: [
                                  Colors.white.withOpacity(0.1),
                                  Colors.transparent,
                                  Colors.white.withOpacity(0.1),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                _currentPage == _onboardingPages.length - 1
                                    ? Icons.login_rounded
                                    : Icons.arrow_forward_rounded,
                                color: Colors.white,
                                size: 22,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                _currentPage == _onboardingPages.length - 1
                                    ? 'Se connecter'
                                    : 'Continuer',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Bouton secondaire pour la dernière page (Inscription)
          // if (_currentPage == _onboardingPages.length - 1)
          //   SizedBox(
          //     width: double.infinity,
          //     child: Material(
          //       color: Colors.transparent,
          //       borderRadius: BorderRadius.circular(12),
          //       child: InkWell(
          //         onTap: () {
          //           // Navigation vers l'inscription
          //           // Navigator.push(context, MaterialPageRoute(builder: (_) => RegisterScreen()));
          //           _showRegisterMessage();
          //         },
          //         borderRadius: BorderRadius.circular(12),
          //         child: Container(
          //           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          //           decoration: BoxDecoration(
          //             color: surfaceWhite,
          //             borderRadius: BorderRadius.circular(16),
          //             border: Border.all(
          //               color: primaryBlue.withOpacity(0.2),
          //               width: 2,
          //             ),
          //             boxShadow: [
          //               BoxShadow(
          //                 color: primaryBlue.withOpacity(0.05),
          //                 blurRadius: 15,
          //                 offset: const Offset(0, 5),
          //               ),
          //             ],
          //           ),
          //           child: Row(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               Container(
          //                 padding: const EdgeInsets.all(8),
          //                 decoration: BoxDecoration(
          //                   color: primaryBlue.withOpacity(0.1),
          //                   shape: BoxShape.circle,
          //                 ),
          //                 child: Icon(
          //                   Icons.person_add_rounded,
          //                   color: primaryBlue,
          //                   size: 18,
          //                 ),
          //               ),
          //               const SizedBox(width: 12),
          //               Column(
          //                 crossAxisAlignment: CrossAxisAlignment.center,
          //                 mainAxisSize: MainAxisSize.min,
          //                 children: [
          //                   Text(
          //                     'Pas encore de compte ?',
          //                     style: TextStyle(
          //                       fontSize: 13,
          //                       color: textGray,
          //                     ),
          //                   ),
          //                   Text(
          //                     'S\'inscrire',
          //                     style: TextStyle(
          //                       fontSize: 15,
          //                       color: primaryBlue,
          //                       fontWeight: FontWeight.w600,
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //               const SizedBox(width: 12),
          //               Icon(
          //                 Icons.arrow_forward_rounded,
          //                 color: primaryBlue,
          //                 size: 18,
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),

          // Indicateurs supplémentaires (uniquement sur grands écrans)
          if (!isSmallScreen) ...[
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildFeatureIndicator(
                  icon: Icons.security_rounded,
                  text: 'Sécurisé',
                  color: successGreen,
                ),
                const SizedBox(width: 20),
                _buildFeatureIndicator(
                  icon: Icons.flash_on_rounded,
                  text: 'Rapide',
                  color: primaryOrange,
                ),
                const SizedBox(width: 20),
                _buildFeatureIndicator(
                  icon: Icons.support_agent_rounded,
                  text: 'Support',
                  color: primaryBlue,
                ),
              ],
            ),
          ],
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildFeatureIndicator({
    required IconData icon,
    required String text,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withOpacity(0.3)),
          ),
          child: Icon(
            icon,
            color: color,
            size: 24,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: textGray,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  void _goToNextPage() {
    if (_currentPage < _onboardingPages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _goToLastPage() {
    _pageController.animateToPage(
      _onboardingPages.length - 1,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOutCubic,
    );
  }

  void _goToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  // void _showRegisterMessage() {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       backgroundColor: primaryBlue,
  //       content: Row(
  //         children: [
  //           const Icon(Icons.info_outline_rounded, color: Colors.white, size: 20),
  //           const SizedBox(width: 10),
  //           Expanded(
  //             child: Text(
  //               'Fonctionnalité d\'inscription bientôt disponible !',
  //               style: TextStyle(color: Colors.white),
  //             ),
  //           ),
  //         ],
  //       ),
  //       behavior: SnackBarBehavior.floating,
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  //       duration: const Duration(seconds: 2),
  //       margin: const EdgeInsets.all(20),
  //     ),
  //   );
  // }
}

class OnboardingPage {
  final String image;
  final String title;
  final String description;
  final Color color;
  final List<Color> gradient;

  OnboardingPage({
    required this.image,
    required this.title,
    required this.description,
    required this.color,
    required this.gradient,
  });
}