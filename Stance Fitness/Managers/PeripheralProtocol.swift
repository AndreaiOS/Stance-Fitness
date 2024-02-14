//
//  PeripheralProtocol.swift
//  Stance Fitness
//
//  Created by Andrea Murru on 14/02/2024.
//

import CoreBluetooth

protocol PeripheralProtocol {
    var identifier: UUID { get }
    var name: String? { get }
}

extension CBPeripheral: PeripheralProtocol {
}

