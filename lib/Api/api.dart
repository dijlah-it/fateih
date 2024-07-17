import 'dart:convert';
import 'package:awesome_snackbar_content_new/awesome_snackbar_content.dart';
import 'package:fateih/Constants/constants.dart';
import 'package:fateih/Pages/HomePages/home.dart';
import 'package:fateih/Pages/StartPages/otp_page.dart';
import 'package:fateih/Pages/StartPages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';

const String baseURL = 'fatyh.net';
const String constPath = '/api/app/';

Future signup(
  context,
  String phoneNumber,
  String? countryCode,
) async {
  final response = await http.post(
    Uri.https(baseURL, constPath + 'signup', {
      'phone': phoneNumber,
      'country_code': countryCode,
    }),
  );
  debugPrint(response.statusCode.toString());
  debugPrint(phoneNumber.toString());
  if (response.statusCode == 200) {
    Constants.userTokenLocal
        .write('token', jsonDecode(response.body)?['token']);
    Constants.userData = jsonDecode(response.body);
    Constants.userPhoneNumber = phoneNumber;
    GoRouter.of(context).push(OtpPage.routName);
    // context.go('/OtpPage/09381426898');
  } else if (response.statusCode == 422) {
    return jsonDecode(response.body);
  } else {
    throw 'Erorr';
  }
}

Future signin(
  context,
  String phoneNumber,
  String? passWord,
) async {
  final response = await http.post(
    Uri.https(baseURL, constPath + 'signin', {
      'phone': phoneNumber,
      'password': passWord,
    }),
  );
  debugPrint(response.statusCode.toString());
  if (response.statusCode == 200) {
    var userLoginData = {'phoneNumber': phoneNumber, 'passWord': passWord};
    Constants.userTokenLocal.write('userLoginData', userLoginData);

    Constants.userTokenLocal
        .write('token', jsonDecode(response.body)?['token']);
    Constants.userData = jsonDecode(response.body);
    GoRouter.of(context).pushReplacement(HomePage.routName);

    final snackBar = SnackBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      content: Directionality(
        textDirection: TextDirection.rtl,
        child: AwesomeSnackbarContent(
          title: 'اهلا بك',
          message: 'اهلا بك يا ${Constants.userData?['user']['name'] ?? ''}',
          contentType: ContentType.success,
        ),
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  } else if (response.statusCode == 422) {
    return jsonDecode(response.body);
  } else {
    throw 'Erorr';
  }
}

Future getUserToken(context, String path, String userId, String otp) async {
  debugPrint('=============================');
  debugPrint(userId);
  debugPrint(otp);
  debugPrint('=============================');
  final response = await http.post(
    Uri.https(baseURL, constPath + path, {
      'user_id': userId,
      'otp': otp,
    }),
  );
  debugPrint(response.statusCode.toString());
  if (response.statusCode == 200) {
    Constants.userTokenLocal
        .write('token', jsonDecode(response.body)?['token']);
    // GoRouter.of(context).pushNamed(RegisterPage.routName);
    GoRouter.of(context).pushReplacement(RegisterPage.routName);
  } else if (response.statusCode == 422) {
    throw jsonDecode(response.body)?['errors'][0];
  } else {
    throw 'Erorr';
  }
}

Future updateProfile(
  BuildContext context,
  String token,
  String name,
  String email,
  String address,
  String facebook,
  String instagram,
  String? password,
  String? passwordConfirmation,
  bool setProfile,
  String? profile_photo,
  // String? profile_photo_url,
) async {
  final response = await http.post(
    Uri.https(baseURL, '${constPath}UpdateProfile', {
      'name': name,
      'email': email,
      'address': address,
      'facebook': facebook,
      'instagram': instagram,
      'password': password,
      'password_confirmation': passwordConfirmation,
      // 'profile_photo_url': profile_photo_url,
    }),
    headers: <String, String>{
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': 'Bearer $token',
    },
    body: <String, String?>{
      'profile_photo': profile_photo,
    },
  );
  debugPrint(
      '------------------------------------>' + profile_photo.toString());
  debugPrint(
      '------------------------------------>' + response.statusCode.toString());
  if (response.statusCode == 200) {
    Constants.userData = jsonDecode(response.body);
    if (setProfile == false) {
      GoRouter.of(context).pushReplacement(HomePage.routName);
      final snackBar = SnackBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        content: Directionality(
          textDirection: TextDirection.rtl,
          child: AwesomeSnackbarContent(
            title: 'اهلا بك',
            message: 'اهلا بك يا ${Constants.userData?['user']['name'] ?? ''}',
            contentType: ContentType.success,
          ),
        ),
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  } else if (response.statusCode == 422) {
    throw jsonDecode(response.body)['errors']['password'][0];
  } else {
    throw 'Erorr';
  }
}

asyncFileUpload(
  BuildContext context,
  String token,
  String name,
  String email,
  String address,
  String facebook,
  String instagram,
  String? password,
  String? passwordConfirmation,
  bool setProfile,
  XFile file,
) async {
  var request = http.MultipartRequest(
      "POST", Uri.parse('https://fatyh.net/api/app/UpdateProfile'));

  request.headers['Authorization'] = 'Bearer $token';
  request.headers['X-Requested-With'] = 'XMLHttpRequest';
  request.headers['Content-Type'] = 'multipart/form-data';

  request.fields["name"] = name;
  request.fields["email"] = email;
  request.fields["address"] = address;
  request.fields["facebook"] = facebook;
  request.fields["instagram"] = instagram;
  request.fields["password"] = '';
  request.fields["passwordConfirmation"] = '';

  var pic = await http.MultipartFile.fromPath("profile_photo", file.path);

  request.files.add(pic);
  var response = await request.send();

  var responseData = await response.stream.toBytes();
  var responseString = String.fromCharCodes(responseData);
  print(responseString);
  print(response.statusCode.toString() + '<<<<<<<<<<<<<<');
  print(file.path + '<<<<<<<<<<<<<<');
}

Future productsAPI(String token, String productID) async {
  debugPrint(productID.toString());
  debugPrint(token.toString());
  final response = await http.post(
    Uri.https(
      baseURL,
      '${constPath}products',
      {
        'id': productID,
      },
    ),
    headers: <String, String>{
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': 'Bearer $token',
    },
  );
  debugPrint(response.statusCode.toString());
  if (response.statusCode == 200) {
    Constants.products = jsonDecode(response.body);
    return jsonDecode(response.body);
  } else {
    throw 'Erorr';
  }
}

Future walletTransactions(String token) async {
  debugPrint(token.toString());
  final response = await http.post(
    Uri.https(
      baseURL,
      '${constPath}WalletTransactions',
    ),
    headers: <String, String>{
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': 'Bearer $token',
    },
  );
  if (response.statusCode == 200) {
    Constants.walletTransactions = jsonDecode(response.body);
    return jsonDecode(response.body);
  } else {
    throw 'Erorr';
  }
}

Future homeAPI(String token) async {
  debugPrint(token);
  final response = await http.post(
    Uri.https(
      baseURL,
      '${constPath}home',
    ),
    headers: <String, String>{
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': 'Bearer $token',
    },
  );
  debugPrint(response.statusCode.toString());

  if (response.statusCode == 200) {
    Constants.homePages = jsonDecode(response.body);
    Constants.userData = jsonDecode(response.body);
    Constants.userInventory = Constants.userData?['wallet_balance'] ?? 0000;
    simType(Constants.userData!['user']['phone']);
    return jsonDecode(response.body);
  } else {
    throw "Erorr";
  }
}

Future chargeWallet({
  required String token,
  required String type,
  String? cardPin,
  String? amount,
  String? currency,
  String? userIp,
}) async {
  debugPrint(token);
  final response = await http.post(
    Uri.https(
      baseURL,
      '${constPath}ChargeWallet',
      {
        'card_pin': cardPin,
        'charge_type': type,
        'amount': amount,
        // 'currency': 'IQD',
        'user_ip': userIp,
      },
    ),
    headers: <String, String>{
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': 'Bearer $token',
    },
  );
  debugPrint(response.statusCode.toString());
  debugPrint(
      'chargeWallet==============================' + response.body.toString());
  debugPrint(jsonDecode(response.body)["redirectUrl"]);

  if (response.statusCode == 200) {
    Constants.inventory = jsonDecode(response.body);
    return jsonDecode(response.body);
  } else if (response.statusCode == 422) {
    throw jsonDecode(response.body)?['error'];
  } else {
    throw "Erorr";
  }
}

Future reportSell(
  String token,
  String startDate,
  String endDate,
  String productId,
  String productCategoryId,
) async {
  debugPrint(token);
  final response = await http.post(
    Uri.https(
      baseURL,
      '${constPath}ReportSell',
      {
        'start_date': startDate,
        'end_date': endDate,
        'product_id': productId,
        'product_category_id': productCategoryId,
      },
    ),
    headers: <String, String>{
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': 'Bearer $token',
    },
  );
  debugPrint(response.statusCode.toString());

  if (response.statusCode == 200) {
    Constants.reportSell = jsonDecode(response.body);
    return jsonDecode(response.body);
  } else {
    throw "Erorr";
  }
}

Future sellCard(
  String token,
  String productId,
  String categoryId,
  String sellType,
) async {
  debugPrint(token);
  final response = await http.post(
    Uri.https(
      baseURL,
      '${constPath}SellCard',
      {
        'product_id': productId,
        'category_id': categoryId,
        'sell_type': sellType,
      },
    ),
    headers: <String, String>{
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    Constants.sellCard = jsonDecode(response.body);
  } else if (response.statusCode == 422) {
    throw jsonDecode(response.body)?['errors'][0];
  } else {
    throw "خطأ";
  }
}

void simType(String phoneNumber) {
  if (phoneNumber.startsWith('077')) {
    Constants.userSimType = 'ASIACELL';
  } else if (phoneNumber.startsWith('078')) {
    Constants.userSimType = 'ZAIN';
  } else if (phoneNumber.startsWith('750')) {
    Constants.userSimType = 'KOREK';
  }
}

Future WalletBalance({required String token}) async {
  debugPrint(token);
  final response = await http.get(
    Uri.https(
      baseURL,
      '${constPath}WalletBalance',
    ),
    headers: <String, String>{
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    Constants.sellCard = jsonDecode(response.body);
  } else if (response.statusCode == 422) {
    throw jsonDecode(response.body)?['errors'][0];
  } else {
    throw "خطأ";
  }
}
