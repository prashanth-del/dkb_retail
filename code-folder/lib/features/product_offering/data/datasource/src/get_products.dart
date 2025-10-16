part of '../product_offering_datasource.dart';

Future<ApiEnvelope<List<ApplyProductsDto>>> _getProduct(
  NetworkClient client,
) async {
  final logger = Logger();
  try {
    const productsUrl = ProductsUrl.applyProducts;
    // http://34.18.92.50:7575/products/retrieve-eligible-products
    final dio = client.customDio(
      authorizationRequired: false,
      screenId: 'LOGIN',
      serviceId: 'LOGIN',
      subModuleId: 'LGN',
      moduleId: 'LGN',
    );

    final loginBody = {};

    return executeApiCall<List<ApplyProductsDto>>(
      call: () => dio.get(productsUrl),
      mapJson: (json) {
        return ApiMapper.mapList(
          json,
          (data) => ApplyProductsDto.fromJson(json),
        );
      },
    );

    // await Future.delayed(Duration(seconds: 1));

    // var dummyData = {
    //   "status": {"code": "000000", "description": "SUCCESS"},
    //   "data": [
    //     {
    //       "productId": 1,
    //       "productName": "Cards",
    //       "productCategory": "Cards",
    //       "productImage": "",
    //       "active": true,
    //       "createdAt": "2025-09-20T10:49:39.835969Z",
    //       "updatedAt": "2025-10-01T13:38:54.158271Z",
    //       "subProducts": [
    //         {
    //           "subProductId": 1,
    //           "subProductName": "Credit Card",
    //           "subProductCategory": "Credit Card",
    //           "description":
    //               "<h2>1. Android Emulator Issue: &quot;Pixel 9a is already running as process 80917.&quot; 🛑</h2><p>This error (shown in <code>image_72dba9.png</code>) means that the emulator process is still active in the background, even though the emulator window might be closed or hidden. This prevents a new instance from launching.</p><h3><strong>Solution: Force Stop the Emulator Process</strong></h3><p>You need to manually stop the running emulator process using your terminal.</p><ol><li><strong>Find the process ID (PID):</strong> The error message already gives you the PID: <strong>80917</strong>.</li><li><strong>Kill the process:</strong> Use the <code>kill</code> command in your terminal to terminate the process:<pre><code>kill 80917</code></pre><em>If that doesn't work, you can try a more forceful termination:</em><pre><code>kill -9 80917</code></pre></li><li><strong>Try launching the emulator again.</strong></li></ol><h3><strong>Alternative: Shut Down all Emulators (Recommended for Flutter)</strong></h3><p>If you often encounter this, use the following command to shut down any running emulator:</p><pre><code>flutter emulators --launch &lt;emulator_name&gt;<br># Example: flutter emulators --launch Pixel_9a<br># Or simply check and run:<br># flutter emulators<br># flutter emulators --launch &lt;name&gt;</code></pre><p>If you still have trouble, you can try closing VS Code and Android Studio completely and then launching them again, or even restarting your Mac.</p><hr><h2>2. iOS Build Issue: &quot;No such module 'GoogleMaps'&quot; and &quot;No such module 'Flutter' SourceKit&quot; 🍎</h2><p>The error messages in your Xcode and VS Code screenshots (<code>Screenshot 2025-09-21 at 2.03.55 PM.jpg</code>, <code>Screenshot 2025-09-21 at 9.16.43 PM.jpg</code>, and <code>Screenshot 2025-09-21 at 4.03.25 PM.jpg</code>) indicate a problem with how your iOS project (<code>dkb_retail/ios</code>) is resolving dependencies, specifically for the <strong>Google Maps</strong> and <strong>Flutter</strong> modules in the Swift <code>AppDelegate.swift</code> file.</p><p>This is nearly always fixed by managing your iOS dependencies using <strong>CocoaPods</strong>.</p><h3><strong>Solution: Reinstall and Update CocoaPods</strong></h3><ol><li><strong>Navigate to the iOS directory:</strong> Open your terminal and change the directory to your iOS project folder.<pre><code>cd dkb_retail/ios</code></pre></li><li><strong>",
    //           "active": true,
    //           "createdAt": "2025-09-20T10:51:51.50746Z",
    //           "updatedAt": "2025-09-20T10:51:51.50746Z",
    //         },
    //         {
    //           "subProductId": 8,
    //           "subProductName": "Card2",
    //           "subProductCategory": "Card",
    //           "description":
    //               "<div><p>Premium privileges and tailored perks await you with your Dukhan Bank Platinum credit card.</p><ul><li>&#10003; 12,000 welcome Dukhan Bank Rewards points</li><li>&#10003; Access to exclusive global visa deals</li><li>&#10003; Generous Rewards Program</li><li>&#10003; Attractive Rewards Program</li><li>&#10003; 3 Free supplementary cards</li></ul><h3>Eligibility:</h3><ul><li>Minimum deposit required to apply for a deposit backed credit card is QAR 20,000</li><li>Credit limit assigned on a deposit backed credit card would be up to 95% of total deposit amount.</li><li>Credit limit assigned on a deposit backed</li></ul></div>",
    //           "active": true,
    //           "createdAt": "2025-09-11T11:42:40.623393Z",
    //           "updatedAt": "2025-09-11T11:42:40.623393Z",
    //         },
    //         {
    //           "subProductId": 9,
    //           "subProductName": "Card3",
    //           "subProductCategory": "Card",
    //           "description":
    //               "<div><p>Premium perks and elite benefits await you with your Dukhan Bank Signature credit card.</p><ul><li>&#10003; Easy minimum payment options available</li><li>&#10003; 8,000 welcome Dukhan Bank Rewards points</li><li>&#10003; Access to international mastercard partner offers</li><li>&#10003; Competitive Rewards Program</li><li>&#10003; 1 Free supplementary card</li></ul><h3>Eligibility:</h3><ul><li>Minimum deposit required to apply for a deposit backed credit card is QAR 10,000</li><li>Credit limit assigned on a deposit backed credit card would be up to 85% of total deposit amount.</li><li>Credit limit assigned on a deposit backed</li></ul></div>",
    //           "active": true,
    //           "createdAt": "2025-09-11T11:42:40.623393Z",
    //           "updatedAt": "2025-09-11T11:42:40.623393Z",
    //         },
    //       ],
    //     },
    //     {
    //       "productId": 2,
    //       "productName": "Deposit",
    //       "productCategory": "Financial",
    //       "productImage": "",
    //       "active": true,
    //       "createdAt": "2025-09-11T11:42:18.214489Z",
    //       "updatedAt": "2025-09-11T11:42:18.214489Z",
    //       "subProducts": [
    //         {
    //           "subProductId": 5,
    //           "subProductName": "deposit 1",
    //           "subProductCategory": "Premium",
    //           "description":
    //               "\n<div>\n    <h2>Fixed Deposits</h2>\n    <p>Fixed Deposits are approved by our Shari'ah Supervisory Committee. Dukhan Bank’s Fixed Deposits allow you to make the most of value-added benefits as you create wealth at low risk.</p>\n    <ul>\n        <li>&#10003; Open with minimum QAR 50,000</li>\n        <li>&#10003; Easy access to your funds</li>\n        <li>&#10003; Flexible deposit methods: cash, cheque, transfer</li>\n        <li>&#10003; Shari'ah-compliant deposit management</li>\n        <li>&#10003; Regular account statements provided</li>\n    </ul>\n\n    <h3>Eligibility (Fixed Deposits):</h3>\n    <ul>\n        <li>Minimum deposit required is QAR 50,000</li>\n        <li>Access granted based on chosen terms</li>\n        <li>Premium customers get dedicated managers</li>\n    </ul>\n\n    <hr>\n\n    <h2>Shari'ah compliant Term Deposit account \"Wadiati\"</h2>\n    <p>Our Shari'ah compliant Term Deposit account \"Wadiati\" gives you the great benefit of collecting your profits upon opening your account. Its has a high-profit accounts periods deposit comfortable and flexible for 6, 12 and 18 months.</p>\n    <ul>\n        <li>&#10003; Open with minimum QAR 50,000</li>\n        <li>&#10003; Easy access to your funds</li>\n        <li>&#10003; Flexible deposit methods: cash, cheque, transfer</li>\n        <li>&#10003; Shari'ah-compliant deposit management</li>\n        <li>&#10003; Regular account statements provided</li>\n    </ul>\n\n    <h3>Eligibility (Wadiati):</h3>\n    <ul>\n        <li>Minimum deposit required is QAR 50,000</li>\n        <li>Access granted based on chosen terms</li>\n        <li>Premium customers get dedicated managers</li>\n    </ul>\n</div>",
    //           "active": true,
    //           "createdAt": "2025-09-11T11:42:40.623393Z",
    //           "updatedAt": "2025-09-11T11:42:40.623393Z",
    //         },
    //         {
    //           "subProductId": 6,
    //           "subProductName": "deposit 2",
    //           "subProductCategory": "Gold",
    //           "description":
    //               "\n<div>\n    <h2>Fixed Deposits</h2>\n    <p>Fixed Deposits are approved by our Shari'ah Supervisory Committee. Dukhan Bank’s Fixed Deposits allow you to make the most of value-added benefits as you create wealth at low risk.</p>\n    <ul>\n        <li>&#10003; Open with minimum QAR 50,000</li>\n        <li>&#10003; Easy access to your funds</li>\n        <li>&#10003; Flexible deposit methods: cash, cheque, transfer</li>\n        <li>&#10003; Shari'ah-compliant deposit management</li>\n        <li>&#10003; Regular account statements provided</li>\n    </ul>\n\n    <h3>Eligibility (Fixed Deposits):</h3>\n    <ul>\n        <li>Minimum deposit required is QAR 50,000</li>\n        <li>Access granted based on chosen terms</li>\n        <li>Premium customers get dedicated managers</li>\n    </ul>\n\n    <hr>\n\n    <h2>Shari'ah compliant Term Deposit account \"Wadiati\"</h2>\n    <p>Our Shari'ah compliant Term Deposit account \"Wadiati\" gives you the great benefit of collecting your profits upon opening your account. Its has a high-profit accounts periods deposit comfortable and flexible for 6, 12 and 18 months.</p>\n    <ul>\n        <li>&#10003; Open with minimum QAR 50,000</li>\n        <li>&#10003; Easy access to your funds</li>\n        <li>&#10003; Flexible deposit methods: cash, cheque, transfer</li>\n        <li>&#10003; Shari'ah-compliant deposit management</li>\n        <li>&#10003; Regular account statements provided</li>\n    </ul>\n\n    <h3>Eligibility (Wadiati):</h3>\n    <ul>\n        <li>Minimum deposit required is QAR 50,000</li>\n        <li>Access granted based on chosen terms</li>\n        <li>Premium customers get dedicated managers</li>\n    </ul>\n</div>",
    //           "active": true,
    //           "createdAt": "2025-09-11T11:42:40.623393Z",
    //           "updatedAt": "2025-09-11T11:42:40.623393Z",
    //         },
    //         {
    //           "subProductId": 7,
    //           "subProductName": "deposit 3",
    //           "subProductCategory": "Basic",
    //           "description":
    //               "\n<div>\n    <h2>Fixed Deposits</h2>\n    <p>Fixed Deposits are approved by our Shari'ah Supervisory Committee. Dukhan Bank’s Fixed Deposits allow you to make the most of value-added benefits as you create wealth at low risk.</p>\n    <ul>\n        <li>&#10003; Open with minimum QAR 50,000</li>\n        <li>&#10003; Easy access to your funds</li>\n        <li>&#10003; Flexible deposit methods: cash, cheque, transfer</li>\n        <li>&#10003; Shari'ah-compliant deposit management</li>\n        <li>&#10003; Regular account statements provided</li>\n    </ul>\n\n    <h3>Eligibility (Fixed Deposits):</h3>\n    <ul>\n        <li>Minimum deposit required is QAR 50,000</li>\n        <li>Access granted based on chosen terms</li>\n        <li>Premium customers get dedicated managers</li>\n    </ul>\n\n    <hr>\n\n    <h2>Shari'ah compliant Term Deposit account \"Wadiati\"</h2>\n    <p>Our Shari'ah compliant Term Deposit account \"Wadiati\" gives you the great benefit of collecting your profits upon opening your account. Its has a high-profit accounts periods deposit comfortable and flexible for 6, 12 and 18 months.</p>\n    <ul>\n        <li>&#10003; Open with minimum QAR 50,000</li>\n        <li>&#10003; Easy access to your funds</li>\n        <li>&#10003; Flexible deposit methods: cash, cheque, transfer</li>\n        <li>&#10003; Shari'ah-compliant deposit management</li>\n        <li>&#10003; Regular account statements provided</li>\n    </ul>\n\n    <h3>Eligibility (Wadiati):</h3>\n    <ul>\n        <li>Minimum deposit required is QAR 50,000</li>\n        <li>Access granted based on chosen terms</li>\n        <li>Premium customers get dedicated managers</li>\n    </ul>\n</div>",
    //           "active": true,
    //           "createdAt": "2025-09-11T11:42:40.623393Z",
    //           "updatedAt": "2025-09-11T11:42:40.623393Z",
    //         },
    //       ],
    //     },
    //     {
    //       "productId": 3,
    //       "productName": "Finance",
    //       "productCategory": "Financial",
    //       "productImage": "",
    //       "active": true,
    //       "createdAt": "2025-09-11T11:42:18.214489Z",
    //       "updatedAt": "2025-09-11T11:42:18.214489Z",
    //       "subProducts": [
    //         {
    //           "subProductId": 2,
    //           "subProductName": "Fin1",
    //           "subProductCategory": "Financial",
    //           "description":
    //               "<section><h2>Ready Property Finance</h2><p>Ready property finance for **Qatar Nationals** and **expatriates**. **High Finance Amount** and **Tenure**. Attractive fees and floating rates linked to **Qatar Central Bank rates**. Financing major developers and projects. Easy application process, with approval in **less than 24 hours** after submitting your application and documents. Fully transparent transaction with **low processing fees** and **no additional charges**.</p><h3>Key benefits:</h3><ul><li>Finance for ready or new homes</li><li>Available for Qataris & expatriates</li><li>High finance amount & flexible tenure</li><li>Attractive fees linked to QCB rates</li><li>Approvals within 24 hours</li><li>Transparent process, no hidden charges</li></ul></section>",
    //           "active": true,
    //           "createdAt": "2025-09-11T11:42:40.623393Z",
    //           "updatedAt": "2025-09-11T11:42:40.623393Z",
    //         },
    //         {
    //           "subProductId": 3,
    //           "subProductName": "Fin2",
    //           "subProductCategory": "Financial",
    //           "description":
    //               "<section><h3>Key benefits:</h3><ul><li>Free life insurance included</li><li>Attractive, competitive profit rates</li><li>Financing up to seven years</li><li>Fast approval within 24 hours</li><li>Transparent process, no hidden fees</li></ul><h3>Eligibility and Documents Needed:</h3><ul><li>Salary transfer to Dukhan Bank required</li><li>Valid ID (Qatari) or Passport + Residence Permit (Expatriates)</li><li>Salary assignment letter &amp; valid quotation</li><li>6-month bank statement (new customers only)</li><li>Minimum salary requirement: QAR 10,000</li><li>Finance up to QAR 2M (Qataris, 6 years)</li><li>Finance up to QAR 400K (Expatriates, 4 years)</li><li>Vehicle must not exceed 7 years at maturity</li></ul></section>",
    //           "active": true,
    //           "createdAt": "2025-09-11T11:42:40.623393Z",
    //           "updatedAt": "2025-09-11T11:42:40.623393Z",
    //         },
    //         {
    //           "subProductId": 4,
    //           "subProductName": "Fin3",
    //           "subProductCategory": "Financial",
    //           "description":
    //               "<section><h3>Key benefits:</h3><ul><li>Advance salary facility of up to QAR 75,000/- per month</li><li>Zero profit rate</li><li>Fully Shari'ah Compliant</li><li>No annual fees</li><li>Economical fees on withdrawals only</li><li>Complimentary Takaful coverage</li><li>Auto settlement facility</li><li>Validity of 12 months with renewal option</li><li>Easy documentation</li><li>Once your Salary Advance Facility is approved, Salary Advance could be taken out for any month of your choice</li></ul></section>",
    //           "active": true,
    //           "createdAt": "2025-09-11T11:42:40.623393Z",
    //           "updatedAt": "2025-09-11T11:42:40.623393Z",
    //         },
    //       ],
    //     },
    //   ],
    // };

    // // return ApiEnvelope.success(

    // //   ApiError(code: '00000'),
    // //   AppStatus.success,
    // // );

    // return ApiMapper.mapList<ApplyProductsDto>(
    //   dummyData,
    //   (data) => ApplyProductsDto.fromJson(data),
    //    );
  } catch (e, s) {
    logger.e("Login Error", error: e, stackTrace: s);
    return ApiEnvelope.error(
      const ApiError(description: 'Unable to fetch products'),
      AppStatus.error,
    );
  }
}
