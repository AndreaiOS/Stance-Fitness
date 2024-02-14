# Stance Fitness

<img src="https://github.com/AndreaiOS/Stance-Fitness/assets/9194501/d7dcc5e1-b06f-4090-bf80-58971182121e" alt="image" width="300" height="auto">
<img src="https://github.com/AndreaiOS/Stance-Fitness/assets/9194501/8e6228bf-4177-4d65-805b-00c918d49f40" alt="image" width="300" height="auto">

## Objective

This iOS application demonstrates the use of SwiftUI, Combine, and CoreBluetooth frameworks to detect and manage Bluetooth device connections. It allows users to view the current Bluetooth status, refresh and scan for nearby Bluetooth devices, and manage connections with a simple and intuitive interface.

## Features

### Bluetooth Status Indicator

Displays the current Bluetooth status at the top of the main view. The status is shown as 'ON' in green when Bluetooth is active and 'OFF' in red when inactive

### Refresh Bluetooth Connection

Includes a refresh button to disconnect from any connected device and initiate a new scan for devices

### Device List

Presents a list of nearby Bluetooth devices. Users can tap on a device to connect or disconnect. Connected devices are indicated with a green dot next to their name

### Connection Error Handling

Alerts users to any connection errors with pop-up alerts

## Getting Started

Follow these instructions to get the app running on your local machine for development and testing purposes.

### Prerequisites

* Xcode 13 or later
* An iOS device or simulator running iOS 17.0 or later
* Bluetooth capability for testing device connections

### Installing

* Clone the repository
```
sh git clone git@github.com:AndreaiOS/Stance-Fitness.git
cd StanceFitnessTest
```
* Open the project in Xcode
Open StanceFitnessTest.xcodeproj in Xcode.
* Select your target device
Choose an iOS device or simulator running iOS 17.0 or later.
* Run the application
Press the Run button in Xcode to build and run the application.

### Note on installinmg on a real device
To deploy and test the "Stance Fitness" application on an actual iOS device, you will need to perform a series of steps within Xcode, Apple's integrated development environment (IDE) for macOS. This process requires an Apple ID and involves selecting a development team within Xcode. Here is an exhaustive guide to facilitate a smooth installation process:

** Prerequisites
* Apple ID: Ensure you have an active Apple ID, which is necessary for signing into Xcode and provisioning your app. If you do not have an Apple ID, you can create one at https://appleid.apple.com.
* Xcode: Install the latest version of Xcode from the Mac App Store. Ensure that your version of Xcode is compatible with the operating system version of your iOS device.
* iOS Device: An iPhone or iPad running iOS 17.0 or later.
**  Steps for Installation
* Open Your Project in Xcode:
Launch Xcode and open the "Stance Fitness" project by selecting "Open another project..." and navigating to your project's location.
* Sign in with Your Apple ID:
Go to Xcode's Preferences (Xcode > Preferences in the menu bar) and select the "Accounts" tab.
Click the "+" button at the bottom left to add a new account.
Select "Apple ID" and click "Continue."
Sign in with your Apple ID credentials.
*  Configure Your Project with Your Apple ID:
In the Project Navigator, select your project to open the project settings.
Navigate to the "Signing & Capabilities" tab.
Choose your target from the list on the left, then find the "Team" dropdown menu in the "Signing" section.
Select your Apple ID from the "Team" dropdown. If you have not created a development team on the Apple Developer website, your Apple ID will suffice for personal use and testing.
* Connect Your iOS Device:
Use a USB cable to connect your iOS device to your Mac.
Unlock your device and trust the computer (if prompted).
* Select Your Device in Xcode:
In Xcode, find the active scheme dropdown menu near the top left corner.
Select your connected device from the list of available devices.
* Build and Run the Application:
Click the "Run" button (represented by a play symbol) in the top left corner of Xcode.
Xcode will compile the project and install it on your connected iOS device.
If prompted, accept the prompt on your iOS device to trust the developer certificate.
* Trust the Developer Certificate on Your iOS Device (if required):
On your iOS device, go to Settings > General > Device Management.
Under "Developer App," tap your Apple ID, then tap "Trust [Your Apple ID]."
Confirm by tapping "Trust" in the dialog that appears.

### Running the Tests
This project includes unit tests to verify the functionality of the Bluetooth management system.
To run the tests, select the test navigator in Xcode and click the play button next to the test suite


### Built With

SwiftUI - For building the user interface.
Combine - For handling asynchronous events.
CoreBluetooth - For managing Bluetooth connections.

## License

This project is licensed under the MIT License

## Implementation Decisions

** Use of CoreBluetooth for Bluetooth Management
* Central Manager Initialization: The CBCentralManager is initialized in the BluetoothManager's init method, setting self as its delegate to handle Bluetooth events. This approach ensures that the BluetoothManager has immediate control over the Bluetooth hardware as soon as it's instantiated, allowing for real-time updates and actions based on Bluetooth state changes.
* Dynamic Bluetooth Status: The @Published var isBluetoothEnabled property reflects the current state of the Bluetooth on the device, enabling SwiftUI views to automatically update based on this state. This decision supports the requirement to display Bluetooth status dynamically in the UI, adhering to the reactive programming paradigm facilitated by Combine.
* Device Scanning and Management: Functions like startScanning, stopScanning, connect(to:), and disconnect(from:) provide a clear and structured interface for managing Bluetooth device interactions. This encapsulation allows for easy modification and testing of Bluetooth functionalities separately from the UI logic.
** SwiftUI and Combine Integration
* Reactive UI Updates: The use of @Published properties for device discovery, connection states, and alert management integrates seamlessly with SwiftUI views. This design choice enables reactive UI updates, where changes in the Bluetooth manager's state automatically reflect in the user interface without additional boilerplate code.
* Error Handling and User Feedback: Implementing user feedback through alertMessage and isAlertPresented properties demonstrates how to communicate asynchronous operation outcomes (e.g., connection timeouts or errors) back to the user. This approach leverages SwiftUI's alert presentation mechanism, enhancing user experience by providing timely and informative feedback.
** Architectural Considerations
* Modularity and Responsibility: The BluetoothManager class is designed with a clear responsibility: managing Bluetooth interactions. This focused approach adheres to the Single Responsibility Principle, making the class more maintainable and testable.
* Extensibility for Future Enhancements: The structure of the BluetoothManager, with clear separation of concerns and modular functionality, lays a solid foundation for extending the application. Additional features, such as filtering devices by service UUIDs or implementing more complex connection strategies, can be integrated with minimal changes to the existing codebase.
** Testing and Reliability
* Mocking and Protocol Use: By abstracting some of the CoreBluetooth interactions behind protocols (not fully shown in the provided code but suggested through the handling of PeripheralProtocol), the design allows for easier unit testing and mocking of Bluetooth hardware behavior. This approach facilitates comprehensive testing without the need for actual Bluetooth devices, improving the reliability and robustness of the application.

### Total Time Spent

6 hours
