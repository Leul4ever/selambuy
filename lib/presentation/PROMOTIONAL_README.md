# 🎯 Promotional Section System

This directory contains a complete promotional section implementation for the Flutter eCommerce app using Clean Architecture and BLoC state management.

## 🏗️ Architecture Structure

```
lib/presentation/
├── bloc/
│   └── promotional/
│       ├── promotional_bloc.dart      # Main promotional BLoC
│       ├── promotional_event.dart     # Promotional events
│       └── promotional_state.dart     # Promotional state & models
├── widgets/
│   ├── banner_carousel_widget.dart    # Banner carousel with auto-scroll
│   └── promotional_section_widget.dart # Promotional sections display
├── services/
│   └── promotional_data_service.dart  # Sample data service
└── pages/
    └── demo_home_page.dart            # Demo home page showcasing features
```

## 🎠 Features

### 1. **Banner Carousel** 🎡
- ✅ **Auto-scrolling** with configurable duration
- ✅ **Page indicators** with smooth animations
- ✅ **Touch navigation** support
- ✅ **Gradient overlays** for text readability
- ✅ **Action buttons** for each banner
- ✅ **Responsive design** with rounded corners

### 2. **Promotional Sections** 🏷️
- ✅ **New Arrivals** - Latest products
- ✅ **Seasonal Offers** - Time-based promotions
- ✅ **Discount Deals** - Special pricing
- ✅ **Horizontal scrolling** lists
- ✅ **Product cards** with badges and pricing
- ✅ **View All** navigation buttons

### 3. **State Management** 🧠
- ✅ **BLoC pattern** for clean architecture
- ✅ **Auto-scroll control** (enable/disable)
- ✅ **Banner index tracking**
- ✅ **Content loading** management
- ✅ **Equatable** for efficient state comparison

## 🚀 Usage

### 1. **Setup Promotional BLoC:**
```dart
MultiBlocProvider(
  providers: [
    BlocProvider<PromotionalBloc>(
      create: (context) => PromotionalBloc(),
    ),
  ],
  child: YourWidget(),
)
```

### 2. **Load Sample Data:**
```dart
final promotionalBloc = context.read<PromotionalBloc>();
PromotionalDataService.loadSampleData(promotionalBloc);
```

### 3. **Display Banner Carousel:**
```dart
BlocBuilder<PromotionalBloc, PromotionalState>(
  builder: (context, state) {
    return BannerCarouselWidget(
      banners: state.banners,
      height: 200,
      autoScrollDuration: Duration(seconds: 3),
    );
  },
)
```

### 4. **Display Promotional Sections:**
```dart
const PromotionalSectionWidget()
```

## 🎨 UI Components

### **Banner Carousel Widget**
- **Auto-scrolling**: Configurable timer-based navigation
- **Page indicators**: Animated dots showing current position
- **Touch support**: Swipe to navigate between banners
- **Gradient overlays**: Ensures text readability over images
- **Action buttons**: Call-to-action buttons for each banner

### **Promotional Section Widget**
- **Section headers**: Icons, titles, and "View All" buttons
- **Horizontal lists**: Smooth scrolling product lists
- **Product cards**: Images, titles, descriptions, pricing
- **Badges**: NEW, SEASONAL, FLASH, CLEARANCE, BUNDLE
- **Discount display**: Original vs. discounted pricing

### **Product Cards**
- **Image display**: Product images with error handling
- **Badge system**: Color-coded promotional badges
- **Pricing**: Original, discounted, and percentage off
- **Responsive layout**: Adapts to different screen sizes

## 📱 Data Models

### **PromotionalBanner**
```dart
class PromotionalBanner {
  final String id;
  final String imageUrl;
  final String title;
  final String subtitle;
  final String? actionText;
  final String? actionRoute;
}
```

### **PromotionalItem**
```dart
class PromotionalItem {
  final String id;
  final String imageUrl;
  final String title;
  final String subtitle;
  final double? originalPrice;
  final double? discountedPrice;
  final double? discountPercentage;
  final String? badgeText;
  final String? badgeColor;
}
```

## 🔧 Customization

### **Banner Carousel:**
```dart
BannerCarouselWidget(
  banners: yourBanners,
  height: 250,                    // Custom height
  autoScrollDuration: Duration(seconds: 5), // Custom scroll speed
)
```

### **Promotional Sections:**
```dart
// Custom badge colors
PromotionalItem(
  badgeColor: 'custom', // Add to _getBadgeColor method
  // ... other properties
)
```

### **Styling:**
- **Colors**: Uses theme color scheme
- **Typography**: Follows Material Design guidelines
- **Spacing**: Consistent padding and margins
- **Shadows**: Subtle elevation effects

## 🎯 Events & States

### **Events:**
- `PromotionalBannerChanged(int index)` - Banner navigation
- `PromotionalAutoScrollToggled(bool isAutoScrolling)` - Auto-scroll control
- `PromotionalContentLoaded(...)` - Load promotional content

### **States:**
- `currentBannerIndex` - Current banner position
- `isAutoScrolling` - Auto-scroll enabled/disabled
- `banners` - List of promotional banners
- `newArrivals` - New product items
- `seasonalOffers` - Seasonal promotional items
- `discountDeals` - Discounted product items

## 🔄 Auto-scroll Behavior

### **Features:**
- **Automatic navigation** between banners
- **Configurable duration** (default: 3 seconds)
- **Loop navigation** (returns to first banner)
- **Touch interruption** - Pauses auto-scroll on user interaction
- **State control** - Can be enabled/disabled via BLoC

### **Implementation:**
```dart
Timer.periodic(autoScrollDuration, (timer) {
  if (mounted && state.isAutoScrolling) {
    // Navigate to next banner
  }
});
```

## 🎨 Theme Integration

### **Color Scheme:**
- **Primary colors**: Used for main elements
- **Surface colors**: Background and card colors
- **Error colors**: Discount badges and special offers
- **Opacity variations**: Text and overlay transparency

### **Typography:**
- **Headline styles**: Section titles and main text
- **Body styles**: Descriptions and secondary text
- **Title styles**: Product names and pricing
- **Consistent sizing**: Follows Material Design scale

## 🧪 Testing

### **Unit Tests:**
- Test promotional state changes
- Test banner navigation events
- Test auto-scroll functionality
- Test content loading

### **Widget Tests:**
- Test banner carousel navigation
- Test promotional section display
- Test product card interactions
- Test responsive behavior

## 📚 Dependencies

- `flutter_bloc`: State management
- `equatable`: Value equality for BLoC states
- Built-in Flutter Material Design components

## 🚨 Important Notes

1. **Image Assets**: Ensure images exist in `assets/images/` directory
2. **Performance**: Uses `IndexedStack` for efficient tab navigation
3. **Memory Management**: Properly disposes timers and controllers
4. **Error Handling**: Graceful fallbacks for missing images
5. **Responsiveness**: Adapts to different screen sizes

## 🔄 Future Enhancements

- [ ] **Deep linking** to promotional content
- [ ] **Analytics tracking** for banner interactions
- [ ] **A/B testing** for promotional content
- [ ] **Dynamic content** from API
- [ ] **Personalization** based on user preferences
- [ ] **Animation effects** for product cards
- [ ] **Search integration** within promotional content
- [ ] **Social sharing** for promotional items

## 🎉 Demo

The system includes a complete demo home page (`demo_home_page.dart`) that showcases:
- Welcome section with gradient background
- Banner carousel with sample data
- All promotional sections (New Arrivals, Seasonal Offers, Discount Deals)
- Quick action cards
- Responsive design with proper spacing

Run the app and navigate to the Home tab to see the promotional system in action!
