# Swifty-Companion

A mobile application built with Flutter and Dart that allows 42 students to search for other students using their 42 login and view their profile, project history, and skills through the 42 API. This project demonstrates mobile application development, REST API integration, OAuth2 authentication, responsive UI design, and asynchronous network programming.

## Authors

Swifty Companion is developed as an individual project by me at 42 Paris École, showcasing understanding of mobile application development with Flutter and Dart, RESTful API integration, OAuth2 authentication, asynchronous programming, and responsive user interface design.

## Key Features

### 42 API Integration

- 42 Student Search: Search for any 42 student using their login
- REST API Communication: Retrieve student information through the 42 API
- JSON Data Processing: Parse and display structured API responses
- User Profile Data: Retrieve profile information from the 42 users endpoint
- Project History: Retrieve the complete project history of a student
- Failed Projects: Display projects regardless of their final result
- Skills Data: Retrieve and display the student's skills and levels
- Network Communication: Handle asynchronous HTTP requests

### OAuth2 Authentication

- OAuth2 Protocol: Authentication using the 42 API OAuth2 system
- Client Credentials Flow: Authenticate the application using a UID and SECRET
- Access Token Management: Obtain and reuse a single access token for API requests
- Token Reuse: Avoid creating a new token for every API query
- Token Expiration Handling: Request a new token when the current token expires
- Secure Credentials: API credentials stored outside the source code

### Student Profile

- Profile Picture: Display the student's 42 profile image
- Login: Display the student's 42 login
- Email: Display the student's email address
- Telephone: Display the student's phone number
- Current Level: Display the student's current 42 level
- Wallet: Display the student's wallet balance
- Profile Navigation: Navigate between profile information, projects, and skills

### Project History

- Complete Project List: Display the student's project history
- Project Names: Display the name of each project
- Project Results: Display the final mark for each project
- Failed Projects: Include failed projects in the project history
- Scrollable Interface: Navigate through the complete project list
- API Data Handling: Process project information retrieved from the 42 API

### Skills Management

- Complete Skill List: Display all available student skills
- Skill Names: Display skills such as Unix, Web, Algorithms & AI, etc.
- Skill Levels: Display the student's level for each skill
- Skill Percentages: Display the progression percentage for each skill
- Scrollable Interface: Navigate through the complete skill list

### Responsive Mobile Interface

- Responsive Layout: Adapt the interface to different screen sizes
- Portrait Support: Optimized for portrait orientation
- Landscape Support: Optimized for landscape orientation
- Flexible Layouts: Use Flutter's responsive layout widgets
- Dynamic Sizing: Avoid fixed screen coordinates and hardcoded dimensions
- Mobile Compatibility: Support different mobile screen sizes and aspect ratios

### Error Handling

- Empty Input Handling: Prevent searches with empty or invalid input
- User Not Found: Handle 404 responses from the 42 API
- Network Errors: Handle connection failures and unavailable networks
- Request Timeouts: Handle requests that exceed the allowed response time
- Authentication Errors: Handle OAuth2 token acquisition failures
- API Errors: Gracefully handle unexpected API responses
- User Feedback: Display appropriate error messages without crashing the application

## Application Architecture

### Flutter Application

- Dart Programming Language: Application logic implemented in Dart
- Flutter SDK: Cross-platform mobile application framework
- Widget-Based UI: Interface built using Flutter widgets
- Stateful Components: Manage dynamic application state
- Asynchronous Programming: Handle API requests without blocking the interface
- Navigation: Switch between search and student profile views

### API Client

- HTTP Client: Communicate with the 42 API through HTTP requests
- REST Endpoints: Access user, project, and skill resources
- Authorization Headers: Send OAuth2 Bearer tokens with API requests
- JSON Parsing: Convert API responses into application data
- Error Handling: Process HTTP and network errors

### Application Flow

1. Application starts
2. OAuth2 access token is obtained from the 42 API
3. User enters a 42 login
4. Application sends an authenticated request to the 42 API
5. Student information is retrieved and parsed
6. Student profile is displayed
7. User can navigate between Profile, Projects, and Skills
8. The existing OAuth2 token is reused for subsequent API requests
9. A new token is obtained only when the current token expires

## Configuration

The application requires 42 API credentials to authenticate with the 42 API.

Create a `.env` file in the root of the `src` directory and add the API credentials obtained through the 42 Intranet:

```env
UID=XXXX
SECRET=XXXX
```

Replace `XXXX` with the corresponding UID and SECRET provided by the 42 API application.

The `.env` file contains sensitive credentials and must not be committed to the repository.

## Usage Examples

### Application Initialization

```bash
flutter pub get
flutter run
```

Before launching the application, make sure the required `.env` file is present in the root of the `src` directory and contains valid 42 API credentials.

## Development & Debugging

The application includes development logging and error handling for:

- OAuth2 token acquisition
- API requests and responses
- HTTP status codes
- Network connectivity issues
- Request timeouts
- JSON parsing
- Invalid student logins
- API authentication errors

## Security Considerations

- API UID and SECRET are not committed to the repository
- Sensitive credentials are stored in the `.env` file outside the application source code
- The `.env` file is excluded through `.gitignore`
- API credentials are obtained through the 42 Intranet
- OAuth2 access tokens are reused instead of requesting a new token for every query
- API requests use authenticated HTTPS communication

## Implementation Notes

This implementation focuses on educational purposes and demonstrates professional mobile application development using Dart and Flutter. The project emphasizes practical understanding of Flutter application architecture, REST API communication, OAuth2 authentication, asynchronous programming, responsive UI design, JSON data processing, and robust error handling.

The application uses the 42 API as its primary data source and follows the API's OAuth2 authentication requirements to securely retrieve student information.

## Presentation Demo

<p align="center">
  <video src="https://github.com/user-attachments/assets/2c717042-0e14-416a-863f-d2e805b65174" controls width="600"></video>
</p>

## Screenshots

<p align="center">
  <img src="assets/home.png" width="250">
  <img src="assets/profile.png" width="250">
  <img src="assets/projects.png" width="250">
  <img src="assets/skills.png" width="250">
</p>
