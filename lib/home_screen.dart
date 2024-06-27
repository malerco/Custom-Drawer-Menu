import 'package:custom_drawer/grid_view_model.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin{

  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotateAnimation;
  late Animation<double> _rotate45Animation;
  late Animation<double> _rotate60Animation;
  late Animation<Offset> _slideAnimation;
  late Animation<Offset> _slide015Animation;
  late Animation<Offset> _slide0Animation;
  final PageController _pageController = PageController();

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
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(238, 238, 238, 0.9),
      body: Stack(
        children: [
          _MenuWidget(controller: _controller,),

          _AnimatedColorScreen(color: Color.fromRGBO(241, 241, 241, 0.4), controller: _controller, scaleAnimation: _scaleAnimation, rotateAnimation: _rotate60Animation, slideAnimation: _slide0Animation),

          _AnimatedColorScreen(color: Color.fromRGBO(247, 247, 247, 0.4), controller: _controller, scaleAnimation: _scaleAnimation, rotateAnimation: _rotate45Animation, slideAnimation: _slide015Animation),

          GestureDetector(
              onPanUpdate: (details) {
                if (details.delta.dx > 10) {
                  if (!_controller.isCompleted) {
                    _controller.forward();
                  }
                }
              },
              child: _HomeScreenWidget(pageController: _pageController, controller: _controller, scaleAnimation: _scaleAnimation, rotateAnimation: _rotateAnimation, slideAnimation: _slideAnimation))
        ],
      ),
    );
  }
}

class _HomeScreenWidget extends StatelessWidget {
  final pageController;
  final controller;
  final scaleAnimation;
  final rotateAnimation;
  final slideAnimation;

  const _HomeScreenWidget({super.key, required this.pageController, required this.controller, required this.scaleAnimation, required this.rotateAnimation, required this.slideAnimation});

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
            title: Text('Hello John'),
            actions: [
              IconButton(
                icon: Icon(Icons.person_2_rounded),
                onPressed: _toggleMenu,
              )
            ],
          ),
          body: Column(
            children: [
              SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search for Products, Brands and More',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),

              Expanded(
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 250,
                      child: PageView(
                        controller: pageController,
                        children: List.generate(
                          5,
                              (index) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    'assets/sale.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                        ),
                      ),
                    ),
                
                    SmoothPageIndicator(
                      controller: pageController,
                      count: 5,
                      effect: JumpingDotEffect()
                    ),
                    SizedBox(height: 16),
                
                    Expanded(child: _GridViewWidget())
                  ],
                ),
              ),
            ],
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

class _GridViewWidget extends StatelessWidget {
  _GridViewWidget({super.key});

  final items = [
    GridViewModel(name: 'Slim Fit Half-zip Polo Shirt', price: '11.99', imagePath: 'assets/item_0.png'),
    GridViewModel(name: 'Regular Fit Cotton Shorts', price: '4.99', imagePath: 'assets/item_1.png'),
    GridViewModel(name: '10-pack Regular Fit Crew-neck T-shirts', price: '42.99', imagePath: 'assets/item_2.png'),
    GridViewModel(name: 'Slim Fit Cotton Polo Shirt', price: '10.99', imagePath: 'assets/item_3.png'),
    GridViewModel(name: 'Swim Shorts', price: '8.99', imagePath: 'assets/item_4.png'),
    GridViewModel(name: 'Skinny Fit Cotton Chinos', price: '15.99', imagePath: 'assets/item_5.png'),
    GridViewModel(name: '5-pack Slim Fit T-shirts', price: '32.99', imagePath: 'assets/item_6.png'),
  ];
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: GridView.builder(
        itemCount: items.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 24,
            mainAxisSpacing: 24,
            childAspectRatio: 0.6
        ),
        itemBuilder: (context, index) {
          return _GridViewRow(imagePath: 'assets/item_$index.png', name: items[index].name, price: items[index].price,);
        },
      ),
    );
  }
}

class _GridViewRow extends StatelessWidget {
  final imagePath;
  final name;
  final price;
  const _GridViewRow({super.key, required this.imagePath, required this.name, required this.price});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            SizedBox(
              width: 150,
                height: 200,
                child: ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.asset(imagePath, fit: BoxFit.cover,))),

            Positioned(
                bottom: 10,
                right: 10,
                child: Icon(Icons.favorite_border)),

          ],
        ),

        SizedBox(height: 5,),
        
        Text(name, style: TextStyle(fontSize: 16),),

        SizedBox(height: 5,),

        Text('\$ $price', style: TextStyle(fontSize: 14),),
      ],
    );
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
}

class _MenuWidget extends StatelessWidget {
  final controller;
  const _MenuWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: InkWell(
              onTap: () {
                controller.reverse();
              },
              child: Icon(Icons.close)),
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
                  Icon(Icons.notification_important_outlined),
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
    );
  }
}

