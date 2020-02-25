//
//  MapView.swift
//  applemaps
//
//  Created by Quin’darius Lyles-Woods on 2/12/20.
//  Copyright © 2020 Quin’darius Lyles-Woods. All rights reserved.
//

//import SwiftUI
//import MapKit
//
// class LandmarkAnnotation: NSObject, MKAnnotation {
//    let id: String
//    let title: String?
//    let coordinate: CLLocationCoordinate2D
//
//    init(landmark: Landmark) {
//        self.id = landmark.id
//        self.title = landmark.name
//        self.coordinate = landmark.location
//    }
//}
//
//struct MapView: UIViewRepresentable {
//    var locationManager = CLLocationManager()
//    func setupManager() {
//      locationManager.desiredAccuracy = kCLLocationAccuracyBest
//      locationManager.requestWhenInUseAuthorization()
//      locationManager.requestAlwaysAuthorization()
//    }
//    @Binding var landmarks: [Landmark]
//    @Binding var selectedLandmark: Landmark?
//    
//    func makeUIView(context: Context) -> MKMapView {
//        setupManager()
//        
//        let map = MKMapView(frame: UIScreen.main.bounds)
//        map.delegate = context.coordinator
//        map.showsUserLocation = true
//        map.userTrackingMode = .follow
//        return map
//    }
//    
//    func updateUIView(_ uiView: MKMapView, context: Context) {
//        updateAnnotations(from: uiView)
//    }
//    
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//    
//     class Coordinator: NSObject, MKMapViewDelegate {
//        var control: MapView
//        init(_ control: MapView) {
//            self.control = control
//        }
//        
//        
//        
//        
//        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
//            guard let coordinates = view.annotation?.coordinate else { return }
//            let span = mapView.region.span
//            let region = MKCoordinateRegion(center: coordinates, span: span)
//            mapView.setRegion(region, animated: true)
//        }
//        
//        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//            guard let annotation = annotation as? LandmarkAnnotation else { return nil }
//            let identifier = "Annotation"
//            var annotationView: MKMarkerAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
//            if annotationView == nil {
//                annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
//                annotationView?.canShowCallout = true
//                annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
//            } else {
//                annotationView?.annotation = annotation
//            }
//            return annotationView
//        }
//    }
//    
//     func updateAnnotations(from mapView: MKMapView) {
//        mapView.removeAnnotations(mapView.annotations)
//        let newAnnotations = landmarks.map { LandmarkAnnotation(landmark: $0) }
//        mapView.addAnnotations(newAnnotations)
//        if let selectedAnnotation = newAnnotations.filter({ $0.id == selectedLandmark?.id }).first {
//            mapView.selectAnnotation(selectedAnnotation, animated: true)
//        }
//    }
//}
import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    class Coordinator: NSObject, MKMapViewDelegate{
        var parent: MapView
        init(_ parent: MapView){
            self.parent = parent
        }
    }
    
    func makeCoordinator() -> MapView.Coordinator {
        Coordinator(self)
    }
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        return mapView
    }
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
    }
}
struct Landmark: Equatable {
    static func ==(lhs: Landmark, rhs: Landmark) -> Bool {
        lhs.id == rhs.id
    }

    let id = UUID().uuidString
    let name: String
    let location: CLLocationCoordinate2D
}

class LandmarkAnnotation: NSObject, MKAnnotation {
    let id: String
    let title: String?
    let coordinate: CLLocationCoordinate2D

    init(landmark: Landmark) {
        self.id = landmark.id
        self.title = landmark.name
        self.coordinate = landmark.location
    }
}
