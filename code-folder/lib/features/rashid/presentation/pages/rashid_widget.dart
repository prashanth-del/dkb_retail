import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:dkb_retail/core/constants/asset_path/asset_path.dart';
import 'package:dkb_retail/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RashidWidget extends ConsumerStatefulWidget {
  const RashidWidget({super.key});

  @override
  _RashidWidgetState createState() => _RashidWidgetState();
}

class _RashidWidgetState extends ConsumerState<RashidWidget> {
  bool showInshadText = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(Duration(seconds: 3), () {
        setState(() {
          showInshadText = true;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final h = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        context.router.push(RashidWebviewRoute());
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.09,
        width: MediaQuery.of(context).size.width * 0.175,
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height * 0.1,
        ),
        decoration: BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
          border: Border.all(color: DefaultColors.white),
        ),
        child: SingleChildScrollView(
          child: AnimatedContainer(
            duration: Duration(milliseconds: 500),
            transform: Matrix4.translationValues(
              0,
              showInshadText ? -(h * 0.105) : 0,
              0,
            ),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Image.asset(
                  AssetPath.gif.rashidGif,
                  width: MediaQuery.of(context).size.aspectRatio * 80,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                Text(
                  "Hello I'm Rashid",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: DefaultColors.white,
                    fontSize: size.aspectRatio * 30,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
