import 'package:flutter/material.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  String _selectedFilter = 'Toutes';
  final List<String> _filters = ['Toutes', 'Reçus', 'Retraits', 'Transferts'];

  // Utiliser les mêmes couleurs que AcceuilScreen
  static const Color primaryColor = Color(0xFF2563EB); // Bleu vif
  static const Color secondaryColor = Color(0xFF059669); // Vert émeraude
  static const Color accentColor = Color(0xFFEA580C); // Orange vif
  static const Color backgroundLight = Color(0xFFF0F9FF); // Bleu très clair
  static const Color surfaceWhite = Color(0xFFFFFFFF); // Surface blanche
  static const Color textDark = Color(0xFF0F172A); // Texte foncé
  static const Color textGray = Color(0xFF475569); // Texte secondaire
  static const Color successGreen = Color(0xFF059669);
  static const Color errorRed = Color(0xFFDC2626);
  static const Color warningOrange = Color(0xFFEA580C);

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
      'color': primaryColor,
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
      'color': primaryColor,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Statistiques rapides (même style que la carte solde)
                    _buildQuickStats(),
                    const SizedBox(height: 25),

                    // Filtres
                    _buildFilterChips(),
                    const SizedBox(height: 25),

                    // Transactions
                    _buildTransactionsSection(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }



  Widget _buildQuickStats() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF2563EB), Color(0xFF3B82F6)],
        ),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
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
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
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
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem('Reçus', _totalReceived, Icons.trending_up_rounded, successGreen),
                _buildStatItem('Retraits', _totalWithdrawn, Icons.trending_down_rounded, errorRed),
                _buildStatItem('Transferts', _totalTransferred, Icons.swap_horiz_rounded, accentColor),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String title, double amount, IconData icon, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(height: 8),
        Text(
          '${amount.toInt()} F',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 11,
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
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: textDark,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _filters.map((filter) {
            final isSelected = _selectedFilter == filter;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedFilter = filter;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? primaryColor : surfaceWhite,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected ? primaryColor : Colors.grey[300]!,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  filter,
                  style: TextStyle(
                    color: isSelected ? Colors.white : textDark,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
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
              'Transactions Récentes',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: textDark,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${transactions.length} transactions',
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        transactions.isEmpty
            ? _buildEmptyState()
            : _buildTransactionsList(),

        const SizedBox(height: 10),
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                _formatDateHeader(date),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
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
    final isSuccess = transaction['status'] == 'success';
    final isPending = transaction['status'] == 'pending';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surfaceWhite,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icône avec fond coloré
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: transaction['color'].withOpacity(0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              transaction['icon'],
              color: transaction['color'],
              size: 24,
            ),
          ),
          const SizedBox(width: 15),

          // Informations
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction['clientName'],
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: textDark,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      transaction['typeText'],
                      style: TextStyle(
                        color: transaction['color'],
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 8),
                    if (isPending)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: warningOrange.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'En attente',
                          style: TextStyle(
                            fontSize: 10,
                            color: warningOrange,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  _formatDisplayDate(transaction['date']),
                  style: TextStyle(
                    color: textGray,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          // Montant
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${transaction['amount']} F',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: transaction['color'],
                ),
              ),
              const SizedBox(height: 4),
              GestureDetector(
                onTap: () => _showTransactionDetails(transaction),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'Détails',
                    style: TextStyle(
                      fontSize: 10,
                      color: primaryColor,
                      fontWeight: FontWeight.w500,
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
      padding: const EdgeInsets.symmetric(vertical: 50),
      decoration: BoxDecoration(
        color: surfaceWhite,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Icon(
            Icons.receipt_long_rounded,
            color: textGray.withOpacity(0.4),
            size: 60,
          ),
          const SizedBox(height: 16),
          Text(
            _selectedFilter == 'Toutes'
                ? 'Aucune transaction'
                : 'Aucune transaction ${_selectedFilter.toLowerCase()}',
            style: TextStyle(
              color: textDark,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Vos transactions apparaîtront ici',
            style: TextStyle(
              color: textGray,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        child: Container(
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: surfaceWhite,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Rechercher une transaction',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: textDark,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: backgroundLight,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Nom du client, montant...',
                    hintStyle: TextStyle(color: textGray),
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search_rounded, color: primaryColor),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('RECHERCHER'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showTransactionDetails(Map<String, dynamic> transaction) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: surfaceWhite,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 60,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // En-tête
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: transaction['color'].withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    transaction['icon'],
                    color: transaction['color'],
                    size: 30,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        transaction['typeText'],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: transaction['color'],
                        ),
                      ),
                      Text(
                        '${transaction['amount']} FCFA',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: textDark,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Détails
            _buildDetailRow('Client', transaction['clientName']),
            _buildDetailRow('Date', _formatDisplayDate(transaction['date'])),
            _buildDetailRow('Compte', transaction['account']),
            _buildDetailRow('Statut', transaction['status'] == 'success' ? 'Réussi' : 'En attente'),
            _buildDetailRow('ID Transaction', transaction['id']),

            const SizedBox(height: 30),

            // Boutons d'action
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _shareReceipt(transaction);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('PARTAGER LE REÇU'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(
            '$label:',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: textGray,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: textDark,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  void _shareReceipt(Map<String, dynamic> transaction) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Reçu de ${transaction['clientName']} partagé'),
        duration: const Duration(seconds: 2),
        backgroundColor: primaryColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}