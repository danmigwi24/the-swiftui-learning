//
//  MapViewViewRepresentables.swift
//  swiftui-template
//
//  Created by Daniel Kimani on 15/02/2024.
//

import SwiftUI
import MapKit
import CoreLocation

/**
 
 */

struct MapViewLesson1ViewRepresentable:UIViewRepresentable{
    typealias UIViewType = MKMapView
    
    
    @Binding var directions:[String]
    
    func makeUIView(context: Context) -> MKMapView {
        let mapview = MKMapView()
        //
        mapview.delegate = context.coordinator
        //
        //let newYorkCityCoordinate =     CLLocationCoordinate2D(latitude: -1.282406660482146, longitude: 36.815689146920086)
        let newYorkCityCoordinate = CLLocationCoordinate2D(latitude: 40.71, longitude: -74)
        //
      //  let bostonCoordinate =   CLLocationCoordinate2D(latitude: -1.310123, longitude: 36.871395)
        let bostonCoordinate =  CLLocationCoordinate2D(latitude: 42.36, longitude: -71.05)
        //
        let region = MKCoordinateRegion(center:newYorkCityCoordinate, span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        //
        let p1 = MKPlacemark(coordinate: newYorkCityCoordinate)
        let p2 = MKPlacemark(coordinate: bostonCoordinate)
        //
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: p1)
        request.destination = MKMapItem(placemark: p2)
        request.transportType = .automobile
        //
        let directions = MKDirections(request: request)
        directions.calculate { response, error in
            guard let route = response?.routes.first else {return}
            mapview.addAnnotations([p1,p2])
            mapview.addOverlay(route.polyline)
            mapview.setVisibleMapRect(
                route.polyline.boundingMapRect,
                edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20),
                animated: true
            )
            self.directions = route.steps.map{ $0.instructions }.filter{ !$0.isEmpty }
        }
        
        mapview.setRegion(region, animated: true)
        return mapview
    }
    //
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
    }
    //
    func makeCoordinator() -> MapViewCoordinator {
        return MapViewCoordinator()
    }
    
    //
    class MapViewCoordinator:NSObject,MKMapViewDelegate{
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = .blue
            renderer.lineWidth = 5
            
            return renderer
            
        }
    }
}

struct MapViewLesson1ViewRepresentableDrawMKPolyline: UIViewRepresentable {
    typealias UIViewType = MKMapView
    
    var lineCoordinatesTest: [CLLocationCoordinate2D]
    
    func makeUIView(context: Context) -> MKMapView {
        let mapview = MKMapView()
        mapview.delegate = context.coordinator
        
        let region = MKCoordinateRegion(center: lineCoordinatesTest.first ?? CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        
        let polyline = MKPolyline(coordinates: lineCoordinatesTest, count: lineCoordinatesTest.count)
        mapview.addOverlay(polyline)
        mapview.setVisibleMapRect(
            polyline.boundingMapRect,
            edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20),
            animated: true
        )
        
        mapview.setRegion(region, animated: true)
        return mapview
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
    }
    
    func makeCoordinator() -> MapViewCoordinator {
        return MapViewCoordinator()
    }
    
    class MapViewCoordinator: NSObject, MKMapViewDelegate {
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if let polyline = overlay as? MKPolyline {
                let renderer = MKPolylineRenderer(polyline: polyline)
                renderer.strokeColor = .blue
                renderer.lineWidth = 5
                return renderer
            }
            return MKOverlayRenderer(overlay: overlay)
        }
    }
}

struct MapViewLesson3ViewRepresentable:UIViewRepresentable{
    typealias UIViewType = MKMapView
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.showsUserLocation = true
        mapView.delegate = context.coordinator
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        //
    }
    
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    
    class Coordinator : NSObject,MKMapViewDelegate {
        var control:MapViewLesson3ViewRepresentable
        
        init(_ control: MapViewLesson3ViewRepresentable) {
            self.control = control
        }
        
    }
}


/**
 
 */
extension CLLocationCoordinate2D{
    static var userLoction:CLLocationCoordinate2D{
        return CLLocationCoordinate2D(latitude: 25.7602, longitude: -80.1959)
    }
}
/**
 
 */

extension MKCoordinateRegion{
    static var userRegion: MKCoordinateRegion{
        return .init(center: .userLoction, latitudinalMeters: 10000, longitudinalMeters: 10000)
    }
}

final class LocationAnnotation:NSObject,MKAnnotation{
    var coordinate: CLLocationCoordinate2D
    
    init(coordinate : CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
