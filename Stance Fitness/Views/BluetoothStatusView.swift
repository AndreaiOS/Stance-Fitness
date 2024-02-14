//
//  BluetoothStatusView.swift
//  Stance Fitness
//
//  Created by Andrea Murru on 13/02/2024.
//

import SwiftUI

struct BluetoothStatusView: View {
    @ObservedObject var bluetoothManager: BluetoothManager

    var body: some View {
        Text(bluetoothManager.isBluetoothEnabled ? "ON" : "OFF")
            .foregroundColor(bluetoothManager.isBluetoothEnabled ? .green : .red)
            .font(.title)
            .padding()
    }
}
