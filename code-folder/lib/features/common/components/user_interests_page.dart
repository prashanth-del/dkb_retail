import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:dkb_retail/core/utils/extensions/locale_extension.dart';
import 'package:dkb_retail/features/registration/presentation/widget/reg_success_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class UserInterestsPage extends ConsumerStatefulWidget {
  const UserInterestsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UserInterestsPageState();
}

class _UserInterestsPageState extends ConsumerState<UserInterestsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userInterests = [
      {"title": "Travel", "checked": false, "image": image},
      {"title": "Credit Card", "checked": false, "image": image},
      {"title": "Shopping", "checked": false, "image": image},
      {"title": "Investments", "checked": false, "image": image},
    ];
  }

  String image =
      'https://imgs.search.brave.com/CDdfcG0K2nNxshgkPE8ZeVaxNAmLSLxx9FPSLPzOBM0/rs:fit:500:0:1:0/g:ce/aHR0cHM6Ly9tZWRp/YS5pc3RvY2twaG90/by5jb20vaWQvMjE5/NDI3MzEwMS9waG90/by9taWFtaS1iZWFj/aC1mbG9yaWRhLXNl/YWd1bGxzLndlYnA_/YT0xJmI9MSZzPTYx/Mng2MTImdz0wJms9/MjAmYz1FTnhkVHFi/cTQteXJQckx5Ynls/QzhDd2VUODIyclpM/Q1NKV0s3WlNtNWtz/PQ';

  List userInterests = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: DefaultColors.white,
      body: UiBackgroundWrapper(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UiSpace.vertical(40),
            CommonAuthAppBar(
              title: ref.getLocaleString(
                "What Are Your Interests?",
                defaultValue: "What Are Your Interests?",
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                ),
                itemCount: userInterests.length,
                itemBuilder: (_, index) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: DefaultColors.skyBlue,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: UiTextNew.b14Medium(
                                userInterests[index]['title'],
                              ),
                            ),
                            Checkbox.adaptive(
                              value: userInterests[index]['checked'],
                              onChanged: (value) {
                                setState(() {
                                  userInterests[index]['checked'] =
                                      !userInterests[index]['checked'];
                                });
                              },
                            ),
                          ],
                        ),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    userInterests[index]['image'],
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              width: double.infinity,
              child: UIButton.rounded(
                height: 48,
                btnCurve: 30,

                backgroundColor: DefaultColors.blue9D,
                onPressed: () {
                  // context.router.push(SetPasswordRoute());
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => RegSuccessPage()),
                  );
                },
                label: ref.getLocaleString(
                  'Complete Registration',
                  defaultValue: 'Complete Registration',
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => RegSuccessPage()),
                );
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 20),
                width: double.infinity,
                child: Center(
                  child: UiTextNew.h5Medium(
                    ref.getLocaleString(
                      'Skip For now',
                      defaultValue: 'Skip For now',
                    ),
                    color: DefaultColors.blue9D,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Center(
                child: UiTextNew.b3Medium(
                  'You can set your interest later once you login',
                  color: DefaultColors.grey_05,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
