//
//  MockCentralManager.swift
//  Stance FitnessTests
//
//  Created by Andrea Murru on 14/02/2024.
//

import CoreBluetooth

// Mock Central Manager
class MockCentralManager: CBCentralManager {
    var scanForPeripheralsCalled = false
    var stopScanCalled = false
    var connectPeripheral: CBPeripheral?
    var cancelPeripheralConnectionPeripheral: CBPeripheral?
    var connectCalled = false
    var disconnectCalled = false
    var connectedPeripherals = Set<CBPeripheral>()
    
    override func scanForPeripherals(withServices serviceUUIDs: [CBUUID]?, options: [String: Any]?) {
        scanForPeripheralsCalled = true
    }
    
    override func stopScan() {
        stopScanCalled = true
    }
    
    override func connect(_ peripheral: CBPeripheral, options: [String : Any]? = nil) {
        connectCalled = true
        connectedPeripherals.insert(peripheral)
    }
    
    override func cancelPeripheralConnection(_ peripheral: CBPeripheral) {
        disconnectCalled = true
        connectedPeripherals.remove(peripheral)
    }
}

// Mock Peripheral
class MockPeripheral: PeripheralProtocol {
    var identifier: UUID
    var name: String?
    
    init(identifier: UUID, name: String? = nil) {
        self.identifier = identifier
        self.name = name
    }
}

extension MockPeripheral: Equatable {
    static func == (lhs: MockPeripheral, rhs: MockPeripheral) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}

extension MockPeripheral: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}

