//
//  BluetoothManagerTests.swift
//  Stance FitnessTests
//
//  Created by Andrea Murru on 14/02/2024.
//

import CoreBluetooth
import XCTest
@testable import Stance_Fitness

class BluetoothManagerTests: XCTestCase {
    var bluetoothManager: BluetoothManager!
    var mockCentralManager: MockCentralManager!
    
    override func setUp() {
        super.setUp()
        mockCentralManager = MockCentralManager(delegate: nil, queue: nil)
        bluetoothManager = BluetoothManager()
        // Inject the mock central manager into the BluetoothManager instance
        bluetoothManager.centralManager = mockCentralManager
    }
    
    override func tearDown() {
        bluetoothManager = nil
        mockCentralManager = nil
        super.tearDown()
    }
    
    func testStartScanning_WhenBluetoothEnabled_ShouldStartScanning() {
        bluetoothManager.isBluetoothEnabled = true // Simulate Bluetooth being enabled
        bluetoothManager.startScanning()
        
        XCTAssertTrue(mockCentralManager.scanForPeripheralsCalled, "scanForPeripherals should be called when Bluetooth is enabled")
    }
    
    func testStopScanning_ShouldStopScanning() {
        bluetoothManager.stopScanning()
        
        XCTAssertTrue(mockCentralManager.stopScanCalled, "stopScan should be called")
    }
    
    func testDisconnectFromPeripheral_ShouldAttemptDisconnection() {
        let mockPeripheral = MockPeripheral(identifier: UUID(), name: "Mock Device")

        // Simulate connecting to the peripheral first
        bluetoothManager.connect(to: mockPeripheral)
        bluetoothManager.disconnect(from: mockPeripheral)
        
        XCTAssertFalse(mockCentralManager.connectedPeripherals.contains(where: { $0.identifier == mockPeripheral.identifier }), "Peripheral should be removed from connected peripherals")
    }

}
