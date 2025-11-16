import 'package:flutter/material.dart';

class AcceuilScreen extends StatelessWidget {
  const AcceuilScreen({super.key});

  // Simulation des données
  List<Map<String, dynamic>> _getTodayTransactions() {
    return [
      {
        'id': '1',
        'clientName': 'Moussa Diop',
        'amount': 15000,
        'type': 'paiement',
        'time': '10:30',
        'icon': Icons.arrow_downward,
        'color': Color(0xFF4CAF50),
        'typeText': 'Reçu',
      },
      {
        'id': '2',
        'clientName': 'Aminata Fall',
        'amount': 7500,
        'type': 'retrait',
        'time': '11:45',
        'icon': Icons.arrow_upward,
        'color': Color(0xFFF44336),
        'typeText': 'Retrait',
      },
      {
        'id': '3',
        'clientName': 'Ibrahima Ndiaye',
        'amount': 25000,
        'type': 'transfert',
        'time': '14:20',
        'icon': Icons.swap_horiz,
        'color': Color(0xFF2196F3),
        'typeText': 'Transfert',
      },
      {
        'id': '4',
        'clientName': 'Fatou Diagne',
        'amount': 18000,
        'type': 'paiement',
        'time': 'Hier 09:15',
        'icon': Icons.arrow_downward,
        'color': Color(0xFF4CAF50),
        'typeText': 'Reçu',
      },
      {
        'id': '5',
        'clientName': 'Jean Mendy',
        'amount': 12000,
        'type': 'retrait',
        'time': 'Hier 16:40',
        'icon': Icons.arrow_upward,
        'color': Color(0xFFF44336),
        'typeText': 'Retrait',
      },
      {
        'id': '6',
        'clientName': 'Marie Sarr',
        'amount': 30000,
        'type': 'paiement',
        'time': 'Aujourd\'hui 08:20',
        'icon': Icons.arrow_downward,
        'color': Color(0xFF4CAF50),
        'typeText': 'Reçu',
      },
    ];
  }

  List<Map<String, dynamic>> _getRecurrentClients() {
    return [
      {
        'name': 'Moussa Diop',
        'lastTransaction': '15 min',
        'totalTransactions': 12,
        'initials': 'MD',
        'avatarColor': Colors.blue,
      },
      {
        'name': 'Aminata Fall',
        'lastTransaction': '2h',
        'totalTransactions': 8,
        'initials': 'AF',
        'avatarColor': Colors.green,
      },
      {
        'name': 'Ibrahima Ndiaye',
        'lastTransaction': '1j',
        'totalTransactions': 15,
        'initials': 'IN',
        'avatarColor': Colors.orange,
      },
      {
        'name': 'Fatou Diagne',
        'lastTransaction': '1j',
        'totalTransactions': 6,
        'initials': 'FD',
        'avatarColor': Colors.purple,
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bienvenue',
              style: TextStyle(
                color: Color(0xFF1A237E),
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
            Text(
              'Boutique Alimentation',
              style: TextStyle(
                color: Color(0xFF1A237E),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          // Badge de notification simplifié
          Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF1A237E),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.notifications,
              color: Colors.white,
              size: 20,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Carte Solde Principal
            _buildBalanceCard(),
            const SizedBox(height: 20),

            // Actions principales simplifiées
            _buildQuickActions(context),
            const SizedBox(height: 20),

            // Transactions récentes (liste complète)
            _buildRecentTransactions(),
            const SizedBox(height: 20),

            // Clients habituels
            //_buildRegularCustomers(),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1A237E), Color(0xFF303F9F)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Icône de solde
          const Icon(
            Icons.account_balance_wallet,
            color: Colors.white,
            size: 40,
          ),
          const SizedBox(height: 10),

          // Texte simple
          const Text(
            'Votre Argent',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 5),

          // Solde en gros
          const Text(
            '125 750 FCFA',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),

          // Résumé simple
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildSimpleStat('Entrées', '45 000 F', Icons.arrow_downward, Colors.green),
              _buildSimpleStat('Sorties', '15 000 F', Icons.arrow_upward, Colors.red),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSimpleStat(String title, String value, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(height: 5),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 12),
          child: Text(
            'Actions Rapides',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A237E),
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: _buildBigActionButton(
                'Scanner\nQR Code',
                Icons.qr_code_scanner,
                const Color(0xFF1A237E),
                onTap: () => _scanQRCode(context),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildBigActionButton(
                'Recevoir\nPaiement',
                Icons.payment,
                const Color(0xFF4CAF50),
                onTap: () => _receivePayment(context),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBigActionButton(String text, IconData icon, Color color, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 30),
            const SizedBox(height: 8),
            Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentTransactions() {
    final transactions = _getTodayTransactions();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 12),
          child: Text(
            'Historique des Transactions',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A237E),
            ),
          ),
        ),
        transactions.isEmpty
            ? _buildEmptyState('Aucune transaction aujourd\'hui', Icons.receipt)
            : Column(
          children: transactions.map((transaction) =>
              _buildSimpleTransactionItem(transaction)
          ).toList(),
        ),
      ],
    );
  }

  Widget _buildSimpleTransactionItem(Map<String, dynamic> transaction) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icône colorée
          Container(
            padding: const EdgeInsets.all(10),
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
          const SizedBox(width: 12),

          // Détails simplifiés
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
                Text(
                  transaction['typeText'],
                  style: TextStyle(
                    fontSize: 14,
                    color: transaction['color'],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          // Montant et heure
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
              Text(
                transaction['time'],
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }



  Widget _buildEmptyState(String message, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.grey, size: 48),
          const SizedBox(height: 12),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  // Actions simplifiées
  void _scanQRCode(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Row(
          children: [
            Icon(Icons.qr_code_scanner, color: Color(0xFF1A237E)),
            SizedBox(width: 10),
            Text('Scanner QR Code'),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Icon(Icons.camera_alt, size: 60, color: Colors.grey),
                const SizedBox(height: 16),
                const Text(
                  'Dirigez la caméra vers le QR Code du client',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1A237E),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('COMMENCER LE SCAN'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _receivePayment(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Recevoir Paiement'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.payment, size: 50, color: Colors.green),
            SizedBox(height: 16),
            Text(
              'Montrez votre QR Code au client\nou entrez le montant manuellement',
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('ANNULER'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
            ),
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('ENTRER MONTANT'),
          ),
        ],
      ),
    );
  }
}