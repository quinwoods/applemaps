//
//  ContentView.swift
//  applemaps
//
//  Created by Quin’darius Lyles-Woods on 2/12/20.
//  Copyright © 2020 Quin’darius Lyles-Woods. All rights reserved.
//

import SwiftUI

/// This allows the view to be seen on the phone
struct ContentView: View {
    var body: some View{
        MapView()
            .edgesIgnoringSafeArea(.all)
    }
}

