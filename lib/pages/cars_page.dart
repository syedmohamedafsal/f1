import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'cars_detail_page.dart';

class CarsPage extends StatefulWidget {
  const CarsPage({super.key});

  @override
  State<CarsPage> createState() => _CarsPageState();
}

class _CarsPageState extends State<CarsPage> {
  final List<CarModel> cars = [
    CarModel(
      teamName: 'RedBull',
      driverName: 'Max Verstappen',
      carImage: 'assets/image/cars/Red_bull_side_view.png',
      carImage2: 'assets/image/cars/Red_Bull_RB21-bg.png',
      backgroundColorHex: '#FF0000',
      time: '1:33:20.123',
      topSpeed: 345,
      avgSpeed: 220.567,
      driverImage: 'assets/image/drivers/Max_Verstappen-bg.png',
      bestLap: 29,
      videoThumbnail: 'assets/image/cars/Red Bull RB21.jpg',
      videoUrl: 'https://www.youtube.com/watch?v=liE5D1JYJSA',
      constructor: 'Red Bull Racing',
      description:
          'The Red Bull RB21 is built on the legacy of championship-winning engineering. Designed with advanced aerodynamics including an ultra-efficient rear wing and tight sidepod packaging, the RB21 offers superior downforce and cornering stability. Featuring a reworked floor and upgraded suspension geometry, it enables Max Verstappen to push limits across varying circuits with precision.',
      wins: [
        Win(year: 2010, driver: 'Sebastian Vettel'),
        Win(year: 2011, driver: 'Sebastian Vettel'),
        Win(year: 2012, driver: 'Sebastian Vettel'),
        Win(year: 2013, driver: 'Sebastian Vettel'),
        Win(year: 2021, driver: 'Max Verstappen'),
        Win(year: 2022, driver: 'Max Verstappen'),
        Win(year: 2023, driver: 'Max Verstappen'),
      ],
    ),
    CarModel(
      teamName: 'Mercedes',
      driverName: 'George Russell',
      carImage: 'assets/image/cars/Mercidies_side_view.png',
      carImage2: 'assets/image/cars/jan-1-bg.png',
      backgroundColorHex: '#B0B0B0',
      driverImage: 'assets/image/drivers/George_Russell-bg.png',
      time: '1:35:50.443',
      topSpeed: 340,
      avgSpeed: 213.499,
      bestLap: 34,
      videoThumbnail: 'assets/image/cars/jan-1.png',
      videoUrl: 'https://www.youtube.com/watch?v=TnX7Ib0sL98',
      constructor: 'Mercedes-AMG Petronas',
      description:
          'The 2025 Mercedes W15 is a blend of innovation and evolution. With a newly refined zero-pod concept and a more aggressive front wing profile, it optimizes airflow and improves front-end grip. The car features a lightweight carbon monocoque chassis and an advanced hybrid power unit, enhancing both acceleration and energy recovery.',
      wins: [
        Win(year: 2014, driver: 'Lewis Hamilton'),
        Win(year: 2015, driver: 'Lewis Hamilton'),
        Win(year: 2016, driver: 'Nico Rosberg'),
        Win(year: 2017, driver: 'Lewis Hamilton'),
        Win(year: 2018, driver: 'Lewis Hamilton'),
        Win(year: 2019, driver: 'Lewis Hamilton'),
        Win(year: 2020, driver: 'Lewis Hamilton'),
      ],
    ),
    CarModel(
      teamName: 'Ferrari',
      driverName: 'Lewis Hamilton',
      carImage: 'assets/image/cars/ferrari_side_view.png',
      carImage2: 'assets/image/cars/Ferrari_SF_25-bg.png',
      driverImage: 'assets/image/drivers/Lewis_Hamilton-bg.png',
      backgroundColorHex: '#FF4C4C',
      time: '1:34:10.700',
      topSpeed: 342,
      avgSpeed: 218.423,
      bestLap: 30,
      videoThumbnail: 'assets/image/cars/Ferrari SF‑25.jpg',
      videoUrl: 'https://www.youtube.com/watch?v=zwkLEIjI7gM',
      constructor: 'Scuderia Ferrari',
      description:
          'The Ferrari SF-25 exudes elegance and power. It features a revised front suspension for enhanced responsiveness and a more compact rear end that increases aerodynamic efficiency. Its high-revving hybrid power unit ensures blistering pace, while the redesigned cooling inlets help manage heat more efficiently. Lewis Hamilton joins Ferrari with hopes of reviving their championship legacy.',
      wins: [
        Win(year: 2000, driver: 'Michael Schumacher'),
        Win(year: 2001, driver: 'Michael Schumacher'),
        Win(year: 2002, driver: 'Michael Schumacher'),
        Win(year: 2003, driver: 'Michael Schumacher'),
        Win(year: 2004, driver: 'Michael Schumacher'),
        Win(year: 2007, driver: 'Kimi Räikkönen'),
      ],
    ),
    CarModel(
      teamName: 'McLaren',
      driverName: 'Lando Norris',
      carImage: 'assets/image/cars/McLaren_side_view.png',
      carImage2: 'assets/image/cars/McLaren_MCL39-bg.png',
      backgroundColorHex: '#FFA500',
      time: '1:36:00.008',
      topSpeed: 338,
      driverImage: 'assets/image/drivers/Lando_Norris-bg.png',
      avgSpeed: 211.984,
      bestLap: 33,
      videoThumbnail: 'assets/image/cars/McLaren MCL39.jpg',
      videoUrl: 'https://www.youtube.com/watch?v=0Tzv6jmmXv0',
      constructor: 'McLaren Racing',
      description:
          'The McLaren MCL39 is the product of a comprehensive design overhaul. It features a narrower nose for improved aerodynamic flow and innovative rear suspension geometry for better tire management. With a lightweight chassis and enhanced balance in high-speed corners, this car allows Lando Norris to execute daring overtakes and excel in qualifying. A step forward in McLaren’s pursuit of podiums.',
      wins: [
        Win(year: 1988, driver: 'Ayrton Senna'),
        Win(year: 1989, driver: 'Alain Prost'),
        Win(year: 1998, driver: 'Mika Häkkinen'),
        Win(year: 1999, driver: 'Mika Häkkinen'),
        Win(year: 2008, driver: 'Lewis Hamilton'),
      ],
    ),
  ];

  late List<bool> _visible;
  late bool _showAppBar;

  @override
  void initState() {
    super.initState();
    _showAppBar = false;
    _visible = List<bool>.filled(cars.length, false);

    // Start app bar animation slightly before cards
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        setState(() => _showAppBar = true);
      }
    });

    _runStaggeredAnimation();
  }

  void _runStaggeredAnimation() {
    for (int i = 0; i < cars.length; i++) {
      Future.delayed(Duration(milliseconds: 300 * i), () {
        if (mounted) {
          setState(() {
            _visible[i] = true;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          AnimatedSlide(
            duration: const Duration(milliseconds: 500),
            offset: _showAppBar ? Offset.zero : const Offset(0, -0.2),
            curve: Curves.easeInOut,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 500),
              opacity: _showAppBar ? 1.0 : 0.0,
              child: const CustomAppBar(),
            ),
          ),
          ...cars.asMap().entries.map((entry) {
            int index = entry.key;
            CarModel car = entry.value;

            return AnimatedSlide(
              duration: const Duration(milliseconds: 500),
              offset: _visible[index] ? Offset.zero : const Offset(0, 0.2),
              curve: Curves.easeIn,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                opacity: _visible[index] ? 1.0 : 0.0,
                child: CarCard(car: car),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Colors.white,
      child: Row(
        children: [
          const Image(
            image: AssetImage('assets/image/drivers/f1_black-bg.png'),
            height: 50,
            width: 80,
            fit: BoxFit.cover,
          ),
          Expanded(
            child: Text(
              'F1 Cars 2025',
              style: GoogleFonts.orbitron(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class CarCard extends StatelessWidget {
  final CarModel car;

  const CarCard({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    final Color bgColor =
        Color(int.parse(car.backgroundColorHex.replaceFirst('#', '0xff')));
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CarsDetailPage(car: car),
          ),
        );
      },
      child: Container(
        height: 180,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              bottom: 60,
              child: Center(
                child: Text(
                  car.teamName.toUpperCase(),
                  style: GoogleFonts.orbitron(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: 100,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Image.asset(
                  car.carImage,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CarModel {
  final String teamName;
  final String driverName;
  final String carImage;
  final String carImage2;
  final String driverImage;
  final String backgroundColorHex;
  final String time;
  final int topSpeed;
  final double avgSpeed;
  final int bestLap;
  final String videoThumbnail;
  final String videoUrl;
  final String constructor;
  final String description;
  final List<Win> wins;

  CarModel({
    required this.teamName,
    required this.driverName,
    required this.carImage,
    required this.carImage2,
    required this.driverImage,
    required this.backgroundColorHex,
    required this.time,
    required this.topSpeed,
    required this.avgSpeed,
    required this.bestLap,
    required this.videoThumbnail,
    required this.videoUrl,
    required this.constructor,
    required this.description,
    required this.wins,
  });
}

class Win {
  final int year;
  final String driver;

  Win({required this.year, required this.driver});
}
