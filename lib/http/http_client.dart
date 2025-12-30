import 'dart:convert';
import 'package:http/http.dart' as http;

class THttpHelper {
  // URL de votre endpoint GraphQL
  //static const String _graphqlUrl = 'http://10.0.2.2:8080/graphql'; // Android Emulator
   static const String _graphqlUrl = 'http://localhost:8082/graphql'; // iOS/Web
  // static const String _graphqlUrl = 'http://192.168.1.x:8080/graphql'; // Réel device

  // URL REST (si vous avez aussi une API REST)
  static const String _restBaseUrl = 'http://127.0.0.1:8000/api';

  /// Méthode générale pour les requêtes GraphQL
  static Future<Map<String, dynamic>> graphqlQuery({
    required String query,
    Map<String, dynamic>? variables,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(_graphqlUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          ...?headers,
        },
        body: json.encode({
          'query': query,
          'variables': variables,
        }),
      );

      return _handleGraphQLResponse(response);
    } catch (e) {
      print(' Erreur GraphQL: $e');
      return {
        'success': false,
        'error': 'Erreur GraphQL: $e',
      };
    }
  }

  /// Exécute une mutation GraphQL
  static Future<Map<String, dynamic>> graphqlMutate({
    required String mutation,
    Map<String, dynamic>? variables,
    Map<String, String>? headers,
  }) async {
    return graphqlQuery(
      query: mutation,
      variables: variables,
      headers: headers,
    );
  }

  /// Gestion spécifique des réponses GraphQL
  static Map<String, dynamic> _handleGraphQLResponse(http.Response response) {
    print("📡 GraphQL Status: ${response.statusCode}");
    print("📡 GraphQL Response: ${response.body}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      try {
        final Map<String, dynamic> data = json.decode(response.body);

        // Vérifie les erreurs GraphQL
        if (data.containsKey('errors')) {
          final errors = data['errors'] as List;
          final errorMessage = errors.isNotEmpty
              ? errors[0]['message']
              : 'Erreur GraphQL inconnue';

          print(' Erreurs GraphQL: $errorMessage');
          return {
            'success': false,
            'message': errorMessage,
            'errors': errors,
          };
        }

        return {
          'success': true,
          'data': data['data'] ?? {},
        };
      } catch (e) {
        return {
          'success': false,
          'message': 'Erreur de parsing JSON: $e',
        };
      }
    } else {
      return {
        'success': false,
        'message': 'Erreur HTTP ${response.statusCode}',
        'statusCode': response.statusCode,
      };
    }
  }

  // Méthodes REST existantes (gardées pour compatibilité)
  static Future<Map<String, dynamic>> get(String endpoint) async {
    try {
      final response = await http.get(Uri.parse('$_restBaseUrl/$endpoint'));
      return _handleResponse(response);
    } catch (e) {
      print('Erreur GET: $e');
      return {'error': 'Erreur GET: $e'};
    }
  }

  static Future<Map<String, dynamic>> post(String endpoint, dynamic data) async {
    try {
      final response = await http.post(
        Uri.parse('$_restBaseUrl/$endpoint'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );
      return _handleResponse(response);
    } catch (e) {
      print('Erreur POST: $e');
      return {'error': 'Erreur POST: $e'};
    }
  }

  static Map<String, dynamic> _handleResponse(http.Response response) {
    print("Status: ${response.statusCode}");
    print("Body: ${response.body}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      return {
        'success': false,
        'message': 'Erreur ${response.statusCode}',
        'body': response.body,
      };
    }
  }
}