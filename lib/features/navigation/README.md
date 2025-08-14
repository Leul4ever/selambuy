# Navigation System

This directory contains the bottom navigation system for the Gebiya eCommerce app, implemented using Clean Architecture principles and BLoC state management.

## Architecture

### Structure
```
lib/features/navigation/
├── presentation/
│   ├── bloc/
│   │   ├── navigation_bloc.dart
│   │   ├── navigation_event.dart
│   │   └── navigation_state.dart
│   ├── pages/
│   │   ├── main_navigation_page.dart
│   │   ├── categories_page.dart
│   │   ├── cart_page.dart
│   │   ├── wishlist_page.dart
│   │   └── profile_page.dart
│   ├── widgets/
│   │   └── bottom_navigation_bar_widget.dart
│   └── routes/
│       └── navigation_routes.dart
└── README.md
```

### Features

#### Bottom Navigation Tabs
1. **Home** 🏠 - Main shop page with product grid
2. **Categories** 📂 - Product categories browsing
3. **Cart** 🛒 - Shopping cart with dynamic badge showing item count
4. **Wishlist** ❤️ - Saved items for later purchase
5. **Profile** 👤 - User account information and settings

#### State Management
- **NavigationBloc**: Manages the currently selected tab
- **CartBloc**: Manages cart state and provides item count for badge
- Uses `IndexedStack` for efficient tab switching without rebuilding

#### UI Features
- Modern, minimal design with Material Design 3
- Light/Dark mode compatible using theme colors
- Dynamic cart badge with item count
- Smooth tab transitions
- Responsive design for different screen sizes

## Usage

### Navigation
The main navigation page is accessible via the `/main-navigation` route. The onboarding flow automatically redirects to this page.

### Adding Items to Cart
Products can be added to cart from the home page. The cart badge will automatically update to show the current item count.

### Tab Switching
Users can switch between tabs using the bottom navigation bar. Each tab maintains its state independently.

## Dependencies
- `flutter_bloc` for state management
- `equatable` for value equality
- Built-in Flutter Material Design components

## Future Enhancements
- Add animations for tab transitions
- Implement tab-specific app bars
- Add deep linking support
- Implement tab persistence across app restarts
