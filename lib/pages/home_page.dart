import 'package:day16_e_commerce_ui/animation/fade_animation.dart';
import 'package:day16_e_commerce_ui/pages/shop.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  bool hide = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _scaleController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800)
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 30.0
    ).animate(_scaleController)..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: Shop()));
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/splash.jpg'),
            fit: BoxFit.cover
          )
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomRight,
              colors: [
                Colors.black.withOpacity(.9),
                Colors.black.withOpacity(.4),
              ]
            )
          ),
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FadeAnimation(1, Text("Du nouveau a Baby ", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),)),
                SizedBox(height: 20,),
                FadeAnimation(1.3, Text("Commençons avec nos arrivages de vacances", style: TextStyle(color: Colors.white, fontSize: 20),)),
                SizedBox(height: 100,),
                InkWell(
                  onTap: () {
                    setState(() {
                      hide = true;
                    });
                    _scaleController.forward();
                  },
                  child: AnimatedBuilder(
                    animation: _scaleController,
                    builder: (context, child) => Transform.scale(
                      scale: _scaleAnimation.value,
                      child: FadeAnimation(1.5, Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50)
                        ),
                        child: Center(
                          child: hide == false ? Text("Commencez", style: TextStyle(fontWeight: FontWeight.bold),) : Container(),
                        ),
                      )),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                FadeAnimation(1.7, Container(
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(50)
                  ),
                  child: Center(
                    child: Text("Crée un compte", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                  ),
                )),
                SizedBox(height: 30,),

              ],
            ),
          ),
        ),
      ),
    );
  }
}