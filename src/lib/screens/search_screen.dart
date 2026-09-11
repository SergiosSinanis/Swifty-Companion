import 'package:flutter/material.dart';
import '../models/user_profile.dart';
import '../services/api_service.dart';
import 'profile_screen.dart';
import '../theme/app_colors.dart';

// Screen 1 = the login search page
class SearchScreen extends StatefulWidget
{
	const SearchScreen({super.key});

	@override
	State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
{
	// save the user input text (and we read it when the user taps the button)
	final TextEditingController _loginController = TextEditingController();

	bool _isLoading = false; // default button value

	// saving an error message to show under the search bar instead fo crushing (null = no error)
	String? _errorMessage;

  // "search" button handler
	Future<void> _onSearchPressed() async {
		final login = _loginController.text.trim(); // trimming whitespaces in input

		// check empty login
		if (login.isEmpty) {
      setState(() {
        _errorMessage = "Please enter a valid login";
      });
		return;
		}

    // login not empty
    // if any of these 2 variables change value, re-build the widget (render again the widget)
		setState(() {
      _isLoading = true;
      _errorMessage = null;
		});

		try {
    // cal the API with our api service
		final rawUser = await ApiService.getUser(login);
    // fully parses the raw response (large string) to create the full "user profile" object
		final profile = UserProfile.fromJson(rawUser);

		if (!mounted) // check the State property "mounted" = if true the screen is rendered on screen
      return; // return/stop if the user exits the page while the API call or parser haven't ended yet

    // search is done
		setState(() {
			_isLoading = false;
		});

    // we get transported to the next screen (the user's profile display) = open/create a new ProfileScreen using our UserProfil object
		// flutter stacks the new screen on top of the old one (and we can go back to the search screen with the arrow automatically)
    Navigator.push(
			context,
			MaterialPageRoute(builder: (context) => ProfileScreen(profile: profile)),
		);
		} catch (e) {
      if (!mounted)
        return;

      setState(() {
        _isLoading = false;
        _errorMessage = e.toString().replaceFirst('Exception: ', ''); // ApiService throws Exception('message'); Dart's default toString() prints "Exception: message", so we strip that prefix
      });
		}
	}

	// controller destructor = a clean up method Flutter calls automatically when a screen is removed/closed (controllers need manual clean up to not leak memory, unlike widgets) = flutter doesn't do this automatically
	@override
	void dispose()
	{
		_loginController.dispose();
		super.dispose();
	}

  // the spacings are not hard-coded pixels, but flexible layout
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(title: const Text('Swifty Companion')),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // background layer
          Image.asset('assets/images/background.jpg',
          fit: BoxFit.cover), // fit on screen
          // middle layer: a dark overlay, so text stays readable no matter which part of the image is behind it
          Container(color: Colors.black.withOpacity(0.35)),
          // top layer: the real screen content
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView( // can scroll if it doesn't fit the small screen
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: constraints.maxHeight),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [ // Title text
                          const Text(
                            'User Search',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 16), // user input field
                          TextField(
                            controller: _loginController,
                            autocorrect: false,
                            enableSuggestions: false,
                            textCapitalization: TextCapitalization.none,
                            style: const TextStyle(color: AppColors.textPrimary),
                            decoration: const InputDecoration(
                              labelText: 'Login',
                              hintText: 'Search for a login here',
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                            ),
                            // listens to the button press :
                            onSubmitted: _isLoading ? null : (_) => _onSearchPressed(), // lets the user hit Enter/Done too, not just tap the button
                          ),
                          const SizedBox(height: 16), // the "search button"
                          ElevatedButton(
                            onPressed: _isLoading ? null : _onSearchPressed, // disable the button while a search is already running
                            child: _isLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator( // loading icon
                                      strokeWidth: 2,
                                      color: AppColors.textPrimary,
                                    ),
                                  )
                                : const Text('Search'),
                          ),
                          // the error messages (if exist)
                          if (_errorMessage != null) ...[ //the ... "spreads" a list of widgets into the parent list, and combined with the if, it means to only include these widgets at all if the condition is true
                            const SizedBox(height: 16),
                            Text(
                              _errorMessage!,
                              style: const TextStyle(color: AppColors.coral), // error color
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
