class OnBoardModel{

  String? vectorPath;

  OnBoardModel({this.vectorPath});

  void setVectorPath(String getVectorPath){
    vectorPath = getVectorPath;
  }

  String? getVectorPath(){
    return vectorPath;
  }

}


List<OnBoardModel> getSlides(){

  List pages = [
    {"img":"onboard1.png"},
    {"img":"onboard2.png"},
    {"img":"onboard3.png"},
    {"img":"onboard4.png"},
    {"img":"onboard5.png"},
    {"img":"onboard6.png"},
    {"img":"onboard7.png"},
    {"img":"onboard8.png"},
  ];
  const String assetsPath = "assets/images/retail";
  List<OnBoardModel> slides = <OnBoardModel>[];
  OnBoardModel sliderModel = OnBoardModel();

  //Screen 1
  sliderModel.setVectorPath("$assetsPath/${pages[0]['img']}");
  slides.add(sliderModel);

  sliderModel = OnBoardModel();

  //Screen 2
  sliderModel.setVectorPath("$assetsPath/${pages[1]['img']}");
  slides.add(sliderModel);

  sliderModel = OnBoardModel();

  //Screen 3
  sliderModel.setVectorPath("$assetsPath/${pages[2]['img']}");
  slides.add(sliderModel);

  sliderModel = OnBoardModel();

  //Screen 4
  sliderModel.setVectorPath("$assetsPath/${pages[3]['img']}");
  slides.add(sliderModel);

  sliderModel = OnBoardModel();

  //Screen 5
  sliderModel.setVectorPath("$assetsPath/${pages[4]['img']}");
  slides.add(sliderModel);

  sliderModel = OnBoardModel();

  //Screen 6
  sliderModel.setVectorPath("$assetsPath/${pages[5]['img']}");
  slides.add(sliderModel);

  sliderModel = OnBoardModel();

  //Screen 7
  sliderModel.setVectorPath("$assetsPath/${pages[6]['img']}");
  slides.add(sliderModel);

  sliderModel = OnBoardModel();

  //Screen 8
  sliderModel.setVectorPath("$assetsPath/${pages[7]['img']}");
  slides.add(sliderModel);

  sliderModel = OnBoardModel();

  return slides;
}