import 'package:flutter/material.dart';
import '../firebase/firebase_upload_service.dart';


class FirebaseUploadScreen extends StatefulWidget {
  const FirebaseUploadScreen({super.key});

  @override
  State<FirebaseUploadScreen> createState() => _FirebaseUploadScreenState();
}

class _FirebaseUploadScreenState extends State<FirebaseUploadScreen> {
  bool _isLoading = false;
  String _statusMessage = '';
  int _characterCount = 0;

  @override
  void initState() {
    super.initState();
    _getCharacterCount();
  }

  Future<void> _getCharacterCount() async {
    try {
      final count = await FirebaseUploadService.getCharacterCount();
      setState(() {
        _characterCount = count;
      });
    } catch (e) {
      print('Errore contando personaggi: $e');
    }
  }

  Future<void> _uploadAllCharacters() async {
    setState(() {
      _isLoading = true;
      _statusMessage = 'Caricamento di tutti i personaggi...';
    });

    try {
      await FirebaseUploadService.uploadCharactersToFirebase();
      setState(() {
        _statusMessage = '✅ Caricamento completato con successo!';
      });
      await _getCharacterCount();
    } catch (e) {
      setState(() {
        _statusMessage = '❌ Errore durante il caricamento: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _uploadNewCharactersOnly() async {
    setState(() {
      _isLoading = true;
      _statusMessage = 'Caricamento solo nuovi personaggi...';
    });

    try {
      await FirebaseUploadService.uploadNewCharactersOnly();
      setState(() {
        _statusMessage = '✅ Caricamento selettivo completato!';
      });
      await _getCharacterCount();
    } catch (e) {
      setState(() {
        _statusMessage = '❌ Errore durante il caricamento selettivo: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _deleteAllCharacters() async {
    // Mostra dialog di conferma
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('⚠️ Attenzione'),
        content: const Text(
          'Sei sicuro di voler eliminare TUTTI i personaggi da Firebase? '
              'Questa azione non può essere annullata.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Annulla'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Elimina Tutto'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      setState(() {
        _isLoading = true;
        _statusMessage = 'Eliminazione di tutti i personaggi...';
      });

      try {
        await FirebaseUploadService.deleteAllCharacters();
        setState(() {
          _statusMessage = '🗑️ Tutti i personaggi sono stati eliminati';
        });
        await _getCharacterCount();
      } catch (e) {
        setState(() {
          _statusMessage = '❌ Errore durante l\'eliminazione: $e';
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Upload Manager'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Status Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Stato Firebase',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Text('Personaggi su Firebase: $_characterCount'),
                    if (_statusMessage.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text(
                        _statusMessage,
                        style: TextStyle(
                          color: _statusMessage.contains('❌')
                              ? Colors.red
                              : Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Upload Buttons
            Text(
              'Operazioni di Caricamento',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),

            ElevatedButton.icon(
              onPressed: _isLoading ? null : _uploadAllCharacters,
              icon: const Icon(Icons.upload),
              label: const Text('Carica Tutti i Personaggi'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),

            const SizedBox(height: 12),

            ElevatedButton.icon(
              onPressed: _isLoading ? null : _uploadNewCharactersOnly,
              icon: const Icon(Icons.upload_outlined),
              label: const Text('Carica Solo Nuovi Personaggi'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),

            const SizedBox(height: 24),

            // Dangerous Operations
            Text(
              'Operazioni Pericolose',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 16),

            ElevatedButton.icon(
              onPressed: _isLoading ? null : _deleteAllCharacters,
              icon: const Icon(Icons.delete_forever),
              label: const Text('Elimina Tutti i Personaggi'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),

            const SizedBox(height: 24),

            // Refresh Button
            ElevatedButton.icon(
              onPressed: _isLoading ? null : _getCharacterCount,
              icon: const Icon(Icons.refresh),
              label: const Text('Aggiorna Conteggio'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[600],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),

            if (_isLoading) ...[
              const SizedBox(height: 24),
              const Center(
                child: CircularProgressIndicator(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// Esempio di come chiamare il servizio da altre parti dell'app
class QuickUploadExample {

  // Metodo semplice per caricare tutti i personaggi
  static Future<void> quickUploadAll() async {
    try {
      await FirebaseUploadService.uploadCharactersToFirebase();
      print('✅ Caricamento completato!');
    } catch (e) {
      print('❌ Errore: $e');
    }
  }

  // Metodo per caricare solo i nuovi
  static Future<void> quickUploadNew() async {
    try {
      await FirebaseUploadService.uploadNewCharactersOnly();
      print('✅ Caricamento nuovi personaggi completato!');
    } catch (e) {
      print('❌ Errore: $e');
    }
  }

  // Esempio di come ottenere personaggi da Firebase invece che dal JSON
  static Future<void> useFirebaseInsteadOfLocal() async {
    try {
      // Invece di usare ApiService.getCharacters()
      final characters = await FirebaseUploadService.getCharactersFromFirebase();
      print('Caricati ${characters.length} personaggi da Firebase');

      // Ora puoi usare i personaggi come prima
      for (var character in characters) {
        print('${character.name} - ${character.element} - ${character.rarity}⭐');
      }

    } catch (e) {
      print('Errore caricando da Firebase: $e');
      // Fallback al JSON locale
      print('Usando fallback al JSON locale...');
      // Qui potresti chiamare il tuo ApiService.getCharacters() esistente
    }
  }
}