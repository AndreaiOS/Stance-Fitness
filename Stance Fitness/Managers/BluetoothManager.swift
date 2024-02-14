//
//  BluetoothManager.swift
//  Stance Fitness
//
//  Created by Andrea Murru on 13/02/2024.
//

import Foundation
import CoreBluetooth
import Combine

class BluetoothManager: NSObject, ObservableObject {
    var centralManager: CBCentralManager!
    @Published var isBluetoothEnabled = false
    @Published var discoveredPeripherals = [CBPeripheral]()
    var connectedPeripherals = [CBPeripheral]()
    @Published var connectionStates: [UUID: Bool] = [:]
    @Published var isAlertPresented = false
    var alertMessage: String = ""
    
    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    func startScanning() {
        guard isBluetoothEnabled else { return }
        discoveredPeripherals.removeAll()
        centralManager.scanForPeripherals(withServices: nil, options: nil)
        retrieveConnectedPeripherals(serviceUUIDs: [CBUUID(string: "1800")])
    }
    
    func stopScanning() {
        centralManager.stopScan()
    }
    
    internal func connect(to peripheral: PeripheralProtocol) {
        guard let cbPeripheral = peripheral as? CBPeripheral else {
            // Handle error or perform fallback
            return
        }
        
        if !connectedPeripherals.contains(cbPeripheral) {
            connectedPeripherals.append(cbPeripheral)
        }
        centralManager.connect(cbPeripheral, options: nil)
        connectionStates[peripheral.identifier] = true
        
        // Set a timeout for the connection attempt
        DispatchQueue.main.asyncAfter(deadline: .now() + 15.0) { [weak self] in
            // Check if the peripheral is still not connected
            if let state = self?.connectionStates[cbPeripheral.identifier], !state {
                // Attempt timed out
                self?.handleConnectionTimeout(for: cbPeripheral)
            }
        }
    }
    
    internal func disconnect(from peripheral: PeripheralProtocol) {
        guard let cbPeripheral = peripheral as? CBPeripheral else {
            // Handle error or perform fallback
            return
        }
        
        if let index = connectedPeripherals.firstIndex(of: cbPeripheral) {
            connectedPeripherals.remove(at: index)
        }
        centralManager.cancelPeripheralConnection(cbPeripheral)
        // No need to manually update `connectionStates` here since `didDisconnectPeripheral` will be called
    }
    
    // New refresh method
    func refreshBluetoothDevices() {
        // Disconnect from all connected peripherals
        for peripheral in connectedPeripherals {
            centralManager.cancelPeripheralConnection(peripheral)
            connectionStates[peripheral.identifier] = false
        }
        connectedPeripherals.removeAll()
        
        // Stop any ongoing scan
        stopScanning()
        
        // Clear discovered peripherals list to refresh the UI
        discoveredPeripherals.removeAll()
        
        // Start scanning for new devices
        startScanning()
    }
}
 

extension BluetoothManager {
    private func handleConnectionTimeout(for peripheral: CBPeripheral) {
        // Cancel the connection attempt
        centralManager.cancelPeripheralConnection(peripheral)
        // Update the connection state
        connectionStates[peripheral.identifier] = false
        // Notify the user or update the UI regarding the timeout
        showAlertWithMessage("Connection to \(peripheral.name ?? "device") timed out. Please try again.")
    }
    
    private func retrieveConnectedPeripherals(serviceUUIDs: [CBUUID]) {
        // Ensure the Bluetooth is powered on before attempting to retrieve peripherals
        guard isBluetoothEnabled else {
            print("Bluetooth is not enabled.")
            return
        }

        let connectedPeripherals = centralManager.retrieveConnectedPeripherals(withServices: serviceUUIDs)
        
        // Process the retrieved connected peripherals
        for peripheral in connectedPeripherals {
            if !self.connectedPeripherals.contains(where: { $0.identifier == peripheral.identifier }) {
                self.connectedPeripherals.append(peripheral)
                // Optionally, update the connection state for each connected peripheral
                connectionStates[peripheral.identifier] = true
            }
        }
    }
}

extension BluetoothManager {
    internal func notifyUserToEnableBluetooth(_ message: String) {
        showAlertWithMessage("Please enable bluetooth")
    }

    internal func handleBluetoothUnauthorized() {
        showAlertWithMessage("This app is not authorized to use Bluetooth. Please enable Bluetooth access in Settings.")
    }

    internal func handleBluetoothResetting() {
        showAlertWithMessage("Bluetooth state is resetting")
    }

    internal func handleUnknownBluetoothState() {
        showAlertWithMessage("Bluetooth state unknown")
    }

    internal func handleFutureBluetoothStates() {
        showAlertWithMessage("Bluetooth state unknown")
    }

    internal func showAlertWithMessage(_ message: String) {
        alertMessage = message
        isAlertPresented = true
    }
}
