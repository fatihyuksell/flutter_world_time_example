# World Time App

A Flutter application that integrates theme management, splash screen, connectivity check, dynamic home screen, and time zone data retrieval using Retrofit.

## Getting Started

This project provides a starting point for a Flutter app with several key features, including:

- **Theme Management**: Toggle between light and dark themes based on user preferences.
- **Splash Screen**: Displays a splash screen and checks internet connectivity before navigating to the home screen.
- **Home Screen**: Displays a list of regions with search functionality and supports refreshing the list.
- **Time Zone Information**: Retrieves time zone data using `TimeInformationService`, which utilizes Retrofit.
- **Error Handling**: Global error handling to log exceptions.

### Features

- **Theme Management**: Light/dark theme toggle.
- **Splash Screen**: Connectivity check and loading state.
- **Time Zone Information**: Fetch time zone list and specific time zone details using Retrofit.
- **Localization**: Multi-locale support for regional data display.


## Architecture Overview

- **MVVM (Model-View-ViewModel)**: The project follows the MVVM pattern, separating the UI layer (Views) from the business logic (ViewModels), and keeping the data management (Models) separate.
  
- **Provider**: State management in this project is handled using the `Provider` package. This allows for easy injection of dependencies and updates to UI when the underlying data changes.

- **Dependency Injection**: Dependency Injection is achieved using `get_it` for managing and providing access to services across the app. This allows the project to maintain a decoupled and modular structure.

- **Retrofit**: API services are defined using Retrofit, allowing for easy and clean integration with external APIs. The network services are abstracted in service classes and are injected into the ViewModels.

## ViewModel and Views

Each view in the application has a corresponding **ViewModel**, which is responsible for business logic and data processing. Views themselves are kept lightweight, only managing UI and delegating logic to the ViewModel.

### ViewModelBuilder

- Every screen is wrapped in a `ViewModelBuilder`, which creates the ViewModel and binds it to the view. This ensures that the correct ViewModel is available to handle the logic for that specific screen.

### BaseViewModel

- All ViewModels inherit from a **BaseViewModel**. This base class provides common functionality like managing loading states, handling errors, and notifying listeners. It serves as a foundation for all screen-specific ViewModels.

### Example Code Structure

Here is a basic overview of how a screen (view) and its ViewModel are set up:

1. **View**: Each view is defined as a stateless widget, and the `ViewModelBuilder` is used to bind the ViewModel to the view.

```dart
class TimeZoneDetailsView extends StatelessWidget {
  const TimeZoneDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TimeZoneDetailsViewModel>(
      initViewModel: () => TimeZoneDetailsViewModel(
        locator<TimeInformationService>(),
      ),
      builder: (context, viewModel) => ScaffoldView(
        body: Column(
          children: [
            // UI components
          ],
        ),
      ),
    );
  }
}
```


In this README:
1. I’ve outlined the architecture of the app, including the use of MVVM, Provider, Dependency Injection, and Retrofit.
2. I’ve provided a basic overview of how the views and ViewModels are structured.
3. I’ve included sections for dependencies, setup instructions, and contribution guidelines.

This should provide a solid foundation for the README of your project!

⚠️ **Uyarı:** Due to irregular operation of worldtimeapi, a new request mechanism has been established.
