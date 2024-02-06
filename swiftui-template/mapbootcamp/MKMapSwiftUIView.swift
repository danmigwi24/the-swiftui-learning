//
//  MapWWDC23SwiftView.swift
//  swiftui-template
//
//  Created by Daniel Kimani on 02/02/2024.
//

import SwiftUI
import MapKit
import Combine

struct MKMapSwiftUIView: View {
    @State private var directions:[String] = []
    @State private var showDirections = false
    @State private var search:String = ""
    //
    @ObservedObject var locationManager = LocationManager()
    @State var cancelable : AnyCancellable?
    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(), latitudinalMeters: 500,longitudinalMeters: 500)
    //
    var body: some View {
        VStack{
            //MapViewLesson1()
            MapViewLesson2()
        }
        .sheet(isPresented: $showDirections) {
            VStack{
                Text("Directions")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                Divider().background(.blue)
                List{
                    ForEach(0..<self.directions.count ,id: \.self){index in
                        Text(self.directions[index])
                            .padding()
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    func MapViewLesson1()->some View{
        VStack{
            MapViewLesson1ViewRepresentable(directions: $directions)
            Button(action: {
                showDirections.toggle()
            }, label: {
                Text("Show Direction")
            })
            .disabled(directions.isEmpty)
            .padding()
        }
    }
    //
    @ViewBuilder
    func MapViewLesson2()->some View{
        ZStack(alignment: .top){
            
            //MapViewLesson2ViewRepresentable()
            if locationManager.location != nil {
                Map(coordinateRegion: $region,interactionModes: .all,showsUserLocation: true,userTrackingMode: nil)
            }else{
                Text("")
            }
            //
            TextField("Search..", text: $search) { _ in
                
            }.textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .offset(y: 44)
        }.onAppear{
            setCurrentLocation()
        }
    }
    //   M!9w!@2004
    
    private func getNearByLandMarks(){
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = search
        
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            if let response = response{
                let mapItem = response.mapItems
                print(mapItem)
            }
        }
    }
    //
    private func setCurrentLocation(){
        cancelable = locationManager.$location.sink{location in
            region = MKCoordinateRegion(center: location?.coordinate ?? CLLocationCoordinate2D(), latitudinalMeters: 500, longitudinalMeters: 500)
        }
    }
    
}

struct MKMapSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        MKMapSwiftUIView()
    }
}

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
        let newYorkCityCoordinate =  CLLocationCoordinate2D(latitude: 40.71, longitude: -74)
        //
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


struct MapViewLesson2ViewRepresentable:UIViewRepresentable{
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
        var control:MapViewLesson2ViewRepresentable
        
        init(_ control: MapViewLesson2ViewRepresentable) {
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
