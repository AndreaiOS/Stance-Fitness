//
//  BluetoothDevicesView.swift
//  Stance Fitness
//
//  Created by Andrea Murru on 13/02/2024.
//

import SwiftUI

struct BluetoothDevicesView: View {
    @ObservedObject var bluetoothManager: BluetoothManager

    var body: some View {
        VStack {
            BluetoothStatusView(bluetoothManager: bluetoothManager)

            Button(action: {
                bluetoothManager.refreshBluetoothDevices()
            }) {
                Text("Refresh Devices")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
            }

            BluetoothDeviceListView(bluetoothManager: bluetoothManager)
        }
        .padding()
        .alert(isPresented: $bluetoothManager.isAlertPresented, content: {
            Alert(title: Text(bluetoothManager.alertMessage))
        })
    }
}
