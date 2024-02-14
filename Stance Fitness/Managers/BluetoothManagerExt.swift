//
//  BluetoothManagerExt.swift
//  Stance Fitness
//
//  Created by Andrea Murru on 14/02/2024.
//

import CoreBluetooth

extension BluetoothManager: CBCentralManagerDelegate {
   func centralManagerDidUpdateState(_ central: CBCentralManager) {
       switch central.state {
       case .poweredOn:
           isBluetoothEnabled = true
           // Optionally start scanning for devices or enable features that require Bluetooth.
       case .poweredOff:
           isBluetoothEnabled = false
           // Provide a user-friendly message or UI prompt suggesting to turn on Bluetooth.
           notifyUserToEnableBluetooth("Bluetooth is turned off. Please enable Bluetooth in Settings to use all the app features.")
       case .unauthorized:
           // Handle the case where the user has not granted permission to use Bluetooth.
           handleBluetoothUnauthorized()
       case .unsupported:
           // Inform the user that their device does not support Bluetooth.
           showAlertWithMessage("Your device does not support Bluetooth. Some features may not be available.")
       case .resetting:
           // The connection with the system Bluetooth service was momentarily lost; update UI or state accordingly.
           handleBluetoothResetting()
       case .unknown:
           // The current state of the Bluetooth Manager is unknown; wait for another state update.
           handleUnknownBluetoothState()
       @unknown default:
           // Handle future states
           handleFutureBluetoothStates()
       }
   }
   
   func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
       if !discoveredPeripherals.contains(where: { $0.identifier == peripheral.identifier }) {
           discoveredPeripherals.append(peripheral)
       }
   }
   
   func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
       connectionStates[peripheral.identifier] = true // Connected
   }
   
   func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
       connectionStates[peripheral.identifier] = false // Disconnected
   }
   
   func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
       // Update the connection state
       connectionStates[peripheral.identifier] = false
       // Remove from connected peripherals if needed
       if let index = connectedPeripherals.firstIndex(of: peripheral) {
           connectedPeripherals.remove(at: index)
       }
       // Handle the error, notify the user
       let errorMessage = error?.localizedDescription ?? "Failed to connect to the device."
       showAlertWithMessage("Connection failed: \(errorMessage)")
   }

}
