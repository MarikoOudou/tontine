import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:tontino/services/Colors.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  Future<bool> _onWillPop() async {
    return false; //<-- SEE HERE
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.zero,
            child: AppBar(
              title: const Text(''),
            ),
          ),
          body: Container(
            color: ColorTheme.primaryColorBlue,
            child: Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: ColorTheme.primaryColorYellow,
                size: 200,
              ),
            ),
          )),
    );
  }
}
