//
//  BluetoothDeviceListView.swift
//  Stance Fitness
//
//  Created by Andrea Murru on 13/02/2024.
//

import SwiftUI

struct BluetoothDeviceListView: View {
    @ObservedObject var bluetoothManager: BluetoothManager

    var body: some View {
        List(bluetoothManager.discoveredPeripherals, id: \.identifier) { peripheral in
            HStack {
                Text(peripheral.name ?? peripheral.identifier.uuidString)
                Spacer()
                if bluetoothManager.connectionStates[peripheral.identifier] == true {
                    Circle()
                        .fill(Color.green)
                        .frame(width: 10, height: 10)
                }
                Button(action: {
                    if bluetoothManager.connectionStates[peripheral.identifier] == true {
                        bluetoothManager.disconnect(from: peripheral)
                    } else {
                        bluetoothManager.connect(to: peripheral)
                    }
                }) {
                    Text(bluetoothManager.connectionStates[peripheral.identifier] == true ? "Disconnect" : "Connect")
                        .foregroundColor(.blue)
                }
            }
        }
    }
}
