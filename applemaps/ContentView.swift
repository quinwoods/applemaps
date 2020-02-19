//
//  ContentView.swift
//  applemaps
//
//  Created by Quin’darius Lyles-Woods on 2/12/20.
//  Copyright © 2020 Quin’darius Lyles-Woods. All rights reserved.
//

import SwiftUI
import CoreLocation
import MapKit

//struct Landmark: Equatable {
//    static func ==(lhs: Landmark, rhs: Landmark) -> Bool {
//        lhs.id == rhs.id
//    }
//
//    let id = UUID().uuidString
//    let name: String
//    let location: CLLocationCoordinate2D
//}
//
//struct ContentView: View {
//    @State var landmarks: [Landmark] = [
//        Landmark(name: "Westpark Consumer Recycling Center", location: .init(latitude: 29.725570, longitude: -95.468440)),
//        Landmark(name: "Reuse Warehouse", location: .init(latitude: 29.830060, longitude: -95.398800)),
//         Landmark(name: "Ellington Airport/Clear Lake Recycling Center", location: .init(latitude: 29.593130, longitude: -95.169950)),
//          Landmark(name: "Kingwood Recycling Center ", location: .init(latitude: 30.054080, longitude: -95.185520)),
//          Landmark(name: "Environmental Service Center (ESC) - South", location: .init(latitude: 29.755140, longitude: 95.463150)),
//    ]
//
//    @State var selectedLandmark: Landmark? = nil
//
//    var body: some View {
//        ZStack {
//            MapView(landmarks: $landmarks,
//                    selectedLandmark: $selectedLandmark)
//                .edgesIgnoringSafeArea(.vertical)
//            VStack {
//                Spacer()
//                Button(action: {
//                    self.selectNextLandmark()
//                }) {
//                    Text("Next")
//                        .foregroundColor(.black)
//                        .padding()
//                        .background(Color.white)
//                        .cornerRadius(8)
//                        .shadow(radius: 3)
//                        .padding(.bottom)
//                }
//            }
//        }
//    }
//
//    private func selectNextLandmark() {
//        if let selectedLandmark = selectedLandmark, let currentIndex = landmarks.firstIndex(where: { $0 == selectedLandmark }), currentIndex + 1 < landmarks.endIndex {
//            self.selectedLandmark = landmarks[currentIndex + 1]
//        } else {
//            selectedLandmark = landmarks.first
//        }
//    }
//}
//
//#if DEBUG
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
//#endif
//
//
struct MapView: UIViewRepresentable {
  
  var locationManager = CLLocationManager()
  func setupManager() {
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.requestWhenInUseAuthorization()
    locationManager.requestAlwaysAuthorization()
  }
  
  func makeUIView(context: Context) -> MKMapView {
    setupManager()
    let mapView = MKMapView(frame: UIScreen.main.bounds)
    mapView.showsUserLocation = true
    mapView.userTrackingMode = .follow
    return mapView
  }
  
  func updateUIView(_ uiView: MKMapView, context: Context) {
  }
}

struct ContentView: View {
  var body: some View {
    MapView()
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
