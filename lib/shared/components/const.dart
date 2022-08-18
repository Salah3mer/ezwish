
import '../../model/user_model.dart';

String? token='';
var base64Image;

late UserModel userModel;
bool isDrawar=false;
bool fromLogin=false;

const String baseUrl = 'https://student.valuxapps.com/api/';
const String loginUrl = 'login';
const String loginEmail = 'email';
const String loginPassword = 'password';

const String profile = 'profile';
const String updateProfileUrl = 'update-profile';

const String registerUrl = 'register';

const String homeUrl = 'home';
const String categoryUrl = 'categories';
const String favoritesUrl = 'favorites';
const String favoritesProductId = 'product_id';
const String cartUrl = 'carts';
const String cartProductId = 'product_id';
const String searchUrl = 'products/search';
const String addressUrl = 'addresses';
const String updateAddressUrl = 'addresses/';
const String ordarUrl = 'orders';
const String FAQUrl = 'faqs';
const String changePasswordUrl = 'change-password';
const String aboutUSUrl = 'settings';
const String OrdarsUrl = 'orders';


