import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:widgets/QuickTransaction/quickTransaction.dart';

class AnimationSheet extends StatefulWidget {
  const AnimationSheet({Key? key}) : super(key: key);

  @override
  State<AnimationSheet> createState() => _AnimationSheetState();
}

class _AnimationSheetState extends State<AnimationSheet> {
  double _percent = 0.0;
  bool isDragged = false;
  double initialHeight = 0.0;

  checkStateDragged() {
    if (_percent > 0.5) {
      setState(() {
        isDragged = true;
      });
    } else {
      setState(() {
        isDragged = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    // handle hiding disabled search field
    checkStateDragged();
    return WillPopScope(
      onWillPop: () {
        if(_percent > 0){
          setState(() {
            _percent = 0.0;
          });
        }else{
          Platform.isAndroid ? SystemNavigator.pop() : exit(0);
        }
        //we need to return a future
        return Future.value(false);
      },
      child: Container(
        color: const Color(0xFF0D0E0E),
        child: Scaffold(
          body: Container(
            color: const Color(0xFF0D0E0E),
            child: SafeArea(
              child: Stack(
                children: [

                  /* draggable scrollable sheet*/
                  Positioned.fill(
                    child: GestureDetector(
                      onVerticalDragUpdate: (DragUpdateDetails detail) {
                        if (detail.delta.dy > 0) {
                          setState(() {
                            if (_percent < 1) _percent = _percent + 0.02;
                          });
                        } else {
                          setState(() {
                            if (_percent > 0) _percent = _percent - 0.04;
                          });
                        }
                      },
                      onVerticalDragEnd: (DragEndDetails detail){
                        if(0<_percent && _percent<0.4){
                          setState(() {
                            _percent = 0.0;
                          });
                        }
                        if(_percent>0.4 && _percent<1.0){
                          setState(() {
                            _percent = 1.0;
                          });
                        }

                      },
                    ),
                  ),

                  /* search destination */
                  Positioned(
                    left: 0.0,
                    right: 0.0,
                    top: -750 * (1 - _percent),
                    child: const QuickTransactionDialog(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

