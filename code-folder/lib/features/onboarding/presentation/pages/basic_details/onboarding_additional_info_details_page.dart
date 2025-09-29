import 'package:auto_route/auto_route.dart';
// import 'package:country_list/country_list.dart';
import 'package:country_state_city/country_state_city.dart';
import 'package:db_uicomponents/components.dart';
import 'package:db_uicomponents/src/components/retail/ui_header_subheader_retail.dart';
import 'package:db_uicomponents/src/components/retail/ui_label_dropdown_retail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/router/app_router.dart';
import '../../../../common/components/auto_leading_widget.dart';
import '../../../../common/dialog/ui_dialogs.dart';
import '../../controller/notifier/onboarding_save_stage_data_notifier.dart';
import '../../provider/onboarding_provider.dart';

@RoutePage()
class OnboardingAdditionalInfoDetailsPage extends ConsumerStatefulWidget {
  const OnboardingAdditionalInfoDetailsPage({super.key});

  @override
  ConsumerState<OnboardingAdditionalInfoDetailsPage> createState() =>
      _OnboardingAdditionalInfoDetailsPageState();
}

class _OnboardingAdditionalInfoDetailsPageState
    extends ConsumerState<OnboardingAdditionalInfoDetailsPage> {
  String selectedCountry = "";
  String selectedMaritalStatus = "";

  List<Country> countries = [];
  List<Country> filteredCountries = [];
  List<City> cities = [];
  List<City> filteredCities = [];

  String searchQuery = "";
  final TextEditingController _searchController = TextEditingController();
  List<String> employmentStatus = [
    "Please Select",
    "Employed Full-Time",
    "Employed Part-Time",
    "Self-Employed",
    "Unemployed",
    "Student",
    "Retired",
    "Homemaker",
    "other",
  ];
  List<String> filteredEmploymentStatus = [];
  List<String> professionStatus = [
    "Please Select",
    "Engineer",
    "Doctor",
    "Teacher",
    "Software Developer",
    "Accountant",
    "Architect",
    "Designer",
    "Lawyer",
    "Nurse",
    "Marketing Specialist",
    "Salesperson",
    "Scientist",
    "Writer",
    "Other",
  ];
  List<String> filteredProfessionStatus = [];

  bool isCountryEmpty = false;
  bool isEmploymentStatusEmpty = false;
  bool isProfessionStatusEmpty = false;

  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  TextEditingController employmentStatusController = TextEditingController();
  TextEditingController professionStatusController = TextEditingController();
  TextEditingController otherEmployeeController = TextEditingController();
  TextEditingController designationJobController = TextEditingController();
  TextEditingController employeeNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadCountries();
  }

  Future<void> loadCountries() async {
    try {
      final countryList = await getAllCountries();
      setState(() {
        countries = countryList;
      });
    } catch (e) {
      print("Error fetching countries: $e");
    }
  }

  Future<void> fetchCities(String countryIso2) async {
    try {
      final cityList = await getCountryCities(
        countryIso2,
      ); //await CountryStateCity.getCityList(countryIso2, stateIso2);
      setState(() {
        cities = cityList;
      });
    } catch (e) {
      print("Error fetching cities: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentStage = getStageById(ref, "IDENTIFICATION_INFO");

    return Scaffold(
      appBar: UIAppBar.secondary(
        autoLeadingWidget: AutoLeadingWidget(),
        title: "Identification",
        appBarColor: DefaultColors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UiHeaderSubHeaderRetail(
                      title: "Additional Info Details",
                      description: "Fill out the information below",
                    ),
                    SizedBox(height: 20),
                    _buildCountryListUi(context),
                    SizedBox(height: 20),
                    _buildCityListUi(context),

                    // UiLabelDropdownRetail(
                    //   label: "City of Birth",
                    //   options: ["Please Select","1","2"],
                    // ),
                    SizedBox(height: 20),
                    UiLabelDropdownRetail(
                      label: "Marital Status",
                      options: ["Please Select", "Married", "Unmarried"],
                      onChanged: (String? value) {
                        setState(() {
                          selectedMaritalStatus = ((value == 'Please Select')
                              ? ''
                              : value)!;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    _buildEmploymentStatusUi(context),
                    SizedBox(height: 20),
                    // UiLabelDropdownRetail(
                    //   label: "Profession",
                    //   options: ["Please Select","1","2"],
                    // ),
                    //
                  ],
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: UIButton.rounded(
                label: 'CONTINUE',
                isDisabled:
                    countryController.text.isEmpty ||
                    cityController.text.isEmpty ||
                    employmentStatusController.text.isEmpty ||
                    selectedMaritalStatus.isEmpty ||
                    (otherEmployeeController.text.isEmpty &&
                        employmentStatusController.text.toLowerCase() ==
                            "other") ||
                    (!getEmploymentStatusStudHomeRetired() &&
                        (professionStatusController.text.isEmpty ||
                            designationJobController.text.isEmpty ||
                            employeeNameController.text.isEmpty)),
                width: double.infinity,
                onPressed: () async {
                  bool value = await ref
                      .read(onboardingSaveStageDataNotifierProvider.notifier)
                      .fetch(
                        custJourneyId: ref.watch(customerJourneyId),
                        stageId: "${currentStage?.stageId}",
                        data: {
                          "Country_of_birth": countryController.text,
                          "City_of_Birth": cityController.text,
                          "Marital_status": selectedMaritalStatus,
                          "EmploymentStatus": employmentStatusController.text,
                          "Profession": professionStatusController.text,
                          "Other_employee_status": otherEmployeeController.text,
                          "Designation_Job": designationJobController.text,
                          "Employee_name": employeeNameController.text,
                        },
                      );

                  if (value == true) {
                    context.router.push(OnboardingAddressDetailsRoute());
                  } else {
                    UiDialogs.showErrorDialog(
                      context: context,
                      description: "Data Not Saved",
                      bknOkPressed: () {
                        context.router.maybePop();
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool getEmploymentStatusStudHomeRetired() {
    String text = employmentStatusController.text.toLowerCase();
    return text == "student" || text == "homemaker" || text == "retired";
  }

  Widget _buildCountryListUi(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UiTextNew.h4Regular('Country of Birth', color: DefaultColors.white_800),
        const SizedBox(height: 8),
        // if(countries.length > 5)
        UIFormTextField.outlined(
          hintText: "Please Select",
          labelHintTextStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            fontFamily: 'Rubik',
            color: DefaultColors.grayB3,
          ),

          borderColor: DefaultColors.grayE6,
          controller: countryController,
          suffixIcon: IconButton(
            onPressed: () {
              _showCountryBottomSheet(context);
            },
            icon: Icon(
              Icons.keyboard_arrow_down,
              color: DefaultColors.blue9D,
              size: 30,
            ),
          ),
          labelTextStyle: const TextStyle(
            fontSize: 14,
            fontFamily: 'Rubik',
            fontWeight: FontWeight.w500,
            color: DefaultColors.white_800,
          ),
          validator: (value) {
            if (value == null || value.isEmpty || value == "Please Select") {
              return "This field is required";
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildCityListUi(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UIFormTextField.outlined(
          hintText: "Please Select",
          labelHintTextStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            fontFamily: 'Rubik',
            color: DefaultColors.grayB3,
          ),
          labelUiText: UiTextNew.h4Regular(
            "City of Birth",
            color: DefaultColors.white_800,
          ),
          borderColor: DefaultColors.grayE6,
          controller: cityController,
          suffixIcon: IconButton(
            onPressed: () {
              selectedCountry.isNotEmpty
                  ? _showCityBottomSheet(context)
                  : ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Please Select Country before"),
                        backgroundColor: Colors.red,
                      ),
                    );
            },
            icon: Icon(
              Icons.keyboard_arrow_down,
              color: DefaultColors.blue9D,
              size: 30,
            ),
          ),
          labelTextStyle: const TextStyle(
            fontSize: 14,
            fontFamily: 'Rubik',
            fontWeight: FontWeight.w500,
            color: DefaultColors.white_800,
          ),
          validator: (value) {
            if (value == null || value.isEmpty || value == "Please Select") {
              return "This field is required";
            }
            return null;
          },
        ),
      ],
    );
  }

  void _showCountryBottomSheet(BuildContext context) {
    return UiBottomSheet.customSheet(
      showBottomButton: false,
      context: context,
      title: "Country of Birth",
      child: _buildCountryList(),
    );
  }

  void _showCityBottomSheet(BuildContext context) {
    return UiBottomSheet.customSheet(
      showBottomButton: false,
      context: context,
      title: "City of Birth",
      child: _buildCityList(),
    );
  }

  Widget _buildCountryList() {
    String searchQuery = _searchController.text.toLowerCase();

    if (searchQuery.isEmpty) {
      filteredCountries = countries;
    } else {
      String normalize(String value) {
        return value
            .replaceAll(',', '')
            .replaceAll(' ', ' ')
            .replaceAll("-", "")
            .replaceAll(".", "")
            .toLowerCase();
      }

      final normalizedQuery = normalize(searchQuery);
      setState(() {
        filteredCountries = countries.where((data) {
          final name = normalize(data.name ?? '');
          return name.contains(normalizedQuery);
        }).toList();
      });
    }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: Column(
        children: [
          UiSearch(
            hintText: "Search",
            controller: _searchController,
            onChanged: (query) {
              setState(() {});
            },
          ),
          SizedBox(height: 15),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: GestureDetector(
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: DefaultColors.grayE6.withOpacity(0.5),
                          //Color(0xFFECE6F0)
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: UiTextNew.customRubik(
                          'Please Select',
                          fontSize: 16,
                          color: DefaultColors.black,
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        setState(() {
                          isCountryEmpty = true;
                          countryController.text = '';
                          selectedCountry = '';
                        });
                      },
                    ), // Render each transaction tile
                  ),

                  // SizedBox(height: 15,),
                  ValueListenableBuilder(
                    valueListenable: _searchController,
                    builder: (context, TextEditingValue queryValue, _) {
                      final searchQuery = queryValue.text.toLowerCase();
                      final filteredCountries = countries.where((country) {
                        final name = country.name.toLowerCase();
                        return name.contains(searchQuery);
                      }).toList();
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: filteredCountries.length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          Country country = filteredCountries[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: GestureDetector(
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: DefaultColors.grayE6.withOpacity(0.5),
                                  //Color(0xFFECE6F0)
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: UiTextNew.customRubik(
                                  country.name,
                                  fontSize: 16,
                                  color: DefaultColors.black,
                                ),
                              ),
                              onTap: () {
                                Navigator.pop(context);
                                setState(() {
                                  isCountryEmpty = false;
                                  countryController.text =
                                      country.name == 'Please Select'
                                      ? ''
                                      : country.name;
                                  selectedCountry = country.isoCode;
                                  fetchCities(selectedCountry);
                                  cityController.text = '';
                                });
                              },
                            ), // Render each transaction tile
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCityList() {
    String searchQuery = _searchController.text.toLowerCase();

    if (searchQuery.isEmpty) {
      filteredCities = cities;
    } else {
      String normalize(String value) {
        return value
            .replaceAll(',', '')
            .replaceAll(' ', ' ')
            .replaceAll("-", "")
            .replaceAll(".", "")
            .toLowerCase();
      }

      final normalizedQuery = normalize(searchQuery);
      setState(() {
        filteredCities = cities.where((data) {
          final name = normalize(data.name ?? '');
          return name.contains(normalizedQuery);
        }).toList();
      });
    }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: Column(
        children: [
          UiSearch(
            hintText: "Search",
            controller: _searchController,
            onChanged: (query) {
              setState(() {});
            },
          ),
          SizedBox(height: 15),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: GestureDetector(
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: DefaultColors.grayE6.withOpacity(0.5),
                          //Color(0xFFECE6F0)
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: UiTextNew.customRubik(
                          'Please Select',
                          fontSize: 16,
                          color: DefaultColors.black,
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        setState(() {
                          cityController.text = '';
                        });
                      },
                    ), // Render each transaction tile
                  ),

                  // SizedBox(height: 15,),
                  ValueListenableBuilder(
                    valueListenable: _searchController,
                    builder: (context, TextEditingValue queryValue, _) {
                      final searchQuery = queryValue.text.toLowerCase();
                      final filteredCities = cities.where((city) {
                        final name = city.name.toLowerCase();
                        return name.contains(searchQuery);
                      }).toList();
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: filteredCities.length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          City city = filteredCities[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: GestureDetector(
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: DefaultColors.grayE6.withOpacity(0.5),
                                  //Color(0xFFECE6F0)
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: UiTextNew.customRubik(
                                  city.name,
                                  fontSize: 16,
                                  color: DefaultColors.black,
                                ),
                              ),
                              onTap: () {
                                Navigator.pop(context);
                                setState(() {
                                  isCountryEmpty = false;
                                  cityController.text =
                                      city.name == 'Please Select'
                                      ? ''
                                      : city.name;
                                });
                              },
                            ), // Render each transaction tile
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmploymentStatusUi(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UiTextNew.h4Regular(
          'Employment Status',
          color: DefaultColors.white_800,
        ),
        const SizedBox(height: 8),
        // if(countries.length > 5)
        UIFormTextField.outlined(
          hintText: "Please Select",
          labelHintTextStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            fontFamily: 'Rubik',
            color: DefaultColors.grayB3,
          ),

          borderColor: DefaultColors.grayE6,
          controller: employmentStatusController,
          suffixIcon: IconButton(
            onPressed: () {
              _showEmploymentStatusBottomSheet(context);
            },
            icon: Icon(
              Icons.keyboard_arrow_down,
              color: DefaultColors.blue9D,
              size: 30,
            ),
          ),
          labelTextStyle: const TextStyle(
            fontSize: 14,
            fontFamily: 'Rubik',
            fontWeight: FontWeight.w500,
            color: DefaultColors.white_800,
          ),
          validator: (value) {
            if (value == null || value.isEmpty || value == "Please Select") {
              return "This field is required";
            }
            return null;
          },
        ),
        // if (isEmploymentStatusEmpty == true) // Show error message if exists
        //   const Padding(
        //     padding:  EdgeInsets.only(top: 5.0),
        //     child: Text(
        //       'This field is empty',
        //       style: TextStyle(
        //         color: Colors.red,
        //         fontSize: 12,
        //       ),
        //     ),
        //   ),
        if (employmentStatusController.text.toLowerCase() == "other") ...[
          const SizedBox(height: 20),
          // if(employmentStatusController.text.toLowerCase() == "other")
          UIFormTextField.outlined(
            hintText: "Other Employment Status",
            controller: otherEmployeeController,
            labelHintTextStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              fontFamily: 'Rubik',
              color: DefaultColors.grayB3,
            ),
            borderColor: DefaultColors.grayE6,
            labelUiText: UiTextNew.h4Regular(
              "Other Employment Status",
              color: DefaultColors.white_800,
            ),
            labelTextStyle: const TextStyle(
              fontSize: 14,
              fontFamily: 'Rubik',
              fontWeight: FontWeight.w500,
              color: DefaultColors.white_800,
            ),
            onChanged: (value) {
              setState(() {
                otherEmployeeController.text = value;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "This field is required";
              }
              return null;
            },
          ),
        ],
        if (employmentStatusController.text.toLowerCase() != "retired" &&
            employmentStatusController.text.toLowerCase() != "homemaker" &&
            employmentStatusController.text.toLowerCase() != "student" &&
            employmentStatusController.text.toLowerCase() != "" &&
            employmentStatusController.text.toLowerCase() != null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              UIFormTextField.outlined(
                hintText: "Employer Name",
                controller: employeeNameController,
                labelHintTextStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  fontFamily: 'Rubik',
                  color: DefaultColors.grayB3,
                ),
                borderColor: DefaultColors.grayE6,
                labelUiText: UiTextNew.h4Regular(
                  "Employer Name",
                  color: DefaultColors.white_800,
                ),
                labelTextStyle: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.w500,
                  color: DefaultColors.white_800,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "This field is required";
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    employeeNameController.text = value;
                  });
                },
              ),
              SizedBox(height: 20),

              UIFormTextField.outlined(
                hintText: "Designation & Job Title",
                controller: designationJobController,
                labelHintTextStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  fontFamily: 'Rubik',
                  color: DefaultColors.grayB3,
                ),
                borderColor: DefaultColors.grayE6,
                labelUiText: UiTextNew.h4Regular(
                  "Designation & Job Title",
                  color: DefaultColors.white_800,
                ),
                labelTextStyle: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.w500,
                  color: DefaultColors.white_800,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "This field is required";
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    designationJobController.text = value;
                  });
                },
              ),
              SizedBox(height: 20),

              UIFormTextField.outlined(
                hintText: "Profession",
                controller: professionStatusController,
                labelHintTextStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  fontFamily: 'Rubik',
                  color: DefaultColors.grayB3,
                ),
                borderColor: DefaultColors.grayE6,
                suffixIcon: IconButton(
                  onPressed: () {
                    _showProfessionBottomSheet(context);
                  },
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: DefaultColors.blue9D,
                    size: 30,
                  ),
                ),

                labelUiText: UiTextNew.h4Regular(
                  "Profession",
                  color: DefaultColors.white_800,
                ),
                labelTextStyle: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.w500,
                  color: DefaultColors.white_800,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "This field is required";
                  }
                  return null;
                },
              ),
            ],
          ),
      ],
    );
  }

  void _showEmploymentStatusBottomSheet(BuildContext context) {
    return UiBottomSheet.customSheet(
      showBottomButton: false,
      context: context,
      title: "Employment Status",
      child: _buildEmploymentStatusList(),
    );
  }

  Widget _buildEmploymentStatusList() {
    String searchQuery = _searchController.text.toLowerCase();

    if (searchQuery.isEmpty) {
      filteredEmploymentStatus = employmentStatus;
    } else {
      String normalize(String value) {
        return value
            .replaceAll(',', '')
            .replaceAll(' ', ' ')
            .replaceAll("-", "")
            .replaceAll(".", "")
            .toLowerCase();
      }

      final normalizedQuery = normalize(searchQuery);
      setState(() {
        filteredEmploymentStatus = employmentStatus.where((data) {
          final name = normalize(data ?? '');
          return name.contains(normalizedQuery);
        }).toList();
      });
    }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: Column(
        children: [
          UiSearch(
            hintText: "Search",
            controller: _searchController,
            onChanged: (query) {
              setState(() {});
            },
          ),
          SizedBox(height: 15),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: _searchController,
              builder: (context, TextEditingValue queryValue, _) {
                final searchQuery = queryValue.text.toLowerCase();
                final filteredEmploymentStatus = employmentStatus.where((data) {
                  final name = data.toLowerCase();
                  return name.contains(searchQuery);
                }).toList();
                return ListView.builder(
                  itemCount: filteredEmploymentStatus.length,
                  // physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    String data = filteredEmploymentStatus[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: GestureDetector(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: DefaultColors.grayE6.withOpacity(0.5),
                            //Color(0xFFECE6F0)
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: UiTextNew.customRubik(
                            data,
                            fontSize: 16,
                            color: DefaultColors.black,
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          setState(() {
                            isEmploymentStatusEmpty = data == 'Please Select'
                                ? true
                                : false;
                            employmentStatusController.text =
                                data == 'Please Select' ? '' : data;
                            ref
                                    .read(
                                      getEmploymentStatusForStudHomeRetired
                                          .notifier,
                                    )
                                    .state =
                                getEmploymentStatusStudHomeRetired();
                          });
                        },
                      ), // Render each transaction tile
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _showProfessionBottomSheet(BuildContext context) {
    return UiBottomSheet.customSheet(
      showBottomButton: false,
      context: context,
      title: "Profession",
      child: _buildProfessionStatusList(),
    );
  }

  Widget _buildProfessionStatusList() {
    String searchQuery = _searchController.text.toLowerCase();

    if (searchQuery.isEmpty) {
      filteredProfessionStatus = professionStatus;
    } else {
      String normalize(String value) {
        return value
            .replaceAll(',', '')
            .replaceAll(' ', ' ')
            .replaceAll("-", "")
            .replaceAll(".", "")
            .toLowerCase();
      }

      final normalizedQuery = normalize(searchQuery);
      setState(() {
        filteredProfessionStatus = professionStatus.where((data) {
          final name = normalize(data ?? '');
          return name.contains(normalizedQuery);
        }).toList();
      });
    }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: Column(
        children: [
          UiSearch(
            hintText: "Search",
            controller: _searchController,
            onChanged: (query) {
              setState(() {});
            },
          ),
          SizedBox(height: 15),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: _searchController,
              builder: (context, TextEditingValue queryValue, _) {
                final searchQuery = queryValue.text.toLowerCase();
                final filteredProfessionStatus = professionStatus.where((data) {
                  final name = data.toLowerCase();
                  return name.contains(searchQuery);
                }).toList();
                return ListView.builder(
                  itemCount: filteredProfessionStatus.length,
                  // physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    String data = filteredProfessionStatus[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: GestureDetector(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: DefaultColors.grayE6.withOpacity(0.5),
                            //Color(0xFFECE6F0)
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: UiTextNew.customRubik(
                            data,
                            fontSize: 16,
                            color: DefaultColors.black,
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          setState(() {
                            isProfessionStatusEmpty = data == 'Please Select'
                                ? true
                                : false;
                            professionStatusController.text =
                                data == 'Please Select' ? '' : data;
                          });
                        },
                      ), // Render each transaction tile
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
