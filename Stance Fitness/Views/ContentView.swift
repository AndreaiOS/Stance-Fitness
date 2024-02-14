//
//  ContentView.swift
//  Stance Fitness
//
//  Created by Andrea Murru on 13/02/2024.
//

import SwiftUI

struct ContentView: View {
    var bluetoothManager = BluetoothManager()

    var body: some View {
        BluetoothDevicesView(bluetoothManager: bluetoothManager)
    }
}


#Preview {
    ContentView()
}
