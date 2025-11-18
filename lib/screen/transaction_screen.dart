import 'package:flutter/material.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  String _selectedFilter = 'Toutes';
  final List<String> _filters = ['Toutes', 'Reçus', 'Retraits', 'Transferts'];

  // Données simulées des transactions
  final List<Map<String, dynamic>> _allTransactions = [
    {
      'id': 'TRX001',
      'clientName': 'Moussa Diop',
      'amount': 15000,
      'type': 'paiement',
      'date': '2024-01-17 10:30',
      'icon': Icons.arrow_downward,
      'color': Color(0xFF4CAF50),
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
      'icon': Icons.arrow_upward,
      'color': Color(0xFFF44336),
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
      'icon': Icons.arrow_downward,
      'color': Color(0xFF4CAF50),
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
      'icon': Icons.swap_horiz,
      'color': Color(0xFF2196F3),
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
      'icon': Icons.arrow_upward,
      'color': Color(0xFFF44336),
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
      'icon': Icons.arrow_downward,
      'color': Color(0xFF4CAF50),
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
      'icon': Icons.arrow_downward,
      'color': Color(0xFF4CAF50),
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
      'icon': Icons.swap_horiz,
      'color': Color(0xFF2196F3),
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
      'icon': Icons.arrow_downward,
      'color': Color(0xFF4CAF50),
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
      'icon': Icons.arrow_upward,
      'color': Color(0xFFF44336),
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
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text(
          'Transactions',
          style: TextStyle(
            color: Color(0xFF1A237E),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Color(0xFF1A237E)),
            onPressed: _showSearchDialog,
          ),
          IconButton(
            icon: const Icon(Icons.filter_list, color: Color(0xFF1A237E)),
            onPressed: _showFilterOptions,
          ),
        ],
      ),
      body: Column(
        children: [
          // Statistiques rapides
          _buildQuickStats(),

          // Filtres
          _buildFilterChips(),

          // Liste des transactions
          Expanded(
            child: _buildTransactionsList(),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem('Reçus', _totalReceived, Icons.arrow_downward, Colors.green),
          _buildStatItem('Retraits', _totalWithdrawn, Icons.arrow_upward, Colors.red),
          _buildStatItem('Transferts', _totalTransferred, Icons.swap_horiz, Colors.blue),
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
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '${amount.toInt()} F',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChips() {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _filters.length,
        itemBuilder: (context, index) {
          final filter = _filters[index];
          return Container(
            margin: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(
                filter,
                style: TextStyle(
                  color: _selectedFilter == filter ? Colors.white : const Color(0xFF1A237E),
                  fontWeight: FontWeight.w500,
                ),
              ),
              selected: _selectedFilter == filter,
              onSelected: (selected) {
                setState(() {
                  _selectedFilter = filter;
                });
              },
              backgroundColor: Colors.white,
              selectedColor: const Color(0xFF1A237E),
              checkmarkColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: _selectedFilter == filter ? const Color(0xFF1A237E) : Colors.grey[300]!,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTransactionsList() {
    if (_filteredTransactions.isEmpty) {
      return _buildEmptyState();
    }

    // Grouper les transactions par date
    final Map<String, List<Map<String, dynamic>>> groupedTransactions = {};

    for (final transaction in _filteredTransactions) {
      final dateKey = transaction['date'].split(' ')[0]; // Prendre seulement la partie date
      if (!groupedTransactions.containsKey(dateKey)) {
        groupedTransactions[dateKey] = [];
      }
      groupedTransactions[dateKey]!.add(transaction);
    }

    // Trier les dates (plus récentes en premier)
    final sortedDates = groupedTransactions.keys.toList()
      ..sort((a, b) => b.compareTo(a));

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: sortedDates.length,
      itemBuilder: (context, index) {
        final date = sortedDates[index];
        final transactions = groupedTransactions[date]!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // En-tête de date
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                _formatDateHeader(date),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A237E),
                ),
              ),
            ),

            // Liste des transactions pour cette date
            ...transactions.map((transaction) =>
                _buildTransactionItem(transaction)
            ),

            const SizedBox(height: 16),
          ],
        );
      },
    );
  }

  Widget _buildTransactionItem(Map<String, dynamic> transaction) {
    final isSuccess = transaction['status'] == 'success';
    final isPending = transaction['status'] == 'pending';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icône avec statut
          Stack(
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
                  size: 24,
                ),
              ),
              if (isPending)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.schedule,
                      color: Colors.white,
                      size: 12,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),

          // Détails de la transaction
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction['clientName'],
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      transaction['typeText'],
                      style: TextStyle(
                        fontSize: 14,
                        color: transaction['color'],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 8),
                    if (isPending)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.orange.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'En attente',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.orange,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  _formatDisplayDate(transaction['date']),
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  transaction['account'],
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          // Montant et actions
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
              const SizedBox(height: 8),
              InkWell(
                onTap: () => _showTransactionDetails(transaction),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A237E).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    'Détails',
                    style: TextStyle(
                      fontSize: 10,
                      color: Color(0xFF1A237E),
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
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.receipt_long,
            size: 80,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          Text(
            _selectedFilter == 'Toutes'
                ? 'Aucune transaction'
                : 'Aucune transaction ${_selectedFilter.toLowerCase()}',
            style: const TextStyle(
              fontSize: 18,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Vos transactions apparaîtront ici',
            style: TextStyle(
              color: Colors.grey,
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Rechercher une transaction',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A237E),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Nom du client, montant...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A237E),
                    padding: const EdgeInsets.symmetric(vertical: 12),
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

  void _showFilterOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Filtrer les transactions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A237E),
              ),
            ),
            const SizedBox(height: 20),
            ..._filters.map((filter) =>
                ListTile(
                  leading: Icon(
                    _getFilterIcon(filter),
                    color: const Color(0xFF1A237E),
                  ),
                  title: Text(filter),
                  trailing: _selectedFilter == filter
                      ? const Icon(Icons.check, color: Color(0xFF1A237E))
                      : null,
                  onTap: () {
                    setState(() {
                      _selectedFilter = filter;
                    });
                    Navigator.of(context).pop();
                  },
                ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getFilterIcon(String filter) {
    switch (filter) {
      case 'Reçus':
        return Icons.arrow_downward;
      case 'Retraits':
        return Icons.arrow_upward;
      case 'Transferts':
        return Icons.swap_horiz;
      default:
        return Icons.list;
    }
  }

  void _showTransactionDetails(Map<String, dynamic> transaction) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
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
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A237E),
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
                  backgroundColor: const Color(0xFF1A237E),
                  padding: const EdgeInsets.symmetric(vertical: 12),
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
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
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
        backgroundColor: const Color(0xFF1A237E),
      ),
    );
  }
}