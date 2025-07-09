import 'dart:async';
import 'package:f1/pages/driver_detail_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DriverPage extends StatefulWidget {
  const DriverPage({super.key});

  @override
  State<DriverPage> createState() => _DriverPageState();
}

class _DriverPageState extends State<DriverPage> with TickerProviderStateMixin {
  final List<Map<String, dynamic>> drivers = [
    {
      'rank': '1',
      'firstName': 'Lewis',
      'lastName': 'Hamilton',
      'points': '104',
      'team': 'Ferrari',
      'image': 'assets/image/drivers/lewis-removebg-preview.png',
      'color': Colors.red,
      'bio':
          'Lewis Hamilton is a British racing driver widely considered one of the greatest Formula 1 drivers in history. He began his F1 career in 2007 with McLaren and quickly rose to prominence. Known for his incredible speed, consistency, and tire management, Hamilton has broken numerous records, including most career wins and pole positions.',
      'careerStatus': {
        'Grand Prix Entered': '368',
        'Career Points': '4965.5',
        'Highest Race Finish': '1 (x105)',
        'Podiums': '202',
        'Highest Grid Position': '1 (x104)',
        'Pole Positions': '104',
        'World Championships': '7',
        'DNFs': '32',
      },
    },
    {
      'rank': '2',
      'firstName': 'Max',
      'lastName': 'Verstappen',
      'points': '85',
      'team': 'Red Bull Racing',
      'image': 'assets/image/drivers/Max_Verstappen-bg.png',
      'color': Colors.blue,
      'bio':
          'Max Verstappen, a Dutch racing phenomenon, is known for his aggressive yet calculated driving style. Debuting in Formula 1 at just 17 years old, he became the youngest race winner in F1 history. Verstappen has dominated recent seasons with Red Bull, clinching multiple world titles with record-breaking performances.',
      'careerStatus': {
        'Grand Prix Entered': '221',
        'Career Points': '3188.5',
        'Highest Race Finish': '1 (x65)',
        'Podiums': '117',
        'Highest Grid Position': '1 (x44)',
        'Pole Positions': '44',
        'World Championships': '4',
        'DNFs': '31',
      },
    },
    {
      'rank': '3',
      'firstName': 'George',
      'lastName': 'Russell',
      'points': '78',
      'team': 'Mercedes',
      'image': 'assets/image/drivers/George_Russell-bg.png',
      'color': Colors.teal,
      'bio':
          'George Russell is a British driver recognized for his strong technical feedback and adaptability. After a stellar junior career, he made his F1 debut with Williams and impressed with his consistency and raw pace. Now racing for Mercedes, Russell has quickly established himself as a title contender of the future.',
      'careerStatus': {
        'Grand Prix Entered': '140',
        'Career Points': '861',
        'Highest Race Finish': '1 (x4)',
        'Podiums': '20',
        'Highest Grid Position': '1 (x6)',
        'Pole Positions': '6',
        'World Championships': '0',
        'DNFs': '24',
      },
    },
    {
      'rank': '4',
      'firstName': 'Lando',
      'lastName': 'Norris',
      'points': '70',
      'team': 'McLaren',
      'image': 'assets/image/drivers/Lando_Norris-bg.png',
      'color': Colors.orange,
      'bio':
          'Lando Norris, a British driver racing for McLaren, is known for his exciting racing style and charismatic personality. He quickly became a fan favorite for his performances on the track and his engaging presence off it. Norris continues to impress as one of the sport\'s brightest young talents.',
      'careerStatus': {
        'Grand Prix Entered': '140',
        'Career Points': '1233',
        'Highest Race Finish': '1 (x7)',
        'Podiums': '36',
        'Highest Grid Position': '1 (x12)',
        'Pole Positions': '12',
        'World Championships': '0',
        'DNFs': '22',
      },
    },

    // New Drivers below

    {
      'rank': '5',
      'firstName': 'Oscar',
      'lastName': 'Piastri',
      'points': '40',
      'team': 'McLaren',
      'image': 'assets/image/drivers/Oscar-bg.png',
      'color': Colors.orange,
      'bio':
          'Oscar Piastri is an Australian racing driver and one of the most promising young talents in Formula 1. He won the FIA Formula 2 Championship before making his debut in F1. Known for his smooth driving style and sharp racecraft, Piastri is expected to become a key player in the sport\'s future.',
      'careerStatus': {
        'Grand Prix Entered': '20',
        'Career Points': '40',
        'Highest Race Finish': '4',
        'Podiums': '0',
        'Highest Grid Position': '5',
        'Pole Positions': '0',
        'World Championships': '0',
        'DNFs': '3',
      },
    },
    {
      'rank': '6',
      'firstName': 'Kimi',
      'lastName': 'Räikkönen',
      'points': '45',
      'team': 'Alfa Romeo',
      'image': 'assets/image/drivers/Kimi-bg.png',
      'color': Colors.red.shade700,
      'bio':
          'Kimi Räikkönen, nicknamed "The Iceman," is a Finnish F1 legend known for his cool demeanor and aggressive driving style. He is the 2007 World Champion and has driven for multiple teams over his long career, including Ferrari and Alfa Romeo. Kimi is beloved for his straightforward personality and incredible racecraft.',
      'careerStatus': {
        'Grand Prix Entered': '349',
        'Career Points': '1878',
        'Highest Race Finish': '1 (x21)',
        'Podiums': '103',
        'Highest Grid Position': '1 (x18)',
        'Pole Positions': '18',
        'World Championships': '1',
        'DNFs': '55',
      },
    },
    {
      'rank': '7',
      'firstName': 'Yuki',
      'lastName': 'Tsunoda',
      'points': '25',
      'team': 'AlphaTauri',
      'image': 'assets/image/drivers/yuki-bg.png',
      'color': Colors.deepPurple,
      'bio':
          'Yuki Tsunoda is a Japanese racing driver known for his aggressive and exciting driving style. He made his F1 debut with AlphaTauri and quickly became known for his overtaking skills and competitive spirit. Tsunoda is seen as a rising star with strong potential for growth.',
      'careerStatus': {
        'Grand Prix Entered': '30',
        'Career Points': '25',
        'Highest Race Finish': '6',
        'Podiums': '0',
        'Highest Grid Position': '9',
        'Pole Positions': '0',
        'World Championships': '0',
        'DNFs': '6',
      },
    },
    {
      'rank': '8',
      'firstName': 'Charles',
      'lastName': 'Leclerc',
      'points': '72',
      'team': 'Ferrari',
      'image': 'assets/image/drivers/charles-bg.png',
      'color': Colors.red,
      'bio':
          'Charles Leclerc is a talented Monegasque driver racing for Ferrari. Known for his exceptional qualifying pace and racecraft, Leclerc has quickly become one of the leading young drivers in Formula 1. He aims to bring Ferrari back to championship-winning form.',
      'careerStatus': {
        'Grand Prix Entered': '89',
        'Career Points': '565',
        'Highest Race Finish': '1 (x4)',
        'Podiums': '16',
        'Highest Grid Position': '1 (x9)',
        'Pole Positions': '9',
        'World Championships': '0',
        'DNFs': '17',
      },
    },
  ];

  List<bool> _animated = [];

  @override
  void initState() {
    super.initState();
    _animated =
        List.generate(drivers.length + 2, (index) => false); // +2 for header
    _startAnimations();
  }

  void _startAnimations() async {
    for (int i = 0; i < _animated.length; i++) {
      await Future.delayed(const Duration(milliseconds: 150));
      if (mounted) {
        setState(() {
          _animated[i] = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            const SizedBox(height: 12),
            AnimatedOpacity(
              opacity: _animated[0] ? 1 : 0,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn,
              child: AnimatedSlide(
                offset: _animated[0] ? Offset.zero : const Offset(0, 0.3),
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/image/drivers/f1_black-bg.png',
                      height: 30,
                      width: 120,
                      fit: BoxFit.cover,
                    ),
                    const Icon(Icons.menu, color: Colors.black),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            AnimatedOpacity(
              opacity: _animated[1] ? 1 : 0,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn,
              child: AnimatedSlide(
                offset: _animated[1] ? Offset.zero : const Offset(0, 0.3),
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, bottom: 24.0),
                  child: Text(
                    'Drivers',
                    style: GoogleFonts.orbitron(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            ...List.generate(drivers.length, (index) {
              return AnimatedOpacity(
                opacity: _animated[index + 2] ? 1 : 0, // shifted by 2
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeIn,
                child: AnimatedSlide(
                  offset:
                      _animated[index + 2] ? Offset.zero : const Offset(0, 0.3),
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  child: _buildDriverCard(drivers[index]),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildDriverCard(Map<String, dynamic> driver) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      driver['rank'],
                      style: GoogleFonts.orbitron(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      driver['firstName'],
                      style: GoogleFonts.orbitron(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      driver['lastName'],
                      style: GoogleFonts.orbitron(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: driver['color'],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Stack(
                    children: [
                      Positioned(
                        top: -15,
                        right: -10,
                        left: -20,
                        bottom: -130,
                        child: Transform.scale(
                          scale: 1.0,
                          child: Image.asset(
                            driver['image'],
                            fit: BoxFit.cover,
                            alignment: Alignment.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const Divider(),
          const SizedBox(height: 6),
          Row(
            children: [
              Wrap(
                spacing: 6,
                runSpacing: 4,
                children: [
                  _buildTag('${driver['points']} PTS'),
                  _buildTag(driver['team']),
                  _buildTag('Bio'),
                ],
              ),
              const Spacer(),
              IconButton(
                icon: Icon(
                  CupertinoIcons.arrow_down_right,
                  color: Colors.white.withOpacity(0.7),
                  size: 30,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DriverDetailPage(driver: driver),
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 6),
        ],
      ),
    );
  }

  Widget _buildTag(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: GoogleFonts.orbitron(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
