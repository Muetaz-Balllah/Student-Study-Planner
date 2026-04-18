## Student-Study-Planner

A polished Flutter mobile application for managing university course information.

> **Mobile-only app**: Designed specifically for Android and iOS devices. This project is not targeted for web or desktop deployment.

## Overview

Course Manager provides a lightweight mobile interface to track, add, update, and remove course records. It uses a local SQLite database to persist course details and offers course browsing, search, sorting, and detail viewing.

## Key Features

- Welcome screen with a friendly entry flow
- Course list view with search and sorting
- Persistent local storage using `sqflite`
- Add new courses with course name, teacher, units, students, semester, hours, and image
- Edit existing courses and delete unwanted records
- Detailed course page with a clean mobile layout

## Screens

1. Welcome screen
2. Courses list screen
3. Add / edit course screen
4. Course detail screen

## Dependencies

- `flutter`
- `sqflite`
- `path`
- `cupertino_icons`

## Installation

1. Ensure Flutter is installed and available on your machine.
2. Open the project folder in your IDE or terminal.
3. Run dependency installation:

```bash
flutter pub get
```

## Running the App

Run on a connected mobile device or emulator:

```bash
flutter run
```

For Android only:

```bash
flutter run -d <device-name>
```

For iOS only (macOS required):

```bash
flutter run -d <device-id>
```

## Notes

- This app is intended for mobile platforms only.
- The database is stored locally on the device using SQLite.
- The UI is optimized for phone screen layouts.

## Project Structure

- `lib/main.dart` — app entry point
- `lib/welcome_page.dart` — landing screen
- `lib/course_list.dart` — main course list and search
- `lib/new_course.dart` — create/edit course screen
- `lib/details.dart` — course details page
- `lib/database_helper.dart` — local SQLite helper
- `lib/course.dart` — course data model
