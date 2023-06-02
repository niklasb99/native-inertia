//
//  NativeISwift.swift
//  native-inertia-boilerplate
//
//  Created by Niklas Burger on 25.05.23.
//

import SwiftUI
import MapKit
import CoreLocation

struct MapView: UIViewRepresentable {
    @ObservedObject var locationManager = LocationManager()
    
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        if let location = locationManager.location {
            let coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            let span = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            
            uiView.setRegion(region, animated: true)
            
            // Remove previous annotations
            uiView.removeAnnotations(uiView.annotations)
            
            // Add current location annotation
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            uiView.addAnnotation(annotation)
        }
    }
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    @Published var location: CLLocationCoordinate2D?
    @Published var latitude: Double = 0.0
    @Published var longitude: Double = 0.0
    
    override init() {
        super.init()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        // Uncomment the line below if you want to receive location updates in the background
        // locationManager.allowsBackgroundLocationUpdates = true
        
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last else { return }
        location = newLocation.coordinate
        latitude = newLocation.coordinate.latitude
        longitude = newLocation.coordinate.longitude
    }
}

struct NativeSwiftView: View {
    @ObservedObject var locationManager = LocationManager()
    
    var body: some View {
        VStack {
            MapView()
                .frame(height: 300)
            
            if let location = locationManager.location {
                Text("Latitude: \(location.latitude)")
                Text("Longitude: \(location.longitude)")
            } else {
                Text("Fetching location...")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
