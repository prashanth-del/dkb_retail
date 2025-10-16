import 'package:db_uicomponents/utils.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../core/utils/ui_components/components/src/ui_shimmer.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 10,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          return UIShimmer(
            child: Container(
              height: 56,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
        },
      ),
    );
  }
}

class LoadingHorizontalWidget extends StatelessWidget {
  const LoadingHorizontalWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            ...List.generate(3, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                child: UIShimmer(
                  child: Container(
                    //color: Colors.red,
                    child: Container(
                      height: 56,
                      width: context.mediaQuery.size.width - 140,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class LoadingContainerWidget extends StatelessWidget {
  final double? height;
  final double? width;
  const LoadingContainerWidget({super.key, this.width, this.height});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(32)),
          //color: Colors.red,
          child: UIShimmer(
            child: Container(
              height: height ?? 315,
              width: width ?? 315,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LoadingButton extends StatelessWidget {
  const LoadingButton({super.key});
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 18,
      height: 18,
      child: CupertinoActivityIndicator(
        radius: 10,
        color: Color.fromRGBO(0, 0, 0, 0.3),
      ),
    );
  }
}
