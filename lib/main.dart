import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotateAnimation;
  late Animation<double> _rotate45Animation;
  late Animation<double> _rotate60Animation;
  late Animation<Offset> _slideAnimation;
  late Animation<Offset> _slide015Animation;
  late Animation<Offset> _slide0Animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _scaleAnimation = Tween<double>(begin: 1, end: 0.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _rotateAnimation = Tween<double>(begin: 0, end: -0.3).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _rotate45Animation = Tween<double>(begin: 0, end: -0.45).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _rotate60Animation = Tween<double>(begin: 0, end: -0.60).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(begin: Offset.zero, end: Offset(1.1, -0.2)).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _slide015Animation = Tween<Offset>(begin: Offset.zero, end: Offset(1, -0.15)).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _slide0Animation = Tween<Offset>(begin: Offset.zero, end: Offset(0.9, -0.11)).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(238, 238, 238, 0.9),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Icon(Icons.close),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green),
                        shape: BoxShape.circle
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: CircleAvatar(
                        backgroundImage: AssetImage('assets/dummy.png'),
                        radius: 50,
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 18.0, top: 10),
                    child: Text('John Smith', style: TextStyle(fontSize: 28),),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 18.0, top: 3),
                    child: Text('johnsmith@gmail.com', style: TextStyle(fontSize: 18, color: Colors.grey),),
                  )
                ],
              ),


              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0, bottom: 25),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.payment),
                        SizedBox(width: 30,),
                        Text('Payment', style: TextStyle(fontSize: 18),)
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 18.0, bottom: 25),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.card_travel),
                        SizedBox(width: 30,),
                        Text('Promos', style: TextStyle(fontSize: 18),)
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 18.0, bottom: 25),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.notifications),
                        SizedBox(width: 30,),
                        Text('Notifications', style: TextStyle(fontSize: 18),)
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 18.0, bottom: 25),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.info_outline_rounded),
                        SizedBox(width: 30,),
                        Text('About Us', style: TextStyle(fontSize: 18),)
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 18.0, bottom: 25),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.star_rate_outlined),
                        SizedBox(width: 30,),
                        Text('Rate Us', style: TextStyle(fontSize: 18),)
                      ],
                    ),
                  )
                ],
              ),

              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black),

                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 18, right: 18),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.logout),
                        SizedBox(width: 10,),
                        Text('Logout', style: TextStyle(fontSize: 14),)
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),

          _AnimatedColorScreen(color: Color.fromRGBO(241, 241, 241, 0.4), controller: _controller, scaleAnimation: _scaleAnimation, rotateAnimation: _rotate60Animation, slideAnimation: _slide0Animation),

          _AnimatedColorScreen(color: Color.fromRGBO(247, 247, 247, 0.4), controller: _controller, scaleAnimation: _scaleAnimation, rotateAnimation: _rotate45Animation, slideAnimation: _slide015Animation),

          _AnimatedScreen(controller: _controller, scaleAnimation: _scaleAnimation, rotateAnimation: _rotateAnimation, slideAnimation: _slideAnimation)
        ],
      ),
    );
  }
}

class _AnimatedScreen extends StatelessWidget {
  final controller;
  final scaleAnimation;
  final rotateAnimation;
  final slideAnimation;
  const _AnimatedScreen({super.key, required this.controller, required this.scaleAnimation, required this.rotateAnimation, required this.slideAnimation});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Transform(
          transform: Matrix4.identity()
            ..scale(scaleAnimation.value)
            ..rotateZ(rotateAnimation.value),
          alignment: Alignment.center,
          child: SlideTransition(
            position: slideAnimation,
            child: child,
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25)
        ),
        clipBehavior: Clip.hardEdge,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text('Магазин'),
            leading: IconButton(
              icon: Icon(Icons.menu),
              onPressed: _toggleMenu,
            ),
          ),
          body: ListView.builder(
            itemCount: 20,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('Товар $index'),
              );
            },
          ),
        ),
      ),
    );
  }

  void _toggleMenu() {
    if (controller.isCompleted) {
      controller.reverse();
    } else {
      controller.forward();
    }
  }
}

class _AnimatedColorScreen extends StatelessWidget {
  final controller;
  final scaleAnimation;
  final rotateAnimation;
  final slideAnimation;
  final Color color;
  const _AnimatedColorScreen({super.key, required this.color, required this.controller, required this.scaleAnimation, required this.rotateAnimation, required this.slideAnimation});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Transform(
          transform: Matrix4.identity()
            ..scale(scaleAnimation.value)
            ..rotateZ(rotateAnimation.value),
          alignment: Alignment.center,
          child: SlideTransition(
            position: slideAnimation,
            child: child,
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(25)
        ),
        clipBehavior: Clip.hardEdge,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ),
      ),
    );
  }

  void _toggleMenu() {
    if (controller.isCompleted) {
      controller.reverse();
    } else {
      controller.forward();
    }
  }
}

