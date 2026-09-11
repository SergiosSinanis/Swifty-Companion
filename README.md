# Swifty-Companion

A mobile application built with Flutter and Dart that allows 42 students to search for other students using their 42 login and view their profile, project history, and skills through the 42 API. This project demonstrates mobile application development, REST API integration, OAuth2 authentication, responsive UI design, and asynchronous network programming.

## Authors

Swifty Companion is developed as an individual project at 42 École, showcasing understanding of mobile application development with Flutter and Dart, RESTful API integration, OAuth2 authentication, asynchronous programming, and responsive user interface design.

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

## Usage Examples

### Application initialization

```bash
flutter pub get
flutter run
```
