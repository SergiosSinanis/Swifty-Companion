import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

// We create a class where we put all the properties and functions that will be used to talk to the 42 API
// here we have :
// 1 string property "_cachedToken" to save our session token
// 2 functions : _getToken() to get our session token and getUser(<login>) to call the 42 API with a user's login and get his 42 data
class ApiService
{
  static String? _cachedToken;

  // this function fetches a new token (a string) from the 42 API using the .env secrets to auth (if we don't already have one cached) = so that we don't want to ask 42 API for a new token every single time we request a user's data
  static Future<String> _getToken() async
  {
	// check if we already have a token, if yes, use it directly, no need to fetch a new one
    if (_cachedToken != null) { // check if not null
      return _cachedToken!; // the '!' at the end guarantees that the _cachedToken is NOT NULL (since it could be = this string is nullable '?')
    }

	// save the .env fields into local variables 
    final uid = dotenv.env['UID'];
    final secret = dotenv.env['SECRET'];

	// create a const variable named "response" that will get the http response from the 42 API of the POST request that we now send to it to get our auth token using our credentials
	late final http.Response response;
    try {
      response = await http.post(
            Uri.parse('https://api.intra.42.fr/oauth/token'),
            body: {
              'grant_type': 'client_credentials',
              'client_id': uid,
              'client_secret': secret,
            },
          )
          .timeout(const Duration(seconds: 10));
    } catch (_) {
      throw Exception('Network error : check your internet connection');
    }

	// check if the http response is 200 = SUCCESS, if not, we throw an exception
    if (response.statusCode != 200) {
      throw Exception('Could not authenticate with the 42 API. See the configs.');
    }

	// if the APi response is good (since we are here), we parse the "response" variable to get the "body" part of the http response (which we know is in raw JSON) and save it seperately now as a dart object inside a new const variable named "data" (to access easier its fields from now on)
    final data = jsonDecode(response.body); // this converts the API's JSON response to a dart object named "data"
    // we now can access easily the "access_token" field from the http response and save it in our "_cachedToken" variable and return it
	_cachedToken = data['access_token'];
    return _cachedToken!;
  }

  // 1 Map<String, dynamic> is the whole user profile: login, email, wallet, their skills, their project history, all into that single object, just with some of its values being simple (a string, a number) and others being more complex things nested inside (other maps, lists of maps)
  static Future<Map<String, dynamic>> getUser(String login) async
  {
	// first we get the authentication token by calling the _getToken(), to be able to later query the 42 API with the login, and store it in a ocnst named "token" :
    final token = await _getToken(); // "token" will now contain the "_cachedToken"

	// now we do the actual HTTP GET request with our user's login (our argument) to get the 42 profile data of our user (and we save the API's response in a const variable) :
  // the 'https://api.intra.42.fr/v2/users/$login' endpoint is in the doc of the 42 API
	// the header "Authorization: Bearer $token" is a universal OAuth2 standard (defined in RFC 6750, the "Bearer Token Usage" spec)
	// every single OAuth2-based API on the web expects this exact same header name (Authorization) and this exact same prefix word (Bearer) before the token (it's the global standard)
	// so in the header we say to the API "I'm authenticating using this bearer access token" = which is the "_cachedToken" that we obtained earlier
	late final http.Response response;
    try {
      response = await http.get(
            Uri.parse('https://api.intra.42.fr/v2/users/$login'),
            headers: {'Authorization': 'Bearer $token'},
          )
          .timeout(const Duration(seconds: 10));
    } catch (_) {
      // covers no internet, DNS failure, or a hung request (these errors happen before any status code arrives)
      throw Exception('Network error : check your internet connection');
    }

	// we check the 42 API response :
	// if it's 200 = OK, then we translate the raw json response body of the API into a Dart object (cast as a Map<String, dynamic> = no conversion just typing) = to be able to access its fileds easier later, and return it
  // if it's 404 = Not Found = we throw an error notifying the user that this login doesn't exist (it's a specific and useful error)
	// for any other error like 401 = unauthorized, 500 = server error, 503 = service unavailable, we throw an error with the proper error code
	// jsonDecode(response.body) will contain 1 long string like '{"login": "ssinanis", "wallet": 240, ...}' = it is a map of entries with a string and something else (seperated by ',')
  if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else if (response.statusCode == 404) {
      throw Exception('No student found with that login ! Try another one');
    } else {
      throw Exception('Network error (status ${response.statusCode})');
    }
  }
}
