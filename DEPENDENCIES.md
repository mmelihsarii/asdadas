# Dependencies Summary

## Production Dependencies

### Core
- **flutter**: SDK
- **cupertino_icons** ^1.0.8 - iOS style icons

### Backend & Auth
- **supabase_flutter** ^2.5.0 - Supabase client (Auth, Database, Storage, Realtime)
- **flutter_dotenv** ^5.1.0 - Environment variables

### State Management
- **flutter_riverpod** ^2.5.1 - Reactive state management
- **riverpod_annotation** ^2.3.5 - Annotations for code generation

### Routing
- **go_router** ^14.0.0 - Declarative routing

### Code Generation
- **freezed_annotation** ^2.4.1 - Immutable models
- **json_annotation** ^4.9.0 - JSON serialization

### UI & Design
- **google_fonts** ^6.2.1 - Inter font family
- **cached_network_image** ^3.3.1 - Cached images
- **shimmer** ^3.0.0 - Loading shimmer effect

### Maps & Location
- **flutter_map** ^7.0.0 - OpenStreetMap integration
- **latlong2** ^0.9.1 - Latitude/longitude utilities
- **geolocator** ^12.0.0 - Device location

### Media
- **image_picker** ^1.1.2 - Pick images from gallery/camera

### Internationalization
- **intl** ^0.19.0 - Date/time formatting (tr_TR locale)

## Development Dependencies

### Testing
- **flutter_test**: SDK
- **flutter_lints** ^6.0.0 - Linting rules

### Code Generation
- **build_runner** ^2.4.11 - Code generation runner
- **riverpod_generator** ^2.4.0 - Generate Riverpod providers
- **freezed** ^2.5.7 - Generate immutable models
- **json_serializable** ^6.8.0 - Generate JSON serialization

## Total Packages

**Production**: 15 packages
**Development**: 5 packages
**Total**: 20 packages

## Installation

```bash
flutter pub get
```

## Code Generation

```bash
# Generate code (models, providers, serialization)
flutter pub run build_runner build --delete-conflicting-outputs

# Watch mode (auto-generate on file changes)
flutter pub run build_runner watch --delete-conflicting-outputs
```

## Analysis

```bash
# Run static analysis
flutter analyze

# Check for outdated packages
flutter pub outdated
```

## Notes

- All packages are compatible with Flutter SDK ^3.10.7
- Some packages have newer versions available but are constrained by dependencies
- Run `flutter pub outdated` to see upgrade options
