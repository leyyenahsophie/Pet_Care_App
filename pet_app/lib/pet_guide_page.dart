import 'package:flutter/material.dart';
import 'app_colors.dart';

class PetGuidePage extends StatefulWidget {
  const PetGuidePage({super.key});

  @override
  State<PetGuidePage> createState() => _PetGuidePageState();
}

class _PetGuidePageState extends State<PetGuidePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
          child: Column(
            children: [
              const Text(
                'PET CARE GUIDE',
                style: TextStyle(
                  color: Color(0xFF507E7F),
                  fontSize: 48,
                  fontFamily: 'Judson',
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 32),
              _buildSection(
                title: 'What to feed your rabbit?',
                children: [
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    alignment: WrapAlignment.center,
                    children: [
                      _buildFoodBlock('GRASS HAY', '80% (unlimited)'),
                      _buildFoodBlock('LEAFY GREENS', '10% (1 - 2 cups)'),
                      _buildFoodBlock('PELLETS', '5% (1/4 - 1/2 cups)'),
                      _buildFoodBlock('TREATS', '0-5% (1 - 2 tbs)'),
                    ],
                  )
                ],
              ),
              _buildSection(
                title: 'How often should you give them food and water?',
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFB9D8DA),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'A good routine is to check food and water at least twice a day—once in the morning and again in the evening',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: 'Judson',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )
                ],
              ),
              _buildSection(
                title: 'What is the best environment for your rabbit?',
                children: [
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    alignment: WrapAlignment.center,
                    children: [
                      'Dry weatherproof shelter',
                      'Exercise Space',
                      'Access to outdoors',
                      'At least 60 square feet of space',
                      'A water bowl',
                      'Toys',
                      'Dry and clean bedding',
                      'Litter tray',
                    ].map((tip) => _buildEnvBox(tip)).toList(),
                  )
                ],
              ),
              const SizedBox(height: 32),
              const Text(
                'ILLNESS SYMPTOM GUIDE',
                style: TextStyle(
                  color: Color(0xFF507E7F),
                  fontSize: 32,
                  fontFamily: 'Judson',
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 24),
              _buildIllnessSection(
                title: 'GI STASIS',
                symptoms: [
                  'Loss of appetite',
                  'Small or no droppings',
                  'Bloated belly',
                  'Tiredness'
                ],
                treatments: [
                  'Encourage hay eating',
                  'Syringe feed formula',
                  'Provide a lot of water',
                  'Belly massage',
                  'Seek a vet for pain relief'
                ],
              ),
              const SizedBox(height: 32),
              _buildIllnessSection(
                title: 'SNUFFLES',
                symptoms: [
                  'Runny nose',
                  'Sneezing',
                  'Watery eyes',
                  'Labored breathing'
                ],
                treatments: [
                  'Antibiotics',
                  'Clean environment',
                  'Good ventilation'
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required List<Widget> children}) {
    return Container(
      width: 700,
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF507E7F),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'Julius Sans One',
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildFoodBlock(String title, String percent) {
    return Container(
      width: 140,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFB9D8DA),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              fontFamily: 'Judson',
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            percent,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              fontFamily: 'Judson',
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildEnvBox(String text) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFB9D8DA),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 13,
          fontFamily: 'Judson',
        ),
      ),
    );
  }

  Widget _buildIllnessSection({
    required String title,
    required List<String> symptoms,
    required List<String> treatments,
  }) {
    return Container(
      width: 700,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF507E7F),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontFamily: 'Julius Sans One',
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildInfoColumn('Symptoms', symptoms),
              const SizedBox(width: 24),
              _buildInfoColumn('Treatment', treatments),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoColumn(String heading, List<String> items) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFB9D8DA),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              heading,
              style: const TextStyle(
                fontSize: 18,
                fontFamily: 'Judson',
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ...items.map((item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              child: Text(
                '• $item',
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'Judson',
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
