import 'package:flutter/material.dart';
import 'package:marchand/screen/transaction_screen.dart';
import '../navigation/bottom_navigation.dart';

class AcceuilScreen extends StatelessWidget {
  const AcceuilScreen({super.key});

  // Palette de couleurs
  static const Color primaryColor = Color(0xFF2563EB);
  static const Color secondaryColor = Color(0xFF059669);
  static const Color accentColor = Color(0xFFEA580C);
  static const Color backgroundLight = Color(0xFFF0F9FF);
  static const Color surfaceWhite = Color(0xFFFFFFFF);
  static const Color textDark = Color(0xFF0F172A);
  static const Color textGray = Color(0xFF475569);
  static const Color successGreen = Color(0xFF059669);
  static const Color errorRed = Color(0xFFDC2626);
  static const Color warningOrange = Color(0xFFEA580C);

  List<Map<String, dynamic>> _getTodayTransactions() {
    return [
      {
        'id': '1',
        'clientName': 'Moussa Diop',
        'amount': 15000,
        'type': 'paiement',
        'time': '10:30',
        'date': '2024-01-17 10:30',
        'icon': Icons.arrow_circle_down_rounded,
        'color': successGreen,
        'typeText': 'Reçu',
        'status': 'success',
        'account': 'Orange Money',
        'phone': '+221 77 123 45 67',
        'transactionId': 'TRX001234',
      },
      {
        'id': '2',
        'clientName': 'Aminata Fall',
        'amount': 7500,
        'type': 'retrait',
        'time': '11:45',
        'date': '2024-01-17 11:45',
        'icon': Icons.arrow_circle_up_rounded,
        'color': errorRed,
        'typeText': 'Retrait',
        'status': 'success',
        'account': 'Compte Principal',
        'phone': '+221 76 987 65 43',
        'transactionId': 'TRX001235',
      },
      {
        'id': '3',
        'clientName': 'Ibrahima Ndiaye',
        'amount': 25000,
        'type': 'transfert',
        'time': '14:20',
        'date': '2024-01-17 14:20',
        'icon': Icons.swap_horiz_rounded,
        'color': primaryColor,
        'typeText': 'Transfert',
        'status': 'success',
        'account': 'Free Money',
        'phone': '+221 70 555 44 33',
        'transactionId': 'TRX001236',
      },
      {
        'id': '4',
        'clientName': 'Fatou Diagne',
        'amount': 18000,
        'type': 'paiement',
        'time': 'Hier 09:15',
        'date': '2024-01-16 09:15',
        'icon': Icons.arrow_circle_down_rounded,
        'color': successGreen,
        'typeText': 'Reçu',
        'status': 'pending',
        'account': 'Wave',
        'phone': '+221 78 111 22 33',
        'transactionId': 'TRX001237',
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundLight,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Header
            SliverAppBar(
              backgroundColor: surfaceWhite,
              elevation: 0,
              pinned: true,
              floating: true,
              title: _buildHeaderContent(),
            ),

            // Contenu principal
            SliverList(
              delegate: SliverChildListDelegate([
                // Carte solde centrée
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: _buildBalanceCard(context), // Passer le contexte
                ),

                // Actions rapides
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _buildQuickActions(context),
                ),

                // Transactions récentes
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: _buildTransactionsSection(context),
                ),

                const SizedBox(height: 20),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderContent() {
    return Row(
      children: [
        // Avatar
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [primaryColor, Color(0xFF3B82F6)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.person_rounded,
            color: Colors.white,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bonjour',
                style: TextStyle(
                  color: textGray,
                  fontSize: 12,
                ),
              ),
              Text(
                'Ond Money',
                style: TextStyle(
                  color: textDark,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),

        // Notification
        Stack(
          children: [
            IconButton(
              icon: Icon(Icons.notifications_outlined, color: textDark),
              onPressed: () {},
            ),
            Positioned(
              right: 8,
              top: 8,
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: errorRed,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBalanceCard(BuildContext context) {
    bool isBalanceHidden = true;

    return StatefulBuilder(
      builder: (context, setState) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: surfaceWhite,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // QR Code très grand à gauche
              Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  color: backgroundLight,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: primaryColor.withOpacity(0.3),
                    width: 3,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.qr_code_scanner_rounded,
                      color: primaryColor,
                      size: 198,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'SCAN ME',
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Votre QR Code',
                      style: TextStyle(
                        color: textGray,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 20),

              // Contenu à droite
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Nom de l'application
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.account_balance_wallet_rounded,
                            color: primaryColor,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Ond Money',
                          style: TextStyle(
                            color: textDark,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Section solde
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: backgroundLight,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: backgroundLight,
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Titre "Votre solde est" avec icône œil cliquable
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Votre solde est',
                                style: TextStyle(
                                  color: textGray,
                                  fontSize: 14,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isBalanceHidden = !isBalanceHidden;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withOpacity(0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    isBalanceHidden
                                        ? Icons.visibility_off_rounded
                                        : Icons.visibility_rounded,
                                    color: primaryColor,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 12),

                          // Solde masqué ou visible
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Points noirs ou montant
                              if (isBalanceHidden) ...[
                                Row(
                                  children: [
                                    for (int i = 0; i < 4; i++)
                                      Padding(
                                        padding:
                                        EdgeInsets.only(right: i < 3 ? 10 : 0),
                                        child: Container(
                                          width: 14,
                                          height: 14,
                                          decoration: BoxDecoration(
                                            color: textDark,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ] else ...[
                                Text(
                                  '125 750',
                                  style: TextStyle(
                                    color: textDark,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],

                              // Astérisques ou FCFA
                              Text(
                                isBalanceHidden ? '*******' : 'FCFA',
                                style: TextStyle(
                                  color: isBalanceHidden ? textDark : successGreen,
                                  fontSize: isBalanceHidden ? 22 : 18,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: isBalanceHidden ? 3 : 1,
                                ),
                              ),
                            ],
                          ),
                        ],
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

  Widget _buildStatItem(String title, String value, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 10,
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    final actions = [
      {
        'title': 'Scanner',
        'icon': Icons.qr_code_scanner_rounded,
        'color': primaryColor,
        'action': () {
          final bottomNavigationState = BottomNavigation.of(context);
          bottomNavigationState?.changePage(2);
        },
      },
      {
        'title': 'Recevoir',
        'icon': Icons.download_rounded,
        'color': successGreen,
        'action': () => _showReceivePaymentDialog(context),
      },
      {
        'title': 'Transférer',
        'icon': Icons.upload_rounded,
        'color': errorRed,
        'action': () => _showTransferDialog(context),
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Actions Rapides',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: textDark,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: actions.map((action) {
            return _buildActionButton(
              action['title'] as String,
              action['icon'] as IconData,
              action['color'] as Color,
              action['action'] as VoidCallback,
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildActionButton(String title, IconData icon, Color color, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: surfaceWhite,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(
                  color: textDark,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionsSection(BuildContext context) {
    final transactions = _getTodayTransactions();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Transactions récentes',
              style: TextStyle(
                fontSize: 18,
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
                'Aujourd\'hui',
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

        ...transactions.map((transaction) => _buildTransactionItem(transaction, context)),

        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              final bottomNavigationState = BottomNavigation.of(context);
              bottomNavigationState?.changePage(1);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Voir toutes les transactions'),
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionItem(Map<String, dynamic> transaction, BuildContext context) {
    final isPending = transaction['status'] == 'pending';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surfaceWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: transaction['color'].withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(transaction['icon'], color: transaction['color'], size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction['clientName'],
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: textDark,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Text(
                      transaction['typeText'],
                      style: TextStyle(
                        color: transaction['color'],
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (isPending) ...[
                      const SizedBox(width: 8),
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
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${transaction['amount']} F',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: transaction['color'],
                ),
              ),
              const SizedBox(height: 2),
              Text(
                transaction['time'],
                style: TextStyle(
                  color: textGray,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showReceivePaymentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Recevoir un paiement'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.download_rounded, size: 50, color: successGreen),
            const SizedBox(height: 16),
            const Text(
              'Montrez votre QR Code au client ou entrez le montant manuellement',
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
              backgroundColor: successGreen,
            ),
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('ENTRER MONTANT'),
          ),
        ],
      ),
    );
  }

  void _showTransferDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Transférer de l\'argent'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.upload_rounded, size: 50, color: errorRed),
            const SizedBox(height: 16),
            const Text(
              'Choisissez le destinataire et le montant à transférer',
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
              backgroundColor: errorRed,
            ),
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('CONTINUER'),
          ),
        ],
      ),
    );
  }
}