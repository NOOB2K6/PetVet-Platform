import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class AIScreen extends StatefulWidget {
  const AIScreen({super.key});

  @override
  State<AIScreen> createState() => _AIScreenState();
}

class _AIScreenState extends State<AIScreen> {
  final SpeechToText _speechToText = SpeechToText();

  final TextEditingController _textController = TextEditingController();

  final List<String> _history = [];

  bool _speechEnabled = false;
  bool _isLoadingHistory = true;

  @override
  void initState() {
    super.initState();

    _initializeSpeech();
    _loadHistory();
  }

  // =========================
  // SPEECH TO TEXT
  // =========================

  Future<void> _initializeSpeech() async {
    final available = await _speechToText.initialize(
      onStatus: (status) {
        if (mounted) {
          setState(() {});
        }
      },
      onError: (error) {
        debugPrint('Speech error: ${error.errorMsg}');
      },
    );

    if (!mounted) return;

    setState(() {
      _speechEnabled = available;
    });
  }

  Future<void> _startListening() async {
    if (!_speechEnabled) {
      return;
    }

    await _speechToText.listen(
      onResult: _onSpeechResult,

      listenFor: const Duration(seconds: 30),

      pauseFor: const Duration(seconds: 3),

      partialResults: true,
    );

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _stopListening() async {
    await _speechToText.stop();

    if (mounted) {
      setState(() {});
    }
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _textController.text = result.recognizedWords;

      _textController.selection = TextSelection.fromPosition(
        TextPosition(offset: _textController.text.length),
      );
    });

    // Chỉ lưu khi câu nói đã hoàn thành
    if (result.finalResult && result.recognizedWords.trim().isNotEmpty) {
      _saveHistory(result.recognizedWords.trim());
    }
  }

  // =========================
  // HISTORY
  // =========================

  Future<void> _loadHistory() async {
    final prefs = SharedPreferencesAsync();

    final data = await prefs.getStringList('ai_chat_history');

    if (!mounted) return;

    setState(() {
      _history.clear();

      if (data != null) {
        _history.addAll(data);
      }

      _isLoadingHistory = false;
    });
  }

  Future<void> _saveHistory(String text) async {
    final cleanText = text.trim();

    if (cleanText.isEmpty) {
      return;
    }

    // Không lưu trùng câu liên tiếp
    if (_history.isNotEmpty && _history.first == cleanText) {
      return;
    }

    setState(() {
      _history.insert(0, cleanText);
    });

    // Giới hạn 50 lịch sử
    if (_history.length > 50) {
      _history.removeLast();
    }

    final prefs = SharedPreferencesAsync();

    await prefs.setStringList('ai_chat_history', _history);
  }

  Future<void> _clearHistory() async {
    final prefs = SharedPreferencesAsync();

    await prefs.remove('ai_chat_history');

    if (!mounted) return;

    setState(() {
      _history.clear();
    });
  }

  // =========================
  // UI
  // =========================

  @override
  Widget build(BuildContext context) {
    final bool isListening = _speechToText.isListening;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Trợ lý AI',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),

        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            tooltip: 'Lịch sử',
            onPressed: _showHistory,
          ),
        ],
      ),

      body: SafeArea(
        child: Column(
          children: [
            // =========================
            // NỘI DUNG
            // =========================
            Expanded(child: _buildChatArea()),

            // =========================
            // Ô NHẬP
            // =========================
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      minLines: 1,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: isListening
                            ? 'Đang nghe...'
                            : 'Nhập câu hỏi...',
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(isListening ? Icons.stop : Icons.mic),
                          onPressed: isListening
                              ? _stopListening
                              : _startListening,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: _sendMessage,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatArea() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.smart_toy_outlined, size: 70),

            const SizedBox(height: 20),

            const Text(
              'Xin chào! 👋',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            const Text(
              'Bạn có thể nói hoặc nhập câu hỏi\n'
              'về thú cưng của mình.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 15),
            ),

            const SizedBox(height: 25),

            if (!_speechEnabled)
              const Text(
                'Speech recognition chưa sẵn sàng',
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }

  // =========================
  // SEND
  // =========================

  Future<void> _sendMessage() async {
    final text = _textController.text.trim();

    if (text.isEmpty) {
      return;
    }

    await _saveHistory(text);

    _textController.clear();

    // Chưa gọi AI thật.
    // Sau này sẽ đưa text vào AI API ở đây.
  }

  // =========================
  // HISTORY UI
  // =========================

  void _showHistory() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SafeArea(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.75,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 12, 10),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Lịch sử trò chuyện',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      if (_history.isNotEmpty)
                        IconButton(
                          icon: const Icon(Icons.delete_outline),
                          onPressed: () async {
                            await _clearHistory();

                            if (context.mounted) {
                              Navigator.pop(context);
                            }
                          },
                        ),
                    ],
                  ),
                ),

                const Divider(),

                Expanded(
                  child: _isLoadingHistory
                      ? const Center(child: CircularProgressIndicator())
                      : _history.isEmpty
                      ? const Center(child: Text('Chưa có lịch sử trò chuyện'))
                      : ListView.separated(
                          padding: const EdgeInsets.all(16),
                          itemCount: _history.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 8),
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: const CircleAvatar(
                                child: Icon(Icons.person_outline),
                              ),
                              title: Text(_history[index]),
                              tileColor: Colors.grey.shade100,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              onTap: () {
                                _textController.text = _history[index];

                                Navigator.pop(context);
                              },
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
