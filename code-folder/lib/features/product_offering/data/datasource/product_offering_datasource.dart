// Data source for product_offering — implement your API calls here.
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:dkb_retail/common/utils.dart';
import 'package:dkb_retail/core/cache/global_cache.dart';
import 'package:dkb_retail/features/product_offering/data/models/apply_products_dto.dart';
import 'package:dkb_retail/features/product_offering/data/models/contact_us_modal_payload_item_dto.dart';
import 'package:dkb_retail/network/data/api_mapper.dart';
import 'package:dkb_retail/network/data/execute_api_call.dart';
import 'package:dkb_retail/network/data/model/app_status.dart';
import 'package:dkb_retail/network/data/network_client.dart';
import 'package:dkb_retail/network/data/urls/products_url.dart';
import 'package:dkb_retail/network/domain/models/api_envelope.dart';
import 'package:dkb_retail/network/domain/models/api_error.dart';
import 'package:logger/logger.dart';

import '../../../../network/data/urls/product_offering_url.dart';
import '../models/bank_products_dto.dart';
import '../models/create_lead_of_products_dto.dart';
import '../models/fetch_apply_products_request.dart';
import '../models/get_sub_products_imgs_request.dart';
import '../models/sub_products_images_dto.dart';

part 'src/get_contact_us_fields.dart';
part 'src/get_products.dart';

abstract class ProductOfferingDataSource {
  // Example:
  // Future<Map<String, dynamic>> login({required String username, required String password});
  Future<ApiEnvelope<List<ApplyProductsDto>>> getProducts();
  Future<ApiEnvelope<List<ContactUsModalPayloadItemDto>>> getContactUsFields();
  Future<ApiEnvelope<List<BankProductsDto>>> fetchApplyProducts({
    required FetchApplyProductsRequest request,
  });
  Future<ApiEnvelope<List<CreateLeadOfProductsDto>>> createLeadApplyProducts({
    required dynamic request,
  });
  Future<ApiEnvelope<List<SubProductsImagesDto>>> getSubProductsImgs({
    required GetSubProductsImgsRequest request,
  });
}

class ProductOfferingDatasourceImpl extends ProductOfferingDataSource {
  final NetworkClient networkClient;

  ProductOfferingDatasourceImpl({required this.networkClient});
  @override
  Future<ApiEnvelope<List<ApplyProductsDto>>> getProducts() {
    return _getProduct(networkClient);
  }

  @override
  Future<ApiEnvelope<List<ContactUsModalPayloadItemDto>>> getContactUsFields() {
    // TODO: implement getContactUsFields
    // throw UnimplementedError();
    return _getContactUsFields(networkClient);
  }

  @override
  Future<ApiEnvelope<List<BankProductsDto>>> fetchApplyProducts({
    required FetchApplyProductsRequest request,
  }) async {
    final globalCache = GlobalCache.instance;
    final dio = networkClient.customDio(
      authorizationRequired: true,
      screenId: 'SCR-303',
      serviceId: 'SRV-001',
      subModuleId: 'SUB-202',
      moduleId: 'MOD-101',
    );

    if (globalCache.hasProductsCache) {
      var localData = await globalCache.getCachedProducts();
      // consoleLog('cache Data: $localData ');
      return ApiMapper.mapList<BankProductsDto>(
        localData,
        (data) => BankProductsDto.fromJson(data),
      );
      // return localData;
    }

    final extraheaders = <String, String>{'channel': 'WEB'};

    dio.options.headers.addAll(extraheaders);
    // Inject DeviceModel (ignored in JSON) — and guard against null
    final appVer = await getAppVersion();
    final deviceData = await getDeviceInfo();
    print('device: $deviceData ');
    final deviceModel = await DeviceInfo(
      appVer: appVer,
      endToEndId: '',
    ).deviceType();
    if (deviceModel == null) {
      return ApiEnvelope.error(
        const ApiError(description: 'Unable to fetch device info'),
        AppStatus.error,
      );
    }
    final withDevice = request.copyWith(deviceInfo: deviceModel);

    // await Future.delayed(Duration(seconds: 2));

    var dummyData = {
      "status": {"code": "000000", "description": "SUCCESS"},
      "data": [
        {
          "productId": 1,
          "productName": "Cards",
          "productCategory": "Cards",
          "productImage":
              "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",
          "active": true,
          "createdAt": "2025-09-20T10:49:39.835969Z",
          "updatedAt": "2025-10-01T13:38:54.158271Z",
          "subProducts": [
            {
              "subProductId": 1,
              "subProductName": "Credit Card",
              "subProductCategory": "Credit Card",
              "description":
                  "<h2>1. Android Emulator Issue: &quot;Pixel 9a is already running as process 80917.&quot; 🛑</h2><p>This error (shown in <code>image_72dba9.png</code>) means that the emulator process is still active in the background, even though the emulator window might be closed or hidden. This prevents a new instance from launching.</p><h3><strong>Solution: Force Stop the Emulator Process</strong></h3><p>You need to manually stop the running emulator process using your terminal.</p><ol><li><strong>Find the process ID (PID):</strong> The error message already gives you the PID: <strong>80917</strong>.</li><li><strong>Kill the process:</strong> Use the <code>kill</code> command in your terminal to terminate the process:<pre><code>kill 80917</code></pre><em>If that doesn't work, you can try a more forceful termination:</em><pre><code>kill -9 80917</code></pre></li><li><strong>Try launching the emulator again.</strong></li></ol><h3><strong>Alternative: Shut Down all Emulators (Recommended for Flutter)</strong></h3><p>If you often encounter this, use the following command to shut down any running emulator:</p><pre><code>flutter emulators --launch &lt;emulator_name&gt;<br># Example: flutter emulators --launch Pixel_9a<br># Or simply check and run:<br># flutter emulators<br># flutter emulators --launch &lt;name&gt;</code></pre><p>If you still have trouble, you can try closing VS Code and Android Studio completely and then launching them again, or even restarting your Mac.</p><hr><h2>2. iOS Build Issue: &quot;No such module 'GoogleMaps'&quot; and &quot;No such module 'Flutter' SourceKit&quot; 🍎</h2><p>The error messages in your Xcode and VS Code screenshots (<code>Screenshot 2025-09-21 at 2.03.55 PM.jpg</code>, <code>Screenshot 2025-09-21 at 9.16.43 PM.jpg</code>, and <code>Screenshot 2025-09-21 at 4.03.25 PM.jpg</code>) indicate a problem with how your iOS project (<code>dkb_retail/ios</code>) is resolving dependencies, specifically for the <strong>Google Maps</strong> and <strong>Flutter</strong> modules in the Swift <code>AppDelegate.swift</code> file.</p><p>This is nearly always fixed by managing your iOS dependencies using <strong>CocoaPods</strong>.</p><h3><strong>Solution: Reinstall and Update CocoaPods</strong></h3><ol><li><strong>Navigate to the iOS directory:</strong> Open your terminal and change the directory to your iOS project folder.<pre><code>cd dkb_retail/ios</code></pre></li><li><strong>",
              "active": true,
              "createdAt": "2025-09-20T10:51:51.50746Z",
              "updatedAt": "2025-09-20T10:51:51.50746Z",
            },
            {
              "subProductId": 8,
              "subProductName": "Card2",
              "subProductCategory": "Card",
              "description":
                  "<div><p>Premium privileges and tailored perks await you with your Dukhan Bank Platinum credit card.</p><ul><li>&#10003; 12,000 welcome Dukhan Bank Rewards points</li><li>&#10003; Access to exclusive global visa deals</li><li>&#10003; Generous Rewards Program</li><li>&#10003; Attractive Rewards Program</li><li>&#10003; 3 Free supplementary cards</li></ul><h3>Eligibility:</h3><ul><li>Minimum deposit required to apply for a deposit backed credit card is QAR 20,000</li><li>Credit limit assigned on a deposit backed credit card would be up to 95% of total deposit amount.</li><li>Credit limit assigned on a deposit backed</li></ul></div>",
              "active": true,
              "createdAt": "2025-09-11T11:42:40.623393Z",
              "updatedAt": "2025-09-11T11:42:40.623393Z",
            },
            {
              "subProductId": 9,
              "subProductName": "Card3",
              "subProductCategory": "Card",
              "description":
                  "<div><p>Premium perks and elite benefits await you with your Dukhan Bank Signature credit card.</p><ul><li>&#10003; Easy minimum payment options available</li><li>&#10003; 8,000 welcome Dukhan Bank Rewards points</li><li>&#10003; Access to international mastercard partner offers</li><li>&#10003; Competitive Rewards Program</li><li>&#10003; 1 Free supplementary card</li></ul><h3>Eligibility:</h3><ul><li>Minimum deposit required to apply for a deposit backed credit card is QAR 10,000</li><li>Credit limit assigned on a deposit backed credit card would be up to 85% of total deposit amount.</li><li>Credit limit assigned on a deposit backed</li></ul></div>",
              "active": true,
              "createdAt": "2025-09-11T11:42:40.623393Z",
              "updatedAt": "2025-09-11T11:42:40.623393Z",
            },
          ],
        },
        {
          "productId": 2,
          "productName": "Deposit",
          "productCategory": "Financial",
          "productImage":
              "iVBORw0KGgoAAAANSUhEUgAAAOEAAADhCAMAAAAJbSJIAAABIFBMVEUALXRBl8s9rivI6PrX6PLJ6PnW6PPK6PnV6PPH6PrY6PLM6PjT6PTR6PXQ6PbP6PbO6PfG6PvZ6PHN6PfS6PXL6PjU6PTH6PvY6PHJ6PrW6PIAJXAAKHE5rSQ/syU+lcpguV1gptMdX2MoXJZTbpxvv3Jvr9ja6/wAIncAJ3YwqxKp0+2Jv+FNnc4AH2wvda01grkHNXowkEERSmgEM3A3oDUrqgC43M6QxOSizuq43fKp0ux4tNswZp8/i78WRYYdVZJklcBXeqcRQYNAZpEnh0XF5uWVz6gpflArg0oOQ2uHyZUAGXkcYV0ib1Z4w38zmDsVU2QfaFpZfZNloIMLPW1YuFIwj0MUTmeq18AIOHA2nzcldlKTzaK/4NpJsjwDQ06fAAAGPUlEQVR4nO3Z+1caRxTA8WFbX1Uelkdbd2cXYoFlEZFoUAlq2tRXfca2JjRV////orMgaiIYnLl7mHud7+mPPSfz6Z2ZHVI2Tz027gVEnhHizwjxx36inhHizwjxx2aoZ4T4M0L8GSH+2HfUM0L8GSH+jBB/Rog/I8TfCxD+Qj0jxN8LEE5QzwjxZ4T4M0L8vQDhFPUghbPp2VFLi381C/hHPxGYMJuuLpUKo1Zqtzc2WxOp9CzUnz80KGGqWvOeX6y0UZ2IeJpAwtklLybRrXJ+NsJRwghTcsA7ZWFzKg2ykAGBCLNVeWBf2W6lIJbyOBBhuqYG7CFL1Uj2KoiwpTjCvrHQimCvQgglr5lBxtI8+BwhhOk2kDA0bkB/OkCEJTChMBaArxwIYQpSKMa4mYKco35CYWxPAZ5GllUvCSyMebWZNMC6emkpjHmxVgpgYd30FApjFWqK2gq9t0mApWX1FQrjJgxRYyHQRtVXKIgtCKLGQtHMrPrqtBZ6BQjhyH89NrzoZugtJZVXp7cwJr4Z1IW1idH/EhalULzCE8SF4fONuDBWS1EXehtqRATC2JTSPtVfqDpEDMJalrhQcYgYhLGaysMGQpiIWui1FIaIQ9hWGCJLqxePXBhLp6RXByjcrm8tjtjWVr2+su3VRv2/cl41OX7hys6y7YyebdvLy2xnq749krAdH7tw0XbY8xNSp/Gu/s1N7tXGPUMBlPD1mbazU/ee3rDiNh2vsK4A7CGX3608KdyUHiKMUBHYQ76vP3UQE+MUJn9bVheK7MZwY036qgER/g4ww56RDTN6Y92lyV+hhMK4M/g8yl81LKVeAlAozuPiQOHbpOTqtBOGx3Hl8afD20jQEQrj1mPhEimhOI1fP3PE54KUkDmNr96rXilOSyherNvEhcK4Ql3I7BXqwi+INIWM3Z9F8RuYotBpePdCYl+LPnEH4E2TVC8emfD+deNtxiVXp7mQLd/eNl41QVTIbo+il5VdnfbC2x9T3hxZYW+fegXCQud998dThq6Q2fXwJ77sVYpByBpiiFPSq8MgFEOUP4YohGKIG9KbFIfQrk/Ir44lEknVfzKRC/+IJ6SXJ4TKRS70d/fkV4dB6DSa+2XSQv/AzZMWOmuWZclvUwRC/9C1gg5hofMntyx+JL1N9Rcen4dC+YOovbBy4opjaAVkhd1rRtSUvmp0Fx6/5l1hsD5OYYTvUv/U7c0wkP7ms7h6c5EJK6u3wPAylVyd1sL+IQyFZxSFjvOG3wmLFIX+ObcoCx3/tWvdC/PkhE7lIZCg0LHPHwLpCStr95cMyXPof7C+BBITOncvmQdCSt9Df+38EZDSm8b2Lzh/BAzfpbLCjHo5OKHjrw4YYCjslCVXByL8qwLlaxy6AwYoal7Lrg5CWP7bh/GtHfCBAwxnKDtCGGERwFfx/zmwhvksfjlm4a7iEG3/+MPHofPrXaXjFQYX8kSn4lc+ifENPn/KFw2QkLunvsx9agvdv68Ob57mhTPck14dkNByz1eP/coz8n3/mH063f3Mv8lTOoZgQou7bw4vXo3UycnF6X+HHz9brjuCrrtJrzQQhv+l3Wc06OEyXCi/STNsTr2+MLL4ZSYjvToUwmBfHohEuJCjLRS/DRVWh0EYXCuMEIOQF1VGiEEYXCvcMxiEaqcQg1B87WkLxYNNbXW6C/llTm2E2gvVvhQIhMp7VHchzysD51hOvciE/GZBfXVaC4PrsvrqdBY21wGAOguDDgRQY2FzHwSor7AJM0F9hUBbNKerkHOQS6ablsLgZg8MmGPT6kELg+JCDmBZt+kn5OElCrCqftoJg8vrMsCa7tNMyPnVJOQAp4GER0BC3izulScBVvQwCGFuvQniC/LX4D4Y4XT5Rn2IwrcOesP0AxHmOopD5EFwFsX8wkCE4iQGSrz8/kIk8wuDEYZEqY0qdFZxf68c0fzCgITT5c5Nkz+rIAiaVvFqfaEc2fi6QQmnc+X1o2J+xIrFs6P9Togr56KbXi8wYWh8XrnIcd0AhZrGJqlnhPgzQvwZIf5egHCBekaIvxcg/J56Rog/I8SfEeLPCPFnhPh7AcIfqGeE+DNC/Bkh/tjP1DNC/Bkh/tiP1DNC/Bkh/ugL/we820ZAgryGJAAAAABJRU5ErkJggg==",
          "active": true,
          "createdAt": "2025-09-11T11:42:18.214489Z",
          "updatedAt": "2025-09-11T11:42:18.214489Z",
          "subProducts": [
            {
              "subProductId": 5,
              "subProductName": "deposit 1",
              "subProductCategory": "Premium",
              "description":
                  "\n<div>\n    <h2>Fixed Deposits</h2>\n    <p>Fixed Deposits are approved by our Shari'ah Supervisory Committee. Dukhan Bank’s Fixed Deposits allow you to make the most of value-added benefits as you create wealth at low risk.</p>\n    <ul>\n        <li>&#10003; Open with minimum QAR 50,000</li>\n        <li>&#10003; Easy access to your funds</li>\n        <li>&#10003; Flexible deposit methods: cash, cheque, transfer</li>\n        <li>&#10003; Shari'ah-compliant deposit management</li>\n        <li>&#10003; Regular account statements provided</li>\n    </ul>\n\n    <h3>Eligibility (Fixed Deposits):</h3>\n    <ul>\n        <li>Minimum deposit required is QAR 50,000</li>\n        <li>Access granted based on chosen terms</li>\n        <li>Premium customers get dedicated managers</li>\n    </ul>\n\n    <hr>\n\n    <h2>Shari'ah compliant Term Deposit account \"Wadiati\"</h2>\n    <p>Our Shari'ah compliant Term Deposit account \"Wadiati\" gives you the great benefit of collecting your profits upon opening your account. Its has a high-profit accounts periods deposit comfortable and flexible for 6, 12 and 18 months.</p>\n    <ul>\n        <li>&#10003; Open with minimum QAR 50,000</li>\n        <li>&#10003; Easy access to your funds</li>\n        <li>&#10003; Flexible deposit methods: cash, cheque, transfer</li>\n        <li>&#10003; Shari'ah-compliant deposit management</li>\n        <li>&#10003; Regular account statements provided</li>\n    </ul>\n\n    <h3>Eligibility (Wadiati):</h3>\n    <ul>\n        <li>Minimum deposit required is QAR 50,000</li>\n        <li>Access granted based on chosen terms</li>\n        <li>Premium customers get dedicated managers</li>\n    </ul>\n</div>",
              "active": true,
              "createdAt": "2025-09-11T11:42:40.623393Z",
              "updatedAt": "2025-09-11T11:42:40.623393Z",
            },
            {
              "subProductId": 6,
              "subProductName": "deposit 2",
              "subProductCategory": "Gold",
              "description":
                  "\n<div>\n    <h2>Fixed Deposits</h2>\n    <p>Fixed Deposits are approved by our Shari'ah Supervisory Committee. Dukhan Bank’s Fixed Deposits allow you to make the most of value-added benefits as you create wealth at low risk.</p>\n    <ul>\n        <li>&#10003; Open with minimum QAR 50,000</li>\n        <li>&#10003; Easy access to your funds</li>\n        <li>&#10003; Flexible deposit methods: cash, cheque, transfer</li>\n        <li>&#10003; Shari'ah-compliant deposit management</li>\n        <li>&#10003; Regular account statements provided</li>\n    </ul>\n\n    <h3>Eligibility (Fixed Deposits):</h3>\n    <ul>\n        <li>Minimum deposit required is QAR 50,000</li>\n        <li>Access granted based on chosen terms</li>\n        <li>Premium customers get dedicated managers</li>\n    </ul>\n\n    <hr>\n\n    <h2>Shari'ah compliant Term Deposit account \"Wadiati\"</h2>\n    <p>Our Shari'ah compliant Term Deposit account \"Wadiati\" gives you the great benefit of collecting your profits upon opening your account. Its has a high-profit accounts periods deposit comfortable and flexible for 6, 12 and 18 months.</p>\n    <ul>\n        <li>&#10003; Open with minimum QAR 50,000</li>\n        <li>&#10003; Easy access to your funds</li>\n        <li>&#10003; Flexible deposit methods: cash, cheque, transfer</li>\n        <li>&#10003; Shari'ah-compliant deposit management</li>\n        <li>&#10003; Regular account statements provided</li>\n    </ul>\n\n    <h3>Eligibility (Wadiati):</h3>\n    <ul>\n        <li>Minimum deposit required is QAR 50,000</li>\n        <li>Access granted based on chosen terms</li>\n        <li>Premium customers get dedicated managers</li>\n    </ul>\n</div>",
              "active": true,
              "createdAt": "2025-09-11T11:42:40.623393Z",
              "updatedAt": "2025-09-11T11:42:40.623393Z",
            },
            {
              "subProductId": 7,
              "subProductName": "deposit 3",
              "subProductCategory": "Basic",
              "description":
                  "\n<div>\n    <h2>Fixed Deposits</h2>\n    <p>Fixed Deposits are approved by our Shari'ah Supervisory Committee. Dukhan Bank’s Fixed Deposits allow you to make the most of value-added benefits as you create wealth at low risk.</p>\n    <ul>\n        <li>&#10003; Open with minimum QAR 50,000</li>\n        <li>&#10003; Easy access to your funds</li>\n        <li>&#10003; Flexible deposit methods: cash, cheque, transfer</li>\n        <li>&#10003; Shari'ah-compliant deposit management</li>\n        <li>&#10003; Regular account statements provided</li>\n    </ul>\n\n    <h3>Eligibility (Fixed Deposits):</h3>\n    <ul>\n        <li>Minimum deposit required is QAR 50,000</li>\n        <li>Access granted based on chosen terms</li>\n        <li>Premium customers get dedicated managers</li>\n    </ul>\n\n    <hr>\n\n    <h2>Shari'ah compliant Term Deposit account \"Wadiati\"</h2>\n    <p>Our Shari'ah compliant Term Deposit account \"Wadiati\" gives you the great benefit of collecting your profits upon opening your account. Its has a high-profit accounts periods deposit comfortable and flexible for 6, 12 and 18 months.</p>\n    <ul>\n        <li>&#10003; Open with minimum QAR 50,000</li>\n        <li>&#10003; Easy access to your funds</li>\n        <li>&#10003; Flexible deposit methods: cash, cheque, transfer</li>\n        <li>&#10003; Shari'ah-compliant deposit management</li>\n        <li>&#10003; Regular account statements provided</li>\n    </ul>\n\n    <h3>Eligibility (Wadiati):</h3>\n    <ul>\n        <li>Minimum deposit required is QAR 50,000</li>\n        <li>Access granted based on chosen terms</li>\n        <li>Premium customers get dedicated managers</li>\n    </ul>\n</div>",
              "active": true,
              "createdAt": "2025-09-11T11:42:40.623393Z",
              "updatedAt": "2025-09-11T11:42:40.623393Z",
            },
          ],
        },
        {
          "productId": 3,
          "productName": "Finance",
          "productCategory": "Financial",
          "productImage": "",
          "active": true,
          "createdAt": "2025-09-11T11:42:18.214489Z",
          "updatedAt": "2025-09-11T11:42:18.214489Z",
          "subProducts": [
            {
              "subProductId": 2,
              "subProductName": "Fin1",
              "subProductCategory": "Financial",
              "description":
                  "<section><h2>Ready Property Finance</h2><p>Ready property finance for **Qatar Nationals** and **expatriates**. **High Finance Amount** and **Tenure**. Attractive fees and floating rates linked to **Qatar Central Bank rates**. Financing major developers and projects. Easy application process, with approval in **less than 24 hours** after submitting your application and documents. Fully transparent transaction with **low processing fees** and **no additional charges**.</p><h3>Key benefits:</h3><ul><li>Finance for ready or new homes</li><li>Available for Qataris & expatriates</li><li>High finance amount & flexible tenure</li><li>Attractive fees linked to QCB rates</li><li>Approvals within 24 hours</li><li>Transparent process, no hidden charges</li></ul></section>",
              "active": true,
              "createdAt": "2025-09-11T11:42:40.623393Z",
              "updatedAt": "2025-09-11T11:42:40.623393Z",
            },
            {
              "subProductId": 3,
              "subProductName": "Fin2",
              "subProductCategory": "Financial",
              "description":
                  "<section><h3>Key benefits:</h3><ul><li>Free life insurance included</li><li>Attractive, competitive profit rates</li><li>Financing up to seven years</li><li>Fast approval within 24 hours</li><li>Transparent process, no hidden fees</li></ul><h3>Eligibility and Documents Needed:</h3><ul><li>Salary transfer to Dukhan Bank required</li><li>Valid ID (Qatari) or Passport + Residence Permit (Expatriates)</li><li>Salary assignment letter &amp; valid quotation</li><li>6-month bank statement (new customers only)</li><li>Minimum salary requirement: QAR 10,000</li><li>Finance up to QAR 2M (Qataris, 6 years)</li><li>Finance up to QAR 400K (Expatriates, 4 years)</li><li>Vehicle must not exceed 7 years at maturity</li></ul></section>",
              "active": true,
              "createdAt": "2025-09-11T11:42:40.623393Z",
              "updatedAt": "2025-09-11T11:42:40.623393Z",
            },
            {
              "subProductId": 4,
              "subProductName": "Fin3",
              "subProductCategory": "Financial",
              "description":
                  "<section><h3>Key benefits:</h3><ul><li>Advance salary facility of up to QAR 75,000/- per month</li><li>Zero profit rate</li><li>Fully Shari'ah Compliant</li><li>No annual fees</li><li>Economical fees on withdrawals only</li><li>Complimentary Takaful coverage</li><li>Auto settlement facility</li><li>Validity of 12 months with renewal option</li><li>Easy documentation</li><li>Once your Salary Advance Facility is approved, Salary Advance could be taken out for any month of your choice</li></ul></section>",
              "active": true,
              "createdAt": "2025-09-11T11:42:40.623393Z",
              "updatedAt": "2025-09-11T11:42:40.623393Z",
            },
          ],
        },
      ],
    };
    return executeApiCall<List<BankProductsDto>>(
      // call: () => dio.post(
      //   ProductOfferingUrl.fetchApplyProducts,
      //   data: withDevice.toJson(),
      // ),
      call: () async {
        // final response = await dio.get(ProductOfferingUrl.fetchApplyProducts);
        final response = await dio.post(
          ProductOfferingUrl.fetchApplyProducts,
          data: withDevice.toJson(),
        );
        // consoleLog('cache Data: $response');
        if (response.data != null) {
          await globalCache.cacheProducts(response.data);
        }
        return response;
      },
      mapJson: (json) {
        return ApiMapper.mapList<BankProductsDto>(json, (d) {
          return BankProductsDto.fromJson(d);
        });
      },
    );

    // await globalCache.cacheProducts(dummyData);

    // return ApiMapper.mapList<BankProductsDto>(
    //   dummyData,
    //   (data) => BankProductsDto.fromJson(data),
    // );
  }

  @override
  Future<ApiEnvelope<List<CreateLeadOfProductsDto>>> createLeadApplyProducts({
    required dynamic request,
  }) async {
    final dio = networkClient.customDio(
      authorizationRequired: true,
      screenId: 'applyProducts',
      serviceId: 'MENUS',
      subModuleId: 'FUND_TRANSFERS',
      moduleId: 'TRANSFERS',
    );

    final extraheaders = <String, String>{
      'channel': 'WEB',
      // 'accept-language': LocaleCache.instance.getLocaleId(),
    };
    dio.options.headers.addAll(extraheaders);

    // Inject DeviceModel (ignored in JSON) — and guard against null
    final appVer = await getAppVersion();
    final deviceData = await getDeviceInfo();
    consoleLog('data** $deviceData ***');
    final deviceModel = await DeviceInfo(
      appVer: appVer,
      endToEndId: '',
    ).deviceType();
    if (deviceModel == null) {
      return ApiEnvelope.error(
        const ApiError(description: 'Unable to fetch device info'),
        AppStatus.error,
      );
    }
    // final withDevice = request.copyWith(deviceInfo: deviceModel);

    // consoleLog('body: $withDevice ');

    return executeApiCall<List<CreateLeadOfProductsDto>>(
      call: () => dio.post(
        ProductOfferingUrl.createLeadApplyProducts,
        data: {"requestInfo": request, "deviceInfo": deviceData},
        // data: request.leadInfo,
      ),
      mapJson: (json) => ApiMapper.mapList<CreateLeadOfProductsDto>(
        json,
        (d) => CreateLeadOfProductsDto.fromJson(d),
      ),
    );
  }

  @override
  Future<ApiEnvelope<List<SubProductsImagesDto>>> getSubProductsImgs({
    required GetSubProductsImgsRequest request,
  }) async {
    final dio = networkClient.customDio(
      authorizationRequired: true,
      screenId: 'SCR-303',
      serviceId: 'SRV-001',
      subModuleId: 'SUB-202',
      moduleId: 'MOD-101',
    );

    // Inject DeviceModel (ignored in JSON) — and guard against null
    final appVer = await getAppVersion();
    final deviceModel = await DeviceInfo(
      appVer: appVer,
      endToEndId: '',
    ).deviceType();
    if (deviceModel == null) {
      return ApiEnvelope.error(
        const ApiError(description: 'Unable to fetch device info'),
        AppStatus.error,
      );
    }
    final withDevice = request.copyWith(deviceInfo: deviceModel);

    return executeApiCall<List<SubProductsImagesDto>>(
      call: () => dio.post(
        ProductOfferingUrl.getSubProductsImgs,
        data: withDevice.toJson(),
      ),
      mapJson: (json) => ApiMapper.mapList<SubProductsImagesDto>(
        json,
        (d) => SubProductsImagesDto.fromJson(d),
      ),
    );
  }
}
