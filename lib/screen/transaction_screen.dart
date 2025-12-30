import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;

  String _selectedFilter = 'Toutes';
  final List<String> _filters = ['Toutes', 'Reçus', 'Retraits', 'Transferts'];

  // Utiliser les mêmes couleurs que AcceuilScreen
  static const Color primaryBlue = Color(0xFF2563EB);
  static const Color primaryLightBlue = Color(0xFF3B82F6);
  static const Color primaryOrange = Color(0xFFEA580C);
  static const Color successGreen = Color(0xFF10B981);
  static const Color errorRed = Color(0xFFEF4444);
  static const Color warningOrange = Color(0xFFF59E0B);
  static const Color surfaceWhite = Color(0xFFFFFFFF);
  static const Color surfaceLight = Color(0xFFF1F5F9);
  static const Color textDark = Color(0xFF0F172A);
  static const Color textGray = Color(0xFF64748B);
  static const Color borderColor = Color(0xFFE2E8F0);
  static const Color lightBlue = Color(0xFFE0F2FE);

  // Données simulées des transactions
  final List<Map<String, dynamic>> _allTransactions = [
    {
      'id': 'TRX001',
      'clientName': 'Moussa Diop',
      'amount': 15000,
      'type': 'paiement',
      'date': '2024-01-17 10:30',
      'icon': Icons.arrow_circle_down_rounded,
      'color': successGreen,
      'typeText': 'Paiement reçu',
      'status': 'success',
      'account': 'Orange Money',
    },
    {
      'id': 'TRX002',
      'clientName': 'Aminata Fall',
      'amount': 7500,
      'type': 'retrait',
      'date': '2024-01-17 11:45',
      'icon': Icons.arrow_circle_up_rounded,
      'color': errorRed,
      'typeText': 'Retrait compte',
      'status': 'success',
      'account': 'Compte Principal',
    },
    {
      'id': 'TRX003',
      'clientName': 'Ibrahima Ndiaye',
      'amount': 25000,
      'type': 'paiement',
      'date': '2024-01-16 14:20',
      'icon': Icons.arrow_circle_down_rounded,
      'color': successGreen,
      'typeText': 'Paiement reçu',
      'status': 'success',
      'account': 'Wave',
    },
    {
      'id': 'TRX004',
      'clientName': 'Fatou Diagne',
      'amount': 18000,
      'type': 'transfert',
      'date': '2024-01-16 09:15',
      'icon': Icons.swap_horiz_rounded,
      'color': primaryBlue,
      'typeText': 'Transfert envoyé',
      'status': 'success',
      'account': 'Free Money',
    },
    {
      'id': 'TRX005',
      'clientName': 'Jean Mendy',
      'amount': 12000,
      'type': 'retrait',
      'date': '2024-01-15 16:40',
      'icon': Icons.arrow_circle_up_rounded,
      'color': errorRed,
      'typeText': 'Retrait compte',
      'status': 'success',
      'account': 'Compte Principal',
    },
    {
      'id': 'TRX006',
      'clientName': 'Marie Sarr',
      'amount': 30000,
      'type': 'paiement',
      'date': '2024-01-15 08:20',
      'icon': Icons.arrow_circle_down_rounded,
      'color': successGreen,
      'typeText': 'Paiement reçu',
      'status': 'success',
      'account': 'Orange Money',
    },
    {
      'id': 'TRX007',
      'clientName': 'Abdoulaye Ba',
      'amount': 15000,
      'type': 'paiement',
      'date': '2024-01-14 13:30',
      'icon': Icons.arrow_circle_down_rounded,
      'color': successGreen,
      'typeText': 'Paiement reçu',
      'status': 'success',
      'account': 'Wave',
    },
    {
      'id': 'TRX008',
      'clientName': 'Khadim Seck',
      'amount': 8000,
      'type': 'transfert',
      'date': '2024-01-14 17:15',
      'icon': Icons.swap_horiz_rounded,
      'color': primaryBlue,
      'typeText': 'Transfert envoyé',
      'status': 'pending',
      'account': 'Orange Money',
    },
    {
      'id': 'TRX009',
      'clientName': 'Aïcha Bâ',
      'amount': 22000,
      'type': 'paiement',
      'date': '2024-01-13 11:00',
      'icon': Icons.arrow_circle_down_rounded,
      'color': successGreen,
      'typeText': 'Paiement reçu',
      'status': 'success',
      'account': 'Free Money',
    },
    {
      'id': 'TRX010',
      'clientName': 'Modou Diouf',
      'amount': 5000,
      'type': 'retrait',
      'date': '2024-01-13 15:45',
      'icon': Icons.arrow_circle_up_rounded,
      'color': errorRed,
      'typeText': 'Retrait compte',
      'status': 'success',
      'account': 'Compte Principal',
    },
  ];

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeInOut),
      ),
    );

    _slideAnimation = Tween<double>(begin: 30.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.2, 0.8, curve: Curves.easeOut),
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredTransactions {
    if (_selectedFilter == 'Toutes') {
      return _allTransactions;
    } else if (_selectedFilter == 'Reçus') {
      return _allTransactions.where((t) => t['type'] == 'paiement').toList();
    } else if (_selectedFilter == 'Retraits') {
      return _allTransactions.where((t) => t['type'] == 'retrait').toList();
    } else if (_selectedFilter == 'Transferts') {
      return _allTransactions.where((t) => t['type'] == 'transfert').toList();
    }
    return _allTransactions;
  }

  double get _totalReceived {
    return _allTransactions
        .where((t) => t['type'] == 'paiement')
        .fold(0, (sum, t) => sum + t['amount']);
  }

  double get _totalWithdrawn {
    return _allTransactions
        .where((t) => t['type'] == 'retrait')
        .fold(0, (sum, t) => sum + t['amount']);
  }

  double get _totalTransferred {
    return _allTransactions
        .where((t) => t['type'] == 'transfert')
        .fold(0, (sum, t) => sum + t['amount']);
  }

  // Méthode pour formater la date d'affichage
  String _formatDisplayDate(String dateString) {
    final parts = dateString.split(' ');
    final datePart = parts[0];
    final timePart = parts[1];

    final dateParts = datePart.split('-');
    final year = dateParts[0];
    final month = dateParts[1];
    final day = dateParts[2];

    return '$day/$month/$year $timePart';
  }

  String _formatDateHeader(String dateString) {
    final parts = dateString.split(' ');
    final datePart = parts[0];

    final now = DateTime.now();
    final today = '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final yesterdayStr = '${yesterday.year}-${yesterday.month.toString().padLeft(2, '0')}-${yesterday.day.toString().padLeft(2, '0')}';

    if (datePart == today) {
      return 'Aujourd\'hui';
    } else if (datePart == yesterdayStr) {
      return 'Hier';
    } else {
      final dateParts = datePart.split('-');
      final day = dateParts[2];
      final month = dateParts[1];
      final year = dateParts[0];

      final months = {
        '01': 'janvier', '02': 'février', '03': 'mars', '04': 'avril',
        '05': 'mai', '06': 'juin', '07': 'juillet', '08': 'août',
        '09': 'septembre', '10': 'octobre', '11': 'novembre', '12': 'décembre'
      };

      return '$day ${months[month]} $year';
    }
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: Row(
          children: [
            Icon(
              color == successGreen ? Icons.check_circle_rounded : Icons.info_rounded,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 10),
            Text(
              message,
              style: GoogleFonts.poppins(color: Colors.white),
            ),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 2),
        margin: const EdgeInsets.all(20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Scaffold(
          backgroundColor: surfaceWhite,
          body: Stack(
            children: [
              // Arrière-plan avec effets (même que acceuil)
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

              SafeArea(
                child: Column(
                  children: [
                    // Header fixe avec animation
                    Transform.translate(
                      offset: Offset(0, _slideAnimation.value),
                      child: Opacity(
                        opacity: _fadeAnimation.value,
                        child: _buildHeader(),
                      ),
                    ),

                    // Contenu défilable
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.only(top: 16, bottom: 24),
                        child: Transform.translate(
                          offset: Offset(0, _slideAnimation.value),
                          child: Opacity(
                            opacity: _fadeAnimation.value,
                            child: Column(
                              children: [
                                // Statistiques rapides
                                _buildQuickStats(),

                                // Filtres
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                                  child: _buildFilterChips(),
                                ),

                                // Transactions
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: _buildTransactionsSection(),
                                ),

                                const SizedBox(height: 80),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: surfaceWhite,
        border: Border(
          bottom: BorderSide(color: borderColor, width: 1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Bouton retour
          // Container(
          //   width: 50,
          //   height: 50,
          //   decoration: BoxDecoration(
          //     color: surfaceLight,
          //     borderRadius: BorderRadius.circular(16),
          //     boxShadow: [
          //       BoxShadow(
          //         color: Colors.black.withOpacity(0.05),
          //         blurRadius: 10,
          //         offset: const Offset(0, 4),
          //       ),
          //     ],
          //   ),
          //   child: Material(
          //     color: Colors.transparent,
          //     borderRadius: BorderRadius.circular(16),
          //     child: InkWell(
          //       onTap: () => Navigator.pop(context),
          //       borderRadius: BorderRadius.circular(16),
          //       child: const Icon(
          //         Icons.arrow_back_ios_new_rounded,
          //         color: Color(0xFF2563EB),
          //         size: 20,
          //       ),
          //     ),
          //   ),
          // ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Transactions',
                  style: GoogleFonts.poppins(
                    color: textDark,
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Historique complet de vos transactions',
                  style: GoogleFonts.poppins(
                    color: textGray,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          // Bouton recherche
          // Container(
          //   width: 50,
          //   height: 50,
          //   decoration: BoxDecoration(
          //     color: surfaceLight,
          //     borderRadius: BorderRadius.circular(16),
          //     boxShadow: [
          //       BoxShadow(
          //         color: Colors.black.withOpacity(0.05),
          //         blurRadius: 10,
          //         offset: const Offset(0, 4),
          //       ),
          //     ],
          //   ),
          //   child: Material(
          //     color: Colors.transparent,
          //     borderRadius: BorderRadius.circular(16),
          //     child: InkWell(
          //       onTap: _showSearchDialog,
          //       borderRadius: BorderRadius.circular(16),
          //       child: const Icon(
          //         Icons.search_rounded,
          //         color: Color(0xFF64748B),
          //         size: 22,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildQuickStats() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF2563EB), Color(0xFF3B82F6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: primaryBlue.withOpacity(0.3),
              blurRadius: 25,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Column(
          children: [
            // Titre
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Résumé des Transactions',
                  style: GoogleFonts.poppins(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.bar_chart_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Statistiques
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white.withOpacity(0.3),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatItem('Reçus', _totalReceived, Icons.trending_up_rounded, successGreen),
                  _buildStatItem('Retraits', _totalWithdrawn, Icons.trending_down_rounded, errorRed),
                  _buildStatItem('Transferts', _totalTransferred, Icons.swap_horiz_rounded, primaryOrange),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String title, double amount, IconData icon, Color color) {
    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 12),
        Text(
          '${amount.toInt()} F',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: GoogleFonts.poppins(
            color: Colors.white.withOpacity(0.8),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChips() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Filtrer par type',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: textDark,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Choisissez le type de transaction à afficher',
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: textGray,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _filters.map((filter) {
            final isSelected = _selectedFilter == filter;
            return Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(16),
              child: InkWell(
                onTap: () {
                  setState(() {
                    _selectedFilter = filter;
                  });
                },
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                  decoration: BoxDecoration(
                    color: isSelected ? primaryBlue : surfaceWhite,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isSelected ? primaryBlue : borderColor,
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(isSelected ? 0.1 : 0.03),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Text(
                    filter,
                    style: GoogleFonts.poppins(
                      color: isSelected ? Colors.white : textDark,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildTransactionsSection() {
    final transactions = _filteredTransactions;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Transactions récentes',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: textDark,
                letterSpacing: -0.5,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: primaryBlue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${transactions.length} transactions',
                style: GoogleFonts.poppins(
                  color: primaryBlue,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          'Liste complète de vos transactions',
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: textGray,
          ),
        ),
        const SizedBox(height: 20),

        transactions.isEmpty
            ? _buildEmptyState()
            : _buildTransactionsList(),

        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildTransactionsList() {
    // Grouper les transactions par date
    final Map<String, List<Map<String, dynamic>>> groupedTransactions = {};

    for (final transaction in _filteredTransactions) {
      final dateKey = transaction['date'].split(' ')[0];
      if (!groupedTransactions.containsKey(dateKey)) {
        groupedTransactions[dateKey] = [];
      }
      groupedTransactions[dateKey]!.add(transaction);
    }

    // Trier les dates (plus récentes en premier)
    final sortedDates = groupedTransactions.keys.toList()
      ..sort((a, b) => b.compareTo(a));

    return Column(
      children: [
        ...sortedDates.map((date) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // En-tête de date
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                _formatDateHeader(date),
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: textDark,
                ),
              ),
            ),

            // Liste des transactions pour cette date
            ...groupedTransactions[date]!.map((transaction) =>
                _buildTransactionItem(transaction)
            ),
          ],
        )),
      ],
    );
  }

  Widget _buildTransactionItem(Map<String, dynamic> transaction) {
    final isPending = transaction['status'] == 'pending';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surfaceWhite,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: (transaction['color'] as Color).withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: (transaction['color'] as Color).withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(transaction['icon'] as IconData, color: transaction['color'] as Color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction['clientName'] as String,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: textDark,
                  ),
                ),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: (transaction['color'] as Color).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        transaction['typeText'] as String,
                        style: GoogleFonts.poppins(
                          color: transaction['color'] as Color,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    if (isPending)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: warningOrange.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'En attente',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: warningOrange,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  _formatDisplayDate(transaction['date'] as String),
                  style: GoogleFonts.poppins(
                    color: textGray,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${transaction['amount']} F',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w700,
                  fontSize: 17,
                  color: transaction['color'] as Color,
                ),
              ),
              const SizedBox(height: 8),
              Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(8),
                child: InkWell(
                  onTap: () => _showTransactionDetails(transaction),
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: primaryBlue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Détails',
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        color: primaryBlue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
      decoration: BoxDecoration(
        color: surfaceWhite,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: primaryBlue.withOpacity(0.1),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: primaryBlue.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              Icons.receipt_long_rounded,
              color: primaryBlue,
              size: 40,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            _selectedFilter == 'Toutes'
                ? 'Aucune transaction'
                : 'Aucune transaction ${_selectedFilter.toLowerCase()}',
            style: GoogleFonts.poppins(
              color: textDark,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Vos transactions apparaîtront ici',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: textGray,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  void _showSearchDialog() {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.7),
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (context, animation, secondaryAnimation) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: animation,
            child: Dialog(
              insetPadding: const EdgeInsets.all(24),
              backgroundColor: Colors.transparent,
              elevation: 0,
              child: Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [surfaceWhite, lightBlue.withOpacity(0.5)],
                  ),
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 40,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: primaryBlue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: primaryBlue.withOpacity(0.2),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.search_rounded,
                        color: primaryBlue,
                        size: 36,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Rechercher une transaction',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: textDark,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Trouvez rapidement vos transactions',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: textGray,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: surfaceWhite,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: borderColor, width: 1.5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Nom, montant, date...',
                          hintStyle: GoogleFonts.poppins(color: textGray),
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.search_rounded, color: primaryBlue),
                        ),
                        style: GoogleFonts.poppins(color: textDark),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Row(
                      children: [
                        Expanded(
                          child: Material(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () => Navigator.of(context).pop(),
                              borderRadius: BorderRadius.circular(16),
                              child: Container(
                                padding: const EdgeInsets.all(18),
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Center(
                                  child: Text(
                                    'ANNULER',
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: textGray,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              gradient: const LinearGradient(
                                colors: [Color(0xFF2563EB), Color(0xFF3B82F6)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: primaryBlue.withOpacity(0.4),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Material(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(16),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).pop();
                                  _showSnackBar('Recherche effectuée', successGreen);
                                },
                                borderRadius: BorderRadius.circular(16),
                                child: Padding(
                                  padding: const EdgeInsets.all(18),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.search_rounded, color: Colors.white, size: 20),
                                      const SizedBox(width: 10),
                                      Text(
                                        'RECHERCHER',
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showTransactionDetails(Map<String, dynamic> transaction) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.7),
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (context, animation, secondaryAnimation) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: animation,
            child: Dialog(
              insetPadding: const EdgeInsets.all(24),
              backgroundColor: Colors.transparent,
              elevation: 0,
              child: Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [surfaceWhite, lightBlue.withOpacity(0.5)],
                  ),
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 40,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // En-tête
                    Container(
                      width: 100,
                      height: 100,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: (transaction['color'] as Color).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: (transaction['color'] as Color).withOpacity(0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Icon(
                        transaction['icon'] as IconData,
                        color: transaction['color'] as Color,
                        size: 40,
                      ),
                    ),
                    const SizedBox(height: 24),

                    Text(
                      'Détails de la transaction',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: textDark,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 8),

                    Text(
                      transaction['typeText'] as String,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: transaction['color'] as Color,
                      ),
                    ),
                    const SizedBox(height: 4),

                    Text(
                      '${transaction['amount']} F',
                      style: GoogleFonts.poppins(
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                        color: textDark,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Détails
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: primaryBlue.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: primaryBlue.withOpacity(0.2)),
                      ),
                      child: Column(
                        children: [
                          _buildDetailRow('Client', transaction['clientName'] as String),
                          const SizedBox(height: 12),
                          _buildDetailRow('Date', _formatDisplayDate(transaction['date'] as String)),
                          const SizedBox(height: 12),
                          _buildDetailRow('Compte', transaction['account'] as String),
                          const SizedBox(height: 12),
                          _buildDetailRow('Statut', transaction['status'] == 'success' ? 'Réussi' : 'En attente'),
                          const SizedBox(height: 12),
                          _buildDetailRow('ID Transaction', transaction['id'] as String),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Boutons d'action
                    Row(
                      children: [
                        Expanded(
                          child: Material(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () => Navigator.of(context).pop(),
                              borderRadius: BorderRadius.circular(16),
                              child: Container(
                                padding: const EdgeInsets.all(18),
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Center(
                                  child: Text(
                                    'FERMER',
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: textGray,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              gradient: const LinearGradient(
                                colors: [Color(0xFF2563EB), Color(0xFF3B82F6)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: primaryBlue.withOpacity(0.4),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Material(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(16),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).pop();
                                  _showSnackBar('Reçu partagé avec succès', successGreen);
                                },
                                borderRadius: BorderRadius.circular(16),
                                child: Padding(
                                  padding: const EdgeInsets.all(18),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.share_rounded, color: Colors.white, size: 20),
                                      const SizedBox(width: 10),
                                      Text(
                                        'PARTAGER',
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '$label:',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                color: textGray,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 2,
            child: Text(
              value,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                color: textDark,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}