import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:marchand/auth/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _nomBoutiqueController = TextEditingController();
  final _telephoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;
  bool _hasImage = false;
  bool _isTermsAccepted = false;
  bool _showPasswordStrength = false;
  File? _selectedImageFile;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  final Color primaryBlue = const Color(0xFF2563EB);
  final Color primaryLightBlue = const Color(0xFF3B82F6);
  final Color primaryOrange = const Color(0xFFEA580C);
  final Color lightBlue = const Color(0xFFE0F2FE);
  final Color successGreen = const Color(0xFF10B981);
  final Color errorRed = const Color(0xFFEF4444);
  final Color surfaceWhite = const Color(0xFFFFFFFF);
  final Color textDark = const Color(0xFF0F172A);
  final Color textGray = const Color(0xFF64748B);

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
    _nomBoutiqueController.dispose();
    _telephoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1024,
      maxHeight: 1024,
      imageQuality: 90,
    );

    if (pickedFile != null) {
      setState(() {
        _selectedImageFile = File(pickedFile.path);
        _hasImage = true;
      });
      _showImageSuccess();
    }
  }

  Future<void> _takePhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1024,
      maxHeight: 1024,
      imageQuality: 90,
    );

    if (pickedFile != null) {
      setState(() {
        _selectedImageFile = File(pickedFile.path);
        _hasImage = true;
      });
      _showImageSuccess();
    }
  }

  void _showImageSuccess() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: successGreen,
        content: Row(
          children: [
            const Icon(Icons.check_circle_rounded, color: Colors.white, size: 20),
            const SizedBox(width: 10),
            Text(
              'Photo ajoutée avec succès !',
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

  void _removeImage() {
    setState(() {
      _selectedImageFile = null;
      _hasImage = false;
    });
  }

  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.45,
          minChildSize: 0.3,
          maxChildSize: 0.6,
          builder: (context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: surfaceWhite,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 30,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 12),
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        Text(
                          'Ajouter une photo',
                          style: GoogleFonts.poppins(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: textDark,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Choisissez comment ajouter votre photo',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: textGray,
                          ),
                        ),
                        const SizedBox(height: 32),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildImageOptionCard(
                              icon: Icons.camera_alt_rounded,
                              label: 'Caméra',
                              color: primaryBlue,
                              onTap: () {
                                Navigator.pop(context);
                                _takePhoto();
                              },
                            ),
                            _buildImageOptionCard(
                              icon: Icons.photo_library_rounded,
                              label: 'Galerie',
                              color: primaryOrange,
                              onTap: () {
                                Navigator.pop(context);
                                _pickImage();
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),

                        Container(
                          width: double.infinity,
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
                              onTap: () => Navigator.pop(context),
                              borderRadius: BorderRadius.circular(16),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Center(
                                  child: Text(
                                    'ANNULER',
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: textGray,
                                    ),
                                  ),
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
      },
    );
  }

  Widget _buildImageOptionCard({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.3),
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            shape: const CircleBorder(),
            child: InkWell(
              onTap: onTap,
              customBorder: const CircleBorder(),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      color.withOpacity(0.9),
                      color.withOpacity(0.7),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: color.withOpacity(0.4),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Icon(
                  icon,
                  size: 40,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: textDark,
          ),
        ),
      ],
    );
  }

  String? _validateNomBoutique(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez entrer le nom de votre boutique';
    }
    if (value.length < 3) {
      return 'Le nom doit contenir au moins 3 caractères';
    }
    return null;
  }

  String? _validateTelephone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez entrer votre numéro de téléphone';
    }
    final regex = RegExp(r'^(77|76|70|78|75)\d{7}$');
    if (!regex.hasMatch(value.replaceAll(' ', ''))) {
      return 'Format invalide (ex: 77 123 45 67)';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez créer un mot de passe sécurisé';
    }
    if (value.length < 6) {
      return 'Minimum 6 caractères requis';
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Ajoutez une majuscule';
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Ajoutez un chiffre';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value != _passwordController.text) {
      return 'Les mots de passe ne correspondent pas';
    }
    return null;
  }

  void _handleSignUp() async {
    if (!_formKey.currentState!.validate() || !_isTermsAccepted) {
      if (!_isTermsAccepted) {
        _showErrorSnackBar('Veuillez accepter les conditions d\'utilisation');
      }
      return;
    }

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() => _isLoading = false);
    _showSuccessDialog();
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: errorRed,
        content: Row(
          children: [
            const Icon(Icons.error_outline_rounded, color: Colors.white, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: GoogleFonts.poppins(color: Colors.white),
              ),
            ),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(20),
      ),
    );
  }

  void _showSuccessDialog() {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.7),
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (context, animation, secondaryAnimation) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: animation,
            child: Dialog(
              insetPadding: const EdgeInsets.all(20),
              backgroundColor: Colors.transparent,
              elevation: 0,
              child: Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      surfaceWhite,
                      lightBlue.withOpacity(0.5),
                    ],
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
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [successGreen, const Color(0xFF34D399)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: successGreen.withOpacity(0.4),
                            blurRadius: 30,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.check_rounded,
                        color: Colors.white,
                        size: 60,
                      ),
                    ),
                    const SizedBox(height: 32),

                    Text(
                      'Félicitations ! 🎉',
                      style: GoogleFonts.poppins(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: textDark,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 16),

                    Text(
                      'Votre boutique a été créée avec succès. Préparez-vous à gérer vos finances facilement.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: textGray,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 32),

                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          colors: [primaryBlue, primaryLightBlue],
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
                        borderRadius: BorderRadius.circular(20),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                          borderRadius: BorderRadius.circular(20),
                          child: Padding(
                            padding: const EdgeInsets.all(18),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Commencer l\'aventure',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                const Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 20),
                              ],
                            ),
                          ),
                        ),
                      ),
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

  @override
  Widget build(BuildContext context) {
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
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  child: Opacity(
                    opacity: _fadeAnimation.value,
                    child: Transform.scale(
                      scale: _scaleAnimation.value,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // En-tête avec animation
                          Row(
                            children: [
                              // Bouton retour avec effet
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: surfaceWhite,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      blurRadius: 15,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(16),
                                  child: InkWell(
                                    onTap: _isLoading ? null : () => Navigator.pop(context),
                                    borderRadius: BorderRadius.circular(16),
                                    child: const Icon(
                                      Icons.arrow_back_ios_new_rounded,
                                      color: Color(0xFF2563EB),
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                              const Spacer(),

                              // Animation du logo
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 500),
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      primaryBlue.withOpacity(0.1),
                                      primaryLightBlue.withOpacity(0.05),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: primaryBlue.withOpacity(0.2),
                                    width: 1.5,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [primaryBlue, primaryLightBlue],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: const Icon(
                                        Icons.account_balance_wallet_rounded,
                                        color: Colors.white,
                                        size: 14,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      "Ond Money",
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryBlue,
                                        letterSpacing: -0.3,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),

                          // Titre avec effet de glissement
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Démarrez",
                                style: GoogleFonts.poppins(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w800,
                                  color: textDark,
                                  letterSpacing: -1,
                                  height: 1,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "votre boutique",
                                    style: GoogleFonts.poppins(
                                      fontSize: 32,
                                      fontWeight: FontWeight.w800,
                                      color: textDark,
                                      letterSpacing: -1,
                                      height: 1,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [primaryBlue, primaryLightBlue],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      "PRO",
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),

                          Text(
                            "Rejoignez des milliers de commerçants qui transforment leur business",
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              color: textGray,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 40),

                          // Section photo avec effet de carte
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: surfaceWhite,
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 25,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                              border: Border.all(
                                color: Colors.grey.withOpacity(0.1),
                                width: 1,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: primaryBlue.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Icon(
                                        Icons.camera_alt_rounded,
                                        color: primaryBlue,
                                        size: 20,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      "Identité de votre boutique",
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: textDark,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  "Une belle photo augmente la confiance de vos clients",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: textGray,
                                  ),
                                ),
                                const SizedBox(height: 20),

                                // Zone d'upload avec effet de profondeur
                                GestureDetector(
                                  onTap: _hasImage ? null : _showImagePickerOptions,
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    height: 160,
                                    decoration: BoxDecoration(
                                      color: _hasImage ? Colors.transparent : lightBlue.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: _hasImage ? Colors.transparent : primaryBlue.withOpacity(0.3),
                                        width: 2,
                                      ),
                                      boxShadow: _hasImage
                                          ? []
                                          : [
                                        BoxShadow(
                                          color: primaryBlue.withOpacity(0.1),
                                          blurRadius: 20,
                                          offset: const Offset(0, 8),
                                        ),
                                      ],
                                      gradient: _hasImage
                                          ? null
                                          : LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          surfaceWhite,
                                          lightBlue.withOpacity(0.5),
                                        ],
                                      ),
                                    ),
                                    child: _hasImage && _selectedImageFile != null
                                        ? Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(18),
                                          child: Image.file(
                                            _selectedImageFile!,
                                            width: double.infinity,
                                            height: double.infinity,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        // Overlay avec bouton
                                        Positioned.fill(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  Colors.transparent,
                                                  Colors.black.withOpacity(0.2),
                                                ],
                                              ),
                                              borderRadius: BorderRadius.circular(18),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 16,
                                          right: 16,
                                          child: Container(
                                            padding: const EdgeInsets.all(12),
                                            decoration: BoxDecoration(
                                              color: surfaceWhite,
                                              shape: BoxShape.circle,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black.withOpacity(0.1),
                                                  blurRadius: 10,
                                                  offset: const Offset(0, 4),
                                                ),
                                              ],
                                            ),
                                            child: GestureDetector(
                                              onTap: _removeImage,
                                              child: Icon(
                                                Icons.delete_rounded,
                                                color: errorRed,
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 16,
                                          left: 16,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 16,
                                              vertical: 8,
                                            ),
                                            decoration: BoxDecoration(
                                              color: successGreen.withOpacity(0.9),
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Icon(Icons.check_rounded, size: 14, color: Colors.white),
                                                const SizedBox(width: 6),
                                                Text(
                                                  'Photo ajoutée',
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                        : Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.add_photo_alternate_rounded,
                                          size: 48,
                                          color: primaryBlue,
                                        ),
                                        const SizedBox(height: 12),
                                        Text(
                                          'Ajouter une photo',
                                          style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: textDark,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'Cliquez pour sélectionner',
                                          style: GoogleFonts.poppins(
                                            fontSize: 13,
                                            color: textGray,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 40),

                          // Formulaire
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                _buildInputField(
                                  label: 'Nom de la boutique',
                                  controller: _nomBoutiqueController,
                                  icon: Icons.storefront_rounded,
                                  validator: _validateNomBoutique,
                                ),
                                const SizedBox(height: 20),
                                _buildPhoneField(),
                                const SizedBox(height: 20),
                                _buildPasswordField(),
                                const SizedBox(height: 20),
                                _buildConfirmPasswordField(),
                              ],
                            ),
                          ),

                          // Indicateur de force du mot de passe
                          if (_showPasswordStrength && _passwordController.text.isNotEmpty)
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 500),
                              margin: const EdgeInsets.only(top: 20),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: surfaceWhite,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.03),
                                    blurRadius: 15,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: _buildPasswordStrengthIndicator(),
                            ),

                          // Conditions d'utilisation avec effet
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.only(top: 30),
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: surfaceWhite,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: _isTermsAccepted ? successGreen.withOpacity(0.3) : Colors.grey.withOpacity(0.1),
                                width: _isTermsAccepted ? 2 : 1,
                              ),
                              boxShadow: _isTermsAccepted
                                  ? [
                                BoxShadow(
                                  color: successGreen.withOpacity(0.1),
                                  blurRadius: 20,
                                  offset: const Offset(0, 5),
                                ),
                              ]
                                  : [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.03),
                                  blurRadius: 15,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Checkbox animé
                                GestureDetector(
                                  onTap: () {
                                    setState(() => _isTermsAccepted = !_isTermsAccepted);
                                  },
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    width: 28,
                                    height: 28,
                                    decoration: BoxDecoration(
                                      color: _isTermsAccepted ? successGreen : surfaceWhite,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: _isTermsAccepted ? successGreen : Colors.grey[400]!,
                                        width: 2,
                                      ),
                                      boxShadow: _isTermsAccepted
                                          ? [
                                        BoxShadow(
                                          color: successGreen.withOpacity(0.3),
                                          blurRadius: 10,
                                          spreadRadius: 0,
                                        ),
                                      ]
                                          : [],
                                    ),
                                    child: _isTermsAccepted
                                        ? const Icon(
                                      Icons.check_rounded,
                                      color: Colors.white,
                                      size: 18,
                                    )
                                        : null,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: RichText(
                                    text: TextSpan(
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        color: textGray,
                                        height: 1.6,
                                      ),
                                      children: [
                                        const TextSpan(text: 'En cochant cette case, j\'accepte les '),
                                        TextSpan(
                                          text: 'Conditions d\'utilisation',
                                          style: GoogleFonts.poppins(
                                            color: primaryBlue,
                                            fontWeight: FontWeight.w600,
                                            decoration: TextDecoration.underline,
                                          ),
                                        ),
                                        const TextSpan(text: ' et la '),
                                        TextSpan(
                                          text: 'Politique de confidentialité',
                                          style: GoogleFonts.poppins(
                                            color: primaryBlue,
                                            fontWeight: FontWeight.w600,
                                            decoration: TextDecoration.underline,
                                          ),
                                        ),
                                        const TextSpan(text: ' d\'Ond Money.'),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 40),

                          // Bouton d'inscription avec effet
                          Material(
                            borderRadius: BorderRadius.circular(20),
                            elevation: 0,
                            child: Container(
                              height: 68,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(
                                  colors: _isTermsAccepted
                                      ? [primaryBlue, primaryLightBlue]
                                      : [Colors.grey[300]!, Colors.grey[400]!],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                boxShadow: _isTermsAccepted
                                    ? [
                                  BoxShadow(
                                    color: primaryBlue.withOpacity(0.4),
                                    blurRadius: 30,
                                    offset: const Offset(0, 15),
                                  ),
                                ]
                                    : [],
                              ),
                              child: Material(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(20),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(20),
                                  onTap: _isLoading || !_isTermsAccepted ? null : _handleSignUp,
                                  child: Stack(
                                    children: [
                                      // Effet de brillance
                                      Center(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            if (_isLoading)
                                              SizedBox(
                                                width: 24,
                                                height: 24,
                                                child: CircularProgressIndicator(
                                                  strokeWidth: 2,
                                                  valueColor: AlwaysStoppedAnimation<Color>(
                                                    Colors.white,
                                                  ),
                                                ),
                                              )
                                            else ...[
                                              Icon(
                                                Icons.rocket_launch_rounded,
                                                color: Colors.white,
                                                size: 22,
                                              ),
                                              const SizedBox(width: 12),
                                              Text(
                                                "Lancer ma boutique",
                                                style: GoogleFonts.poppins(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white,
                                                  letterSpacing: 0.5,
                                                ),
                                              ),
                                            ],
                                          ],
                                        ),
                                      ),
                                      // Badge de vérification
                                      if (_isTermsAccepted && !_isLoading)
                                        Positioned(
                                          right: 20,
                                          child: Container(
                                            padding: const EdgeInsets.all(6),
                                            decoration: BoxDecoration(
                                              color: Colors.white.withOpacity(0.2),
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(
                                              Icons.arrow_forward_rounded,
                                              color: Colors.white,
                                              size: 18,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 30),

                          // Lien de connexion avec effet
                          Center(
                            child: Material(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                              child: InkWell(
                                onTap: _isLoading ? null : (){
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const LoginScreen(),
                                    ),
                                  );
                                },
                                borderRadius: BorderRadius.circular(12),
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: RichText(
                                    text: TextSpan(
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        color: textGray,
                                      ),
                                      children: [
                                        const TextSpan(text: 'Déjà inscrit ? '),
                                        TextSpan(
                                          text: 'Se connecter',
                                          style: GoogleFonts.poppins(
                                            color: primaryBlue,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    bool obscureText = false,
    Widget? suffixIcon,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        enabled: !_isLoading,
        validator: validator,
        style: GoogleFonts.poppins(
          fontSize: 16,
          color: textDark,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: label,
          hintStyle: GoogleFonts.poppins(
            fontSize: 16,
            color: textGray.withOpacity(0.6),
          ),
          filled: true,
          fillColor: surfaceWhite,
          prefixIcon: Container(
            margin: const EdgeInsets.only(right: 12),
            width: 56,
            child: Center(
              child: Icon(
                icon,
                color: primaryBlue,
                size: 20,
              ),
            ),
          ),
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.grey[300]!, width: 1.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.grey[300]!, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: primaryBlue, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: errorRed, width: 1.5),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: errorRed, width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 0,
          ),
          errorStyle: GoogleFonts.poppins(
            fontSize: 12,
            color: errorRed,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneField() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextFormField(
        controller: _telephoneController,
        keyboardType: TextInputType.phone,
        enabled: !_isLoading,
        validator: _validateTelephone,
        style: GoogleFonts.poppins(
          fontSize: 16,
          color: textDark,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: 'Numéro de téléphone',
          hintStyle: GoogleFonts.poppins(
            fontSize: 16,
            color: textGray.withOpacity(0.6),
          ),
          filled: true,
          fillColor: surfaceWhite,
          prefixIcon: Container(
            margin: const EdgeInsets.only(right: 12),
            width: 56,
            child: Center(
              child: Icon(
                Icons.phone_iphone_rounded,
                color: primaryBlue,
                size: 20,
              ),
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.grey[300]!, width: 1.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.grey[300]!, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: primaryBlue, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: errorRed, width: 1.5),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: errorRed, width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 0,
          ),
          errorStyle: GoogleFonts.poppins(
            fontSize: 12,
            color: errorRed,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextFormField(
        controller: _passwordController,
        obscureText: _obscurePassword,
        enabled: !_isLoading,
        validator: _validatePassword,
        onChanged: (value) {
          setState(() {
            _showPasswordStrength = true;
          });
        },
        style: GoogleFonts.poppins(
          fontSize: 16,
          color: textDark,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: 'Mot de passe',
          hintStyle: GoogleFonts.poppins(
            fontSize: 16,
            color: textGray.withOpacity(0.6),
          ),
          filled: true,
          fillColor: surfaceWhite,
          prefixIcon: Container(
            margin: const EdgeInsets.only(right: 12),
            width: 56,
            child: Center(
              child: Icon(
                Icons.lock_rounded,
                color: primaryBlue,
                size: 20,
              ),
            ),
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
                _showPasswordStrength = true;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              width: 40,
              child: Center(
                child: Icon(
                  _obscurePassword ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                  color: primaryBlue,
                  size: 20,
                ),
              ),
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.grey[300]!, width: 1.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.grey[300]!, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: primaryBlue, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: errorRed, width: 1.5),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: errorRed, width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 0,
          ),
          errorStyle: GoogleFonts.poppins(
            fontSize: 12,
            color: errorRed,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildConfirmPasswordField() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextFormField(
        controller: _confirmPasswordController,
        obscureText: _obscureConfirmPassword,
        enabled: !_isLoading,
        validator: _validateConfirmPassword,
        style: GoogleFonts.poppins(
          fontSize: 16,
          color: textDark,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: 'Confirmer le mot de passe',
          hintStyle: GoogleFonts.poppins(
            fontSize: 16,
            color: textGray.withOpacity(0.6),
          ),
          filled: true,
          fillColor: surfaceWhite,
          prefixIcon: Container(
            margin: const EdgeInsets.only(right: 12),
            width: 56,
            child: Center(
              child: Icon(
                Icons.lock_reset_rounded,
                color: primaryBlue,
                size: 20,
              ),
            ),
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() => _obscureConfirmPassword = !_obscureConfirmPassword);
            },
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              width: 40,
              child: Center(
                child: Icon(
                  _obscureConfirmPassword ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                  color: primaryBlue,
                  size: 20,
                ),
              ),
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.grey[300]!, width: 1.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.grey[300]!, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: primaryBlue, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: errorRed, width: 1.5),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: errorRed, width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 0,
          ),
          errorStyle: GoogleFonts.poppins(
            fontSize: 12,
            color: errorRed,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordStrengthIndicator() {
    final password = _passwordController.text;
    int strength = 0;
    List<String> requirements = [];

    if (password.isNotEmpty) {
      if (password.length >= 8) {
        strength++;
        requirements.add('✓ 8+ caractères');
      } else {
        requirements.add('✗ 8+ caractères');
      }

      if (password.contains(RegExp(r'[A-Z]'))) {
        strength++;
        requirements.add('✓ Majuscule');
      } else {
        requirements.add('✗ Majuscule');
      }

      if (password.contains(RegExp(r'[0-9]'))) {
        strength++;
        requirements.add('✓ Chiffre');
      } else {
        requirements.add('✗ Chiffre');
      }

      if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
        strength++;
        requirements.add('✓ Caractère spécial');
      } else {
        requirements.add('✗ Caractère spécial');
      }
    }

    String getStrengthText() {
      if (strength == 0) return 'Très faible';
      if (strength == 1) return 'Faible';
      if (strength == 2) return 'Moyen';
      if (strength == 3) return 'Fort';
      return 'Très fort';
    }

    Color getStrengthColor() {
      if (strength == 0) return errorRed;
      if (strength == 1) return errorRed;
      if (strength == 2) return primaryOrange;
      if (strength == 3) return primaryBlue;
      return successGreen;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Sécurité du mot de passe',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: textDark,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: getStrengthColor().withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    margin: const EdgeInsets.only(right: 6),
                    decoration: BoxDecoration(
                      color: getStrengthColor(),
                      shape: BoxShape.circle,
                    ),
                  ),
                  Text(
                    getStrengthText(),
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: getStrengthColor(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Barre de progression avec effet
        Container(
          height: 8,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            children: List.generate(4, (index) {
              return Expanded(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  margin: EdgeInsets.only(right: index < 3 ? 4 : 0),
                  decoration: BoxDecoration(
                    color: index < strength ? getStrengthColor() : Colors.transparent,
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: index < strength
                        ? [
                      BoxShadow(
                        color: getStrengthColor().withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ]
                        : [],
                  ),
                ),
              );
            }),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '$strength/4 critères remplis',
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: textGray,
          ),
        ),
        const SizedBox(height: 16),

        // Grille des exigences
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: requirements.map((req) {
            final isMet = req.startsWith('✓');
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: isMet ? successGreen.withOpacity(0.1) : errorRed.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isMet ? successGreen.withOpacity(0.2) : errorRed.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isMet ? Icons.check_circle_rounded : Icons.circle_rounded,
                    color: isMet ? successGreen : errorRed,
                    size: 14,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    req.substring(2), // Enlever le ✓ ou ✗
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: isMet ? successGreen : errorRed,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}