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
//struct MapView: UIViewRepresentable {
//    @Binding var route: MKPolyline?
//    let mapViewDelegate = MapViewDelegate()
//
//    func makeUIView(context: Context) -> MKMapView {
//        MKMapView(frame: .zero)
//    }
//
//    func updateUIView(_ view: MKMapView, context: Context) {
//        view.delegate = mapViewDelegate                          // (1) This should be set in makeUIView, but it is getting reset to `nil`
//        view.translatesAutoresizingMaskIntoConstraints = false   // (2) In the absence of this, we get constraints error on rotation; and again, it seems one should do this in makeUIView, but has to be here
//        addRoute(to: view)
//    }
//}
//
//private extension MapView {
//    func addRoute(to view: MKMapView) {
//        if !view.overlays.isEmpty {
//            view.removeOverlays(view.overlays)
//        }
//
//        guard let route = route else { return }
//        let mapRect = route.boundingMapRect
//        view.setVisibleMapRect(mapRect, edgePadding: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10), animated: true)
//        view.addOverlay(route)
//    }
//}
//
//class MapViewDelegate: NSObject, MKMapViewDelegate {
//    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
//        let renderer = MKPolylineRenderer(overlay: overlay)
//        renderer.fillColor = UIColor.red.withAlphaComponent(0.5)
//        renderer.strokeColor = UIColor.red.withAlphaComponent(0.8)
//        return renderer
//    }
//}
//
//
//
//struct ContentView : View {
//    @State var route: MKPolyline?
//
//    var body: some View {
//        MapView(route: $route)
//            .onAppear {
//                self.findCoffee()
//        }
//    }
//}
//
//private extension ContentView {
//    func findCoffee() {
//        let start = CLLocationCoordinate2D(latitude: 33.9375, longitude: -84.5203)
//        let region = MKCoordinateRegion(center: start, latitudinalMeters: 2000, longitudinalMeters: 2000)
//
//        let request = MKLocalSearch.Request()
//        request.naturalLanguageQuery = "coffee"
//        request.region = region
//
//        MKLocalSearch(request: request).start { response, error in
//            guard let destination = response?.mapItems.first else { return }
//
//            let request = MKDirections.Request()
//            request.source = MKMapItem(placemark: MKPlacemark(coordinate: start))
//            request.destination = destination
//            MKDirections(request: request).calculate { directionsResponse, _ in
//                self.route = directionsResponse?.routes.first?.polyline
//            }
//        }
//    }
//}

class LocationFetcher: NSObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    var lastKnownLocation: CLLocationCoordinate2D?

    override init() {
        super.init()
        manager.delegate = self
    }

    func start() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownLocation = locations.first?.coordinate
    }
}
struct ContentView: View {
    let locationFetcher = LocationFetcher()

    var body: some View {
        VStack {
            Button("Start Tracking Location") {
                self.locationFetcher.start()
            }

            Button("Read Location") {
                if let location = self.locationFetcher.lastKnownLocation {
                    print("Your location is \(location)")
                } else {
                    print("Your location is unknown")
                }
            }
        }
    }
}
