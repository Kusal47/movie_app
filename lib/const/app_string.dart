class AppStrings {
  //Fetching movies from the api
  static const String apiKey = '3b3e044406dcc9dfd98161380ff671d0';
  static const String apiReadAccessToken =
      'eyJhdWQiOiIzYjNlMDQ0NDA2ZGNjOWRmZDk4MTYxMzgwZmY2NzFkMCIsInN1YiI6IjY0NDY2YzU4YzhmM2M0MDQ3NTQ1MGZlZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ';

  static const String appName = "Cinemenia";
  static const String trending = "Trending Movies";
  static const String popular = "Popular Movies";
  static const String topRated = "Top Rated Movies";
  static const String upcoming = "Upcoming Movies";
  static const String tvshows = "Popular Tvshows";
  static const String myAccount = "My Account";
  static const String settings = "Settings";
  static const String logout = "Logout";

  static const String results = "results";
  static const String email = "Email";
  static const String password = "Password";
  static const String fName = "First Name";
  static const String lName = "Last Name";
  static const String phone = "Phone Number";
  static const String confirmPassword = "Confirm Password";

//Strings for login Page
  static const String login = "Login Page";
  static const String loginbtn = "Login";
  static const String noAccount = "Don't have an account?";
  static const String registerNow = "Register Now";

//Strings for register Page
  static const String register = "Register Page";
  static const String registerbtn = "Register";
  static const String hasAccount = "Don't have an account?";
  static const String loginNow = "Login Now";
  static const String TOC = "Terms and Conditions";

  //Search
  static const String search = "Search movies...";
  static const String searchNotFound = "Searched result not found";

  static const String title = "title";
  static const String name = "name";
  static const String overview = "overview";
  static const String vote_average = "vote_average";
  static const String release_date = "release_date";
  static const String original_name = "original_name";
  static const String backdrop_path = "backdrop_path";
  static const String poster_path = "poster_path";
  static const String profile_path = "profile_path";
  static const String first_air_date = "first_air_date";
  static const String character = "character";
  static const String casts = "cast";

  static const String Processing = "Processing...";
  static const String loading = "Loading...";
  static const String descOverview = "Overview";
  static const String release_on = "Release Date: ";
  static const String rating = "Rating: ";
  static const String tickets = "Buy Tickets";
  static const String trailer = "Watch Trailer";
  static const String return_to_details = "Return";
  static const String castNames = "Cast";
  static const String cast_unavailable = "Cast Unavailable";

  //errors
  static const String tvShows_error = "Sorry, this Tvshow is unavailable.";
  static const String nodata = "No data found";
  static const String ok = "OK";
  static const String id = "id";
  static const String users = "users";

  //Validation Strings
  static const String required_ConfirmPass = "Please Confirm your Password";
  static const String validate_ConfirmPass = "Password did not match";

  //FirstName Validation
  static const String required_firstName = "Please enter your First name";

  //LastName Validation
  static const String required_lastName = "Please enter your Last name";

  //Phone Number Validation
  static const String required_phone = "Please enter your phone number";
  static const String validate_phone = "Phone number is invalid";

  //Email Validation
  static const String regExp =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  static const String required_email = "Please enter your Email";
  static const String validate_email = "Please enter valid Email";

  //Password Validation
  static const String required_Password = "Please enter your Password";
  static const String validate_Password =
      "Password must be atleast 8 character";
}
