import 'dart:convert';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:country_state_city/models/country.dart';
import 'package:country_state_city/utils/country_utils.dart';
import 'package:db_uicomponents/components.dart';
import 'package:db_uicomponents/src/components/retail/ui_header_subheader_retail.dart';
import 'package:db_uicomponents/src/components/retail/ui_label_dropdown_retail.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dkb_retail/core/router/app_router.dart';
import 'package:dkb_retail/extensions/string_extenstion.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/constants/asset_path/asset_path.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../common/components/auto_leading_widget.dart';
import '../../../../common/dialog/ui_dialogs.dart';
import '../../controller/notifier/onboarding_file_upload_notifier.dart';
import '../../controller/notifier/onboarding_save_stage_data_notifier.dart';
import '../../provider/onboarding_provider.dart';
import '../basic_details/onboarding_address_details_page.dart';

@RoutePage()
class OnboardingFinancialInfoPage extends ConsumerStatefulWidget {
  OnboardingFinancialInfoPage({super.key});

  @override
  ConsumerState<OnboardingFinancialInfoPage> createState() =>
      _OnboardingFinancialInfoPageState();
}

class _OnboardingFinancialInfoPageState
    extends ConsumerState<OnboardingFinancialInfoPage> {
  TextEditingController sourceOfIncomeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController otherSourceOfIncomeController = TextEditingController();

  String searchQuery = "";
  String selectedWithdrawals = "";
  String selectedDeposits = "";

  File? selectedFile;
  String selectedSourceOfWealth = "";
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _totalMonthlySalaryController =
      TextEditingController();
  final TextEditingController _estimationController = TextEditingController();
  final TextEditingController _additionalIncomeController =
      TextEditingController();
  final TextEditingController _totalAnnualIncomeController =
      TextEditingController();
  final TextEditingController _uploadController = TextEditingController();

  String selectedCountry = "";
  bool showTotalIncome = false;
  List<Country> countries = [];
  List<Country> filteredCountries = [];
  final List<String> _sourceOfWealth = [
    "Please Select",
    "Inheritances",
    "Investments",
    "Business OwnerShip Interests",
    "Employment Income",
  ];

  List<String> sourceOfIncomeStatus = [
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

  List<String> filteredSourceOfIncomeStatus = [];
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

  @override
  Widget build(BuildContext context) {
    TextEditingController uploadControllerPassport = TextEditingController();
    final currentStage = getStageById(ref, "FINANTIAL_DTL");

    return Scaffold(
      appBar: const UIAppBar.secondary(
        autoLeadingWidget: AutoLeadingWidget(),
        title: "Financial",
        appBarColor: DefaultColors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const UiHeaderSubHeaderRetail(title: "Financial Details"),
                _buildSourceOfIncomeUi(context),
                // const UiLabelDropdownRetail(
                //   label: "Source of Income",
                //   options: ["Please Select","1","2"],
                // ),
                const SizedBox(height: 20),

                _buildCountryListUi(context),
                // const UiLabelDropdownRetail(
                //   label: "Country of the Source of Income",
                //   options: ["Please Select","1","2"],
                // ),
                const SizedBox(height: 20),

                _buildUploadPDFFile(),

                // buildFormInputFieldForUpload(
                //     uploadControllerPassport,
                //     "Upload Proof of Income",
                //     "Upload File", (){
                //   }
                //
                // ),
                const SizedBox(height: 20),
                buildInfoMessage1(),

                const SizedBox(height: 20),

                const UiHeaderSubHeaderRetail(title: "Wealth"),
                UiLabelDropdownRetail(
                  label: "Source of Wealth",
                  options: _sourceOfWealth,
                  onChanged: (String? value) {
                    setState(() {
                      selectedSourceOfWealth = ((value == 'Please Select')
                          ? ''
                          : value)!;
                    });
                  },
                ),

                const SizedBox(height: 20),
                const UiHeaderSubHeaderRetail(title: "Earnings and Assets"),
                // _setFormInputField("Total Monthly Salary","QAR 0.00"),
                _buildTotalMonthSalaryField(),
                const SizedBox(height: 20),
                // _setFormInputField("Estimated Net Worth of Assets","QAR 0.00"),
                _buildEstimationField(),
                const SizedBox(height: 20),
                // _setFormInputField("Additional Income Amount","QAR 0.00"),
                _buildAdditionalIncomeField(),
                const SizedBox(height: 20),
                _buildTotalIncomeField(),
                const SizedBox(height: 20),

                const UiHeaderSubHeaderRetail(title: "Movement Ranges"),
                UiLabelDropdownRetail(
                  label: "Withdrawals",
                  options: const ["Please Select", "1", "2"],
                  onChanged: (value) {
                    setState(() {
                      selectedWithdrawals = ((value == 'Please Select')
                          ? ''
                          : value)!;
                    });
                  },
                ),
                const SizedBox(height: 20),

                UiLabelDropdownRetail(
                  label: "Deposits",
                  options: ["Please Select", "1", "2"],
                  onChanged: (value) {
                    setState(() {
                      selectedDeposits = ((value == 'Please Select')
                          ? ''
                          : value)!;
                    });
                  },
                ),

                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  child: UIButton.rounded(
                    label: 'CONTINUE',
                    isDisabled:
                        selectedCountry.isEmpty ||
                        sourceOfIncomeController.text.isEmpty ||
                        ((sourceOfIncomeController.text.toLowerCase() ==
                                    "other" ||
                                getSourceOfIncomeStatusStudHomeRetired()) &&
                            otherSourceOfIncomeController.text.isEmpty) ||
                        !(_uploadController.text.contains("File uploaded")) ||
                        selectedFile == null ||
                        selectedSourceOfWealth.isEmpty ||
                        _totalMonthlySalaryController.text.isEmpty ||
                        _estimationController.text.isEmpty ||
                        _additionalIncomeController.text.isEmpty ||
                        selectedWithdrawals.isEmpty ||
                        selectedDeposits.isEmpty,
                    onPressed: () async {
                      bool value = await ref
                          .read(
                            onboardingSaveStageDataNotifierProvider.notifier,
                          )
                          .fetch(
                            custJourneyId: ref.watch(customerJourneyId),
                            stageId: "${currentStage?.stageId}",
                            data: {
                              "Source_of_Income": sourceOfIncomeController.text,
                              "other_Source":
                                  otherSourceOfIncomeController.text,
                              "country": selectedCountry,
                              "uploaded": selectedFile,
                              "Source_of_wealth": selectedSourceOfWealth,
                              "TotalMonthlySalary":
                                  _totalMonthlySalaryController.text,
                              "Estimated_net_worth_assets":
                                  _estimationController.text,
                              "Additional_Income":
                                  _additionalIncomeController.text,
                              "Total_Annual_Income":
                                  _totalAnnualIncomeController.text,
                              "withdrawals": selectedWithdrawals,
                              "Deposits": selectedDeposits,
                            },
                          );

                      if (value == true) {
                        context.router.push(OnboardingFinancialDetailsRoute());
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
        ),
      ),
    );
  }

  Widget _buildSourceOfIncomeUi(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UIFormTextField.outlined(
          hintText: "Please Select",
          labelUiText: UiTextNew.h4Regular(
            'Source of Income',
            color: DefaultColors.white_800,
          ),
          labelHintTextStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            fontFamily: 'Rubik',
            color: DefaultColors.grayB3,
          ),
          controller: sourceOfIncomeController,
          borderColor: DefaultColors.grayE6,
          suffixIcon: IconButton(
            onPressed: () {
              _showSourceOfIncomeBottomSheet(context);
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
        if (sourceOfIncomeController.text.toLowerCase() == "other" ||
            getSourceOfIncomeStatusStudHomeRetired()) ...[
          const SizedBox(height: 20),
          // if(sourceOfIncomeController.text.toLowerCase() == "other")
          UIFormTextField.outlined(
            hintText: "Other Source of Income",
            controller: otherSourceOfIncomeController,
            maxLength: 50,
            labelHintTextStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              fontFamily: 'Rubik',
              color: DefaultColors.grayB3,
            ),
            borderColor: DefaultColors.grayE6,
            labelUiText: UiTextNew.h4Regular(
              "Other Source of Income",
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
                otherSourceOfIncomeController.text = value;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "This field is required";
              }
              if (!RegExp(r'^[a-zA-Z0-9 ]*$').hasMatch(value)) {
                return "Special characters are not allowed (except space).";
              }

              return null;
            },
          ),
        ],
      ],
    );
  }

  bool getSourceOfIncomeStatusStudHomeRetired() {
    String text = sourceOfIncomeController.text.toLowerCase();
    return text == "student" || text == "homemaker" || text == "retired";
  }

  void _showSourceOfIncomeBottomSheet(BuildContext context) {
    return UiBottomSheet.customSheet(
      showBottomButton: false,
      context: context,
      title: "Source of Income",
      child: _buildSourceOfIncomeList(),
    );
  }

  Widget _buildSourceOfIncomeList() {
    String searchQuery = _searchController.text.toLowerCase();

    if (searchQuery.isEmpty) {
      filteredSourceOfIncomeStatus = sourceOfIncomeStatus;
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
        filteredSourceOfIncomeStatus = sourceOfIncomeStatus.where((data) {
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
                final filteredEmploymentStatus = sourceOfIncomeStatus.where((
                  data,
                ) {
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
                            sourceOfIncomeController.text =
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

  Widget _buildCountryListUi(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UiTextNew.h4Regular(
          'Country of the Source of Income',
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
          controller: _countryController,
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

  void _showCountryBottomSheet(BuildContext context) {
    return UiBottomSheet.customSheet(
      showBottomButton: false,
      context: context,
      title: "Country of Birth",
      child: _buildCountryList(),
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
                          _countryController.text = '';
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
                                  _countryController.text =
                                      country.name == 'Please Select'
                                      ? ''
                                      : country.name;
                                  selectedCountry = country.isoCode;
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

  Widget _setFormInputField(String label, String hintText) {
    return UIFormTextField.outlined(
      hintText: hintText,
      borderColor: DefaultColors.grayE6,
      labelUiText: UiTextNew.h4Regular(label, color: DefaultColors.white_800),
      labelTextStyle: const TextStyle(
        fontSize: 14,
        fontFamily: 'Rubik',
        fontWeight: FontWeight.w500,
        color: DefaultColors.white_800,
      ),
    );
  }

  Widget _buildTotalMonthSalaryField() {
    return UIFormTextField.outlined(
      hintText: "QAR 0.0",
      maxLength: 15,
      borderColor: DefaultColors.grayE6,
      labelUiText: const UiTextNew.h4Regular(
        "Total Monthly Salary",
        color: DefaultColors.white_800,
      ),
      labelHintTextStyle: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        fontFamily: 'Rubik',
        color: DefaultColors.grayB3,
      ),
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],

      controller: _totalMonthlySalaryController,
      labelTextStyle: const TextStyle(
        fontSize: 14,
        fontFamily: 'Rubik',
        fontWeight: FontWeight.w500,
        color: DefaultColors.white_800,
      ),
      onChanged: (value) {
        setState(() {
          _totalMonthlySalaryController.text = value;
          _totalAnnualIncomeController.text = calculateAnnualIncome(
            value,
            _additionalIncomeController.text,
          );
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "This field is required";
        }
        if (!RegExp(r'^\d+$').hasMatch(value)) {
          return "Only numbers are allowed.";
        }
        if (value.length < 3 || value.length > 15) {
          return "Length must be between 3 and 15 characters.";
        }

        return null;
      },
    );
  }

  Widget _buildEstimationField() {
    return UIFormTextField.outlined(
      hintText: "QAR 0.0",
      maxLength: 18,
      borderColor: DefaultColors.grayE6,
      labelUiText: const UiTextNew.h4Regular(
        "Estimated Net Worth of Assets",
        color: DefaultColors.white_800,
      ),
      controller: _estimationController,
      labelHintTextStyle: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        fontFamily: 'Rubik',
        color: DefaultColors.grayB3,
      ),
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],

      labelTextStyle: const TextStyle(
        fontSize: 14,
        fontFamily: 'Rubik',
        fontWeight: FontWeight.w500,
        color: DefaultColors.white_800,
      ),
      onChanged: (value) {
        setState(() {
          _estimationController.text = value;
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "This field is required";
        }
        if (!RegExp(r'^\d+$').hasMatch(value)) {
          return "Only numbers are allowed.";
        }
        if (value.length < 3 || value.length > 18) {
          return "Length must be between 3 and 15 characters.";
        }

        return null;
      },
    );
  }

  Widget _buildAdditionalIncomeField() {
    return UIFormTextField.outlined(
      hintText: "QAR 0.0",
      maxLength: 18,
      borderColor: DefaultColors.grayE6,
      labelUiText: const UiTextNew.h4Regular(
        "Additional Income Amount",
        color: DefaultColors.white_800,
      ),
      controller: _additionalIncomeController,
      labelHintTextStyle: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        fontFamily: 'Rubik',
        color: DefaultColors.grayB3,
      ),
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],

      labelTextStyle: const TextStyle(
        fontSize: 14,
        fontFamily: 'Rubik',
        fontWeight: FontWeight.w500,
        color: DefaultColors.white_800,
      ),
      onChanged: (value) {
        setState(() {
          _additionalIncomeController.text = value;
          _totalAnnualIncomeController.text = calculateAnnualIncome(
            _totalMonthlySalaryController.text,
            value,
          );
        });
      },
      onFieldSubmitted: (value) {},

      validator: (value) {
        if (value == null || value.isEmpty) {
          return "This field is required";
        }
        if (!RegExp(r'^\d+$').hasMatch(value)) {
          return "Only numbers are allowed.";
        }
        if (value.length < 3 || value.length > 18) {
          return "Length must be between 3 and 15 characters.";
        }

        return null;
      },
    );
  }

  Widget _buildTotalIncomeField() {
    return UIFormTextField.outlined(
      hintText: "QAR 0.0",
      readOnly: true,
      borderColor: DefaultColors.grayE6,
      labelUiText: const UiTextNew.h4Regular(
        "Total Annual Income",
        color: DefaultColors.white_800,
      ),
      labelHintTextStyle: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        fontFamily: 'Rubik',
        color: DefaultColors.grayB3,
      ),
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      controller: _totalAnnualIncomeController,
      labelTextStyle: const TextStyle(
        fontSize: 14,
        fontFamily: 'Rubik',
        fontWeight: FontWeight.w500,
        color: DefaultColors.white_800,
      ),
    );
  }

  Widget _buildUploadPDFFile() {
    return UIFormTextField.outlined(
      hintText: "Upload File",
      readOnly: true,
      borderColor: DefaultColors.grayE6,
      labelUiText: UiTextNew.h4Regular(
        "Upload Proof of Address (PDF Only)",
        color: DefaultColors.white_800,
      ),
      controller: _uploadController,
      labelHintTextStyle: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        fontFamily: 'Rubik',
        color: DefaultColors.grayB3,
      ),
      prefixIcon: Padding(
        padding: EdgeInsets.all(10),
        child: GestureDetector(
          child: SvgPicture.asset(
            AssetPath.icon.onboardingAttachFileIcon,
            width: 24,
            height: 24,
            fit: BoxFit.contain,
          ),
          onTap: _pickPDF,
        ),
      ),
      labelTextStyle: const TextStyle(
        fontSize: 14,
        fontFamily: 'Rubik',
        fontWeight: FontWeight.w500,
        color: DefaultColors.white_800,
      ),
      validator: (value) {
        if (!(_uploadController.text.contains("File uploaded")) ||
            selectedFile == null) {
          return "This field is required";
        }
        return null;
      },
    );
  }

  Future<void> _pickPDF() async {
    try {
      // Open the file picker
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'], // Restrict to PDF files
      );

      // Check if a file was selected
      if (result != null && result.files.isNotEmpty) {
        String? filePath = result.files.single.path;

        if (filePath != null) {
          selectedFile = File(filePath);
          // uploadController.text = "File Uploaded: ${result.files.single.name}";

          final notifier = ref.read(
            getOnboardingFileUploadNotifierProvider.notifier,
          );

          bool value = await notifier.fetch(
            imageType: "AddressPDF",
            fileExtension: "".getFileExtension(selectedFile!),
            fileSize: "${selectedFile!.lengthSync() ~/ 1024}",
            nationalId: ref.watch(getQidNumber),
            mobileNumber: ref.watch(getMobileNumber),
            fileType: "".getFileDetails(selectedFile!),
            fileBase64: base64Encode(selectedFile!.readAsBytesSync()),
          );
          if (value == true) {
            setState(() {
              selectedFile = File(filePath);
              _uploadController.text =
                  "File uploaded: ${result.files.single.name}";
            });
          } else {
            UiDialogs.showErrorDialog(
              context: context,
              description: "Data not uploaded",
              bknOkPressed: () {
                setState(() {
                  selectedFile = null;
                  _uploadController.text = "";
                });
              },
            );
          }

          // Log file details for debugging
          print("File path: $filePath");
          print("File name: ${result.files.single.name}");
          print("File size: ${selectedFile!.lengthSync()} bytes");
        } else {
          // File path is null
          setState(() {
            _uploadController.text = "File path is null";
            selectedFile = null;
          });
          print("File path is null");
        }
      } else {
        // User canceled the file picker
        setState(() {
          _uploadController.text = "No file selected";
          selectedFile = null;
        });
        print("No file selected");
      }
    } catch (e) {
      // Catch any unexpected errors
      print("Error during file selection: $e");
      setState(() {
        selectedFile = null;
        _uploadController.text = "An error occurred while selecting a file";
      });
    }

    // setState(() {
    //   selectedFile = (result != null) ? File(result.files.single.path!) : null;
    //   _uploadController.text = (result != null) ? "File Uploaded" : "";
    //
    // });
    //
  }

  String calculateAnnualIncome(String month, String other) {
    // Parse the values from the text fields
    double monthlySalary = double.tryParse(month) ?? 0.0;
    double otherIncome = double.tryParse(other) ?? 0.0;

    return "${(monthlySalary * 12) + otherIncome}";
  }
}
