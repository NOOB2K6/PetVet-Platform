import 'package:flutter/material.dart';

class AICard extends StatelessWidget {
  const AICard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        children: [
          SizedBox(width: 20),

          Icon(Icons.smart_toy_outlined, size: 30),

          SizedBox(width: 15),

          Expanded(
            child: Text(
              'Hỏi AI về thú cưng...',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ),

          Icon(Icons.mic_none),

          SizedBox(width: 20),
        ],
      ),
    );
  }
}
