# Project Documentation: Chatly (Cross-Platform Chat App)

## Overview

Chatly is a cross-platform chat application developed with Flutter and integrated with Firebase services. It allows users to register, log in, view a list of users, initiate 1-on-1 or group chats, and exchange messages in real-time.

---

## Goals

- Deliver a full-featured, real-time chat application.
- Ensure secure authentication and data handling via Firebase.
- Deploy the app using Docker and automate CI/CD using GitHub Actions.

---

## Features

- User registration and authentication using Firebase Auth
- Real-time messaging with Cloud Firestore
- Image upload with Firebase Storage
- Active/Last seen status
- Chat grouping and user searching
- Responsive UI with light/dark theme support

---

## Architecture

- **Frontend**: Flutter
- **Backend**: Firebase (Firestore, Auth, Storage)
- **Database**: NoSQL (Cloud Firestore)
- **Deployment**: Docker (for web)
- **CI/CD**: GitHub Actions

---

## Project Structure

```
lib/
  models/           # Data models (Chat, User, Message)
  pages/            # Screens (Login, Register, Home, Chat, Users)
  providers/        # State management (Auth, Chat, User page)
  services/         # Firebase services (Auth, Database, Storage)
  widgets/          # Custom reusable widgets
  main.dart         # App entry point
```

---

## Firebase Services Used

- **Authentication**: Email/Password login
- **Firestore Database**: Storing messages and user data
- **Firebase Storage**: Handling image uploads

---

## Deployment

1. **Docker**
   - Dockerfile added at root
   - Web build is hosted via `nginx` inside the container
2. **Running**:
   ```bash
   flutter build web
   docker build -t chatly-web .
   docker run -p 8080:80 chatly-web
   ```

---

## GitHub Actions

- `.github/workflows/flutter.yml` handles CI
- Workflow includes:
  - Flutter setup
  - Dependency resolution
  - Unit testing

---

## Testing

- **Unit tests** for:
  - ChatUser JSON serialization
  - DatabaseService (mocked)
  - Basic string utility functions

---

## Documentation & Diagrams

- **Deployment Diagram**: Located in `deployment_diagram/`
- **README.md**: Setup instructions and project overview

---

## How to Run

1. Install Flutter SDK >= 3.7.0
2. Run `flutter pub get`
3. Run the app:
   ```bash
   flutter run -d chrome  # or another device
   ```
4. For web deployment:
   ```bash
   flutter build web
   docker build -t chatly-web .
   docker run -p 8080:80 chatly-web
   ```

---

## Notes

- Ensure Firebase project is correctly configured.
- Set environment variables in a `.env` file (if extended).
- Test Firebase security rules before production.

---

## Authors

- Yassen Dimchov

---

## License

This project is licensed under the MIT License.

---

## Links

- [Flutter](https://flutter.dev/)
- [Firebase Console](https://console.firebase.google.com/)
- [GitHub Actions](https://github.com/features/actions)
