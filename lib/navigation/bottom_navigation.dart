import 'package:flutter/material.dart';
import 'package:marchand/screen/acceuil_screen.dart';
import 'package:marchand/screen/transaction_screen.dart';

class BottomNavigation extends StatefulWidget {
  final int selectedIndex;

  const BottomNavigation({
    super.key,
    required this.selectedIndex,
  });

  static _BottomNavigationState? of(BuildContext context) {
    return context.findAncestorStateOfType<_BottomNavigationState>();
  }

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  late int _currentIndex;
  double _bottomBarHeight = 70;
  bool _isExtended = false;

  final List<Widget> _pages = [
    const AcceuilScreen(),
    const TransactionScreen(),
    _buildScannerPage(),
    _buildSettingsPage(),
  ];

  final List<String> _pageTitles = [
    'Accueil',
    'Transactions',
    'Scanner',
    'Paramètres',
  ];

  final List<IconData> _icons = [
    Icons.home_rounded,
    Icons.receipt_long_rounded,
    Icons.qr_code_scanner_rounded,
    Icons.settings_rounded,
  ];

  final List<Color> _activeColors = [
    const Color(0xFF2563EB), // Bleu
    const Color(0xFF059669), // Vert
    const Color(0xFFEA580C), // Orange
    const Color(0xFF8B5CF6), // Violet
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // Pour que le body passe sous la bottom bar
      appBar: _currentIndex == 0 ? null : _buildAppBar(),
      body: _pages[_currentIndex],
      bottomNavigationBar: _buildModernBottomBar(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      title: Text(
        _pageTitles[_currentIndex],
        style: const TextStyle(
          color: Color(0xFF0F172A),
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: const Color(0xFFF1F5F9),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(Icons.arrow_back_ios_rounded,
              color: Color(0xFF475569),
              size: 16
          ),
        ),
        onPressed: () => setState(() => _currentIndex = 0),
      ),
      actions: _currentIndex == 1 ? [_buildFilterButton()] : null,
    );
  }

  Widget _buildFilterButton() {
    return IconButton(
      icon: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(Icons.filter_list_rounded,
            color: Color(0xFF475569),
            size: 18
        ),
      ),
      onPressed: () {},
    );
  }

  Widget _buildModernBottomBar() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      height: _bottomBarHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(_isExtended ? 24 : 0),
          topRight: Radius.circular(_isExtended ? 24 : 0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (int i = 0; i < _icons.length; i++)
                _buildNavItem(_icons[i], _pageTitles[i], i),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isActive = _currentIndex == index;
    final double iconSize = isActive ? 24 : 22;
    final Color color = isActive ? _activeColors[index] : const Color(0xFF94A3B8);

    return GestureDetector(
      onTap: () {
        if (index == 2) {
          // Animation spéciale pour le bouton scanner
          setState(() {
            _isExtended = !_isExtended;
            _bottomBarHeight = _isExtended ? 100 : 70;
          });
          Future.delayed(const Duration(milliseconds: 300), () {
            setState(() => _currentIndex = index);
          });
        } else {
          setState(() {
            _currentIndex = index;
            _isExtended = false;
            _bottomBarHeight = 70;
          });
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(
          horizontal: isActive ? 16 : 12,
          vertical: isActive ? 10 : 8,
        ),
        decoration: BoxDecoration(
          color: isActive ? color.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: isActive ? Border.all(color: color.withOpacity(0.2), width: 1) : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Icon(icon, color: color, size: iconSize),
                if (index == 2 && isActive)
                  Positioned(
                    right: -2,
                    top: -2,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEA580C),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1.5),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 10,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
            if (isActive)
              Container(
                width: 4,
                height: 4,
                margin: const EdgeInsets.only(top: 2),
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }

  static Widget _buildScannerPage() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: 300,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFF2563EB).withOpacity(0.1),
                  Colors.transparent,
                ],
              ),
            ),
            child: Center(
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: const Color(0xFF2563EB).withOpacity(0.05),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFF2563EB).withOpacity(0.2),
                    width: 2,
                  ),
                ),
                child: const Icon(
                  Icons.qr_code_scanner_rounded,
                  size: 80,
                  color: Color(0xFF2563EB),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              children: [
                const Text(
                  'Scanner QR Code',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Scannez les codes QR pour recevoir des paiements rapidement et en toute sécurité',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF64748B),
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2563EB),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                    shadowColor: Colors.transparent,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.qr_code_scanner_rounded, size: 20),
                      SizedBox(width: 10),
                      Text(
                        'Démarrer le scan',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    side: const BorderSide(color: Color(0xFFE2E8F0)),
                  ),
                  child: const Text(
                    'Galerie',
                    style: TextStyle(
                      color: Color(0xFF475569),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildSettingsPage() {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            surfaceTintColor: Colors.transparent,
            pinned: true,
            expandedHeight: 120,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
              title: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF8B5CF6), Color(0xFFA78BFA)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.settings_rounded,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Paramètres',
                    style: TextStyle(
                      color: Color(0xFF0F172A),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(height: 16),
              _buildSettingsSection(
                'Compte',
                Icons.person_outline_rounded,
                [
                  _buildSettingsOption(
                    Icons.person_rounded,
                    'Profil',
                    'Informations personnelles',
                    const Color(0xFF3B82F6),
                  ),
                  _buildSettingsOption(
                    Icons.lock_rounded,
                    'Sécurité',
                    'Mot de passe & authentification',
                    const Color(0xFF059669),
                  ),
                  _buildSettingsOption(
                    Icons.notifications_active_rounded,
                    'Notifications',
                    'Préférences de notifications',
                    const Color(0xFFEA580C),
                  ),
                  _buildSettingsOption(
                    Icons.payment_rounded,
                    'Méthodes de paiement',
                    'Cartes et comptes bancaires',
                    const Color(0xFF8B5CF6),
                  ),
                ],
              ),
              _buildSettingsSection(
                'Application',
                Icons.apps_rounded,
                [
                  _buildSettingsOption(
                    Icons.help_outline_rounded,
                    'Aide & Support',
                    'Centre d\'aide et FAQ',
                    const Color(0xFF6366F1),
                  ),
                  _buildSettingsOption(
                    Icons.privacy_tip_rounded,
                    'Confidentialité',
                    'Politique de confidentialité',
                    const Color(0xFF10B981),
                  ),
                  _buildSettingsOption(
                    Icons.info_outline_rounded,
                    'À propos',
                    'Version 2.1.0 • Dernière mise à jour',
                    const Color(0xFFF59E0B),
                  ),
                  _buildSettingsOption(
                    Icons.star_outline_rounded,
                    'Évaluer l\'application',
                    'Notez-nous sur le store',
                    const Color(0xFFEC4899),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF2563EB), Color(0xFF3B82F6)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.logout_rounded,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Déconnexion',
                                  style: TextStyle(
                                    color: Color(0xFF0F172A),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Déconnectez-vous de votre compte',
                                  style: TextStyle(
                                    color: Color(0xFF64748B),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.chevron_right_rounded,
                            color: Color(0xFFCBD5E1),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Ond Money v2.1.0',
                      style: TextStyle(
                        color: const Color(0xFF64748B).withOpacity(0.7),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  static Widget _buildSettingsSection(String title, IconData icon, List<Widget> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            children: [
              Icon(icon, color: const Color(0xFF64748B), size: 18),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF64748B),
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(children: options),
        ),
      ],
    );
  }

  static Widget _buildSettingsOption(IconData icon, String title, String subtitle, Color color) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      leading: Container(
        width: 40,
        height: 40,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: color, size: 20),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Color(0xFF0F172A),
          fontSize: 15,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          color: Color(0xFF64748B),
          fontSize: 12,
        ),
      ),
      trailing: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(Icons.chevron_right_rounded,
            color: Color(0xFF94A3B8),
            size: 18
        ),
      ),
      onTap: () {},
    );
  }

  void changePage(int index) {
    if (index >= 0 && index < _pages.length) {
      setState(() {
        _currentIndex = index;
        _isExtended = false;
        _bottomBarHeight = 70;
      });
    }
  }
}