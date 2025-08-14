# Bottom Navigation System

This directory contains the implementation of a complete bottom navigation system for the Flutter eCommerce app using Clean Architecture and BLoC state management.

## 🏗️ Architecture Structure

```
lib/presentation/
├── bloc/
│   ├── navigation/
│   │   ├── navigation_bloc.dart      # Navigation state management
│   │   ├── navigation_event.dart     # Navigation events
│   │   └── navigation_state.dart     # Navigation state
│   └── cart/
│       ├── cart_bloc.dart            # Cart state management
│       ├── cart_event.dart           # Cart events
│       └── cart_state.dart           # Cart state
├── pages/
│   ├── main_navigation_screen.dart   # Main screen with tabs
│   ├── home_page.dart                # Home tab
│   ├── categories_page.dart          # Categories tab
│   ├── cart_page.dart                # Cart tab with badge
│   ├── wishlist_page.dart            # Wishlist tab
│   └── profile_page.dart             # Profile tab
├── widgets/
│   └── bottom_navigation_bar_widget.dart  # Bottom navigation bar
└── routes/
    └── app_routes.dart               # Route definitions
```

## 🎯 Features

### 5 Main Tabs:
1. **Home** 🏠 - Main shop page
2. **Categories** 📂 - Product categories
3. **Cart** 🛒 - Shopping cart with dynamic badge
4. **Wishlist** ❤️ - Saved items
5. **Profile** 👤 - User account & settings

### Key Features:
- ✅ **BLoC State Management** - Clean separation of concerns
- ✅ **Dynamic Cart Badge** - Shows real-time item count
- ✅ **Persistent Navigation** - State persists across tab switches
- ✅ **Theme Compatible** - Works with light/dark themes
- ✅ **Clean Architecture** - Follows Clean Architecture principles

## 🚀 Usage

### 1. Navigate to Main Navigation:
```dart
Navigator.of(context).pushReplacementNamed('/main');
```

### 2. Add Items to Cart:
```dart
context.read<CartBloc>().add(const CartItemAdded('Product Name'));
```

### 3. Remove Items from Cart:
```dart
context.read<CartBloc>().add(CartItemRemoved('Product Name'));
```

### 4. Clear Cart:
```dart
context.read<CartBloc>().add(CartCleared());
```

### 5. Switch Tabs Programmatically:
```dart
context.read<NavigationBloc>().add(NavigationTabChanged(2)); // Go to Cart tab
```

## 🔧 Customization

### Adding New Tabs:
1. Create a new page in `lib/presentation/pages/`
2. Add the page to `MainNavigationScreen` in the `IndexedStack`
3. Add the tab item to `BottomNavigationBarWidget`
4. Update the navigation logic if needed

### Modifying Tab Icons:
Edit the `BottomNavigationBarItem` in `bottom_navigation_bar_widget.dart`:
```dart
BottomNavigationBarItem(
  icon: Icon(Icons.your_icon),
  label: 'Your Tab',
),
```

### Customizing Cart Badge:
Modify the badge styling in `bottom_navigation_bar_widget.dart`:
```dart
Container(
  padding: const EdgeInsets.all(2),
  decoration: BoxDecoration(
    color: Theme.of(context).colorScheme.error,
    borderRadius: BorderRadius.circular(10),
  ),
  // ... badge content
),
```

## 📱 State Management

### Navigation State:
- `selectedIndex`: Current active tab index (0-4)
- Automatically updates when user taps tabs

### Cart State:
- `items`: List of cart item names
- `itemCount`: Computed property for badge display
- Supports add, remove, and clear operations

## 🎨 UI/UX Features

- **Modern Design**: Clean, minimal bottom navigation
- **Dynamic Badge**: Real-time cart item count display
- **Theme Integration**: Uses app's color scheme
- **Smooth Transitions**: IndexedStack prevents page rebuilds
- **Responsive Layout**: Fixed navigation bar type

## 🔍 Testing

### Unit Tests:
- Test navigation state changes
- Test cart operations (add, remove, clear)
- Test badge count calculations

### Widget Tests:
- Test tab switching
- Test cart badge display
- Test navigation persistence

## 📚 Dependencies

- `flutter_bloc`: State management
- `equatable`: Value equality for BLoC states
- Built-in Flutter Material Design components

## 🚨 Important Notes

1. **State Persistence**: Navigation state persists across tab switches
2. **Performance**: Uses `IndexedStack` to prevent unnecessary rebuilds
3. **Memory Management**: BLoCs are properly disposed when not needed
4. **Theme Compatibility**: Automatically adapts to light/dark themes

## 🔄 Future Enhancements

- [ ] Add tab-specific app bars
- [ ] Implement tab-specific navigation stacks
- [ ] Add tab switching animations
- [ ] Support for more than 5 tabs
- [ ] Tab-specific state persistence
- [ ] Deep linking support
