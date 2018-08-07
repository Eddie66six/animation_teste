import 'package:flutter/material.dart';

class Header extends StatefulWidget {
  Size size;
  Header(this.size);
  @override
  State<StatefulWidget> createState() =>
      new HeaderState(size.height, size.width);
}

class HeaderState extends State<Header> with TickerProviderStateMixin {
  HeaderState(this.height, this.width);
  double height;
  double heightLogo;
  double width;
  double opacityForm = 0.0;
  AnimationController aninController;
  AnimationController aninFadeController;
  Animation<double> aninScaleDown;
  Animation<double> aninScaleUp;
  Animation<double> aninOpacity;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _init();
    aninController.forward();
    aninController.addListener(() {
      this.setState(() {
        height = aninScaleDown.value;
          heightLogo = aninScaleUp.value;
        if (aninScaleDown.status == AnimationStatus.completed) {
          aninFadeController.forward();
        }
      });
    });
    aninFadeController.addListener((){
      this.setState(() {
        opacityForm = aninOpacity.value;
      });
    });
  }

  @override
    void dispose() {
      // TODO: implement dispose
      super.dispose();
      aninController.dispose();
      aninFadeController.dispose();
    }

  @override
  Widget build(BuildContext context) {
    return new SingleChildScrollView(
        child: new Column(
      children: <Widget>[
        new Stack(
          children: <Widget>[
            new Container(
              width: width,
              height: height,
              decoration: new BoxDecoration(color: Colors.red),
              child: new Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  new Container(
                    height: heightLogo,
                    decoration: new BoxDecoration(
                        image: new DecorationImage(
                      fit: BoxFit.scaleDown,
                      image: new AssetImage("assets/images/logo.png"),
                    )),
                  )
                ],
              ),
            ),
          ],
        ),
        new Opacity(
          opacity: opacityForm,
          child: new Container(
            margin: new EdgeInsets.only(top: 20.0),
            padding: new EdgeInsets.symmetric(horizontal: 25.0),
            child: new TextField(decoration: const InputDecoration(hintText: "E-mail"),),
          ),
        ),
        new Opacity(
          opacity: opacityForm,
          child: new Container(
            margin: new EdgeInsets.only(top: 20.0),
            padding: new EdgeInsets.symmetric(horizontal: 25.0),
            child: new TextField(decoration: const InputDecoration(hintText: "Senha"), obscureText: true,),
          ),
        ),
        new Opacity(
          opacity: opacityForm,
          child: new Container(
            margin: new EdgeInsets.only(top: 20.0),
            child: new RaisedButton(
              child: new Text("Vamos lá"),
              onPressed: () {},
            )
          )
        ),
      ],
    ));
  }

  void _init() {
    aninController = new AnimationController(
        vsync: this, duration: const Duration(seconds: 2));
    aninScaleDown =
        new Tween(begin: height, end: height / 3).chain(new CurveTween(curve: Curves.fastOutSlowIn)).animate(aninController);
    aninScaleUp = new Tween(begin: 10.0, end: 100.0).animate(aninController);

    aninFadeController = new AnimationController(
        vsync: this, duration: const Duration(seconds: 2));
        aninOpacity = new Tween(begin: 0.0, end: 1.0).animate(aninFadeController);
  }
}
