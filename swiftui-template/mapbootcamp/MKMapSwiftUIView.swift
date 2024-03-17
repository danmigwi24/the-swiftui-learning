//
//  MapWWDC23SwiftView.swift
//  swiftui-template
//
//  Created by Daniel Kimani on 02/02/2024.
//

import SwiftUI
import UIKit
import MapKit
import GLKit
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
            /*
            if let mapPic = mapImage {
                Image(uiImage: mapPic)
                    .resizable()
                    .frame(maxWidth: UIScreen.main.bounds.width,maxHeight: UIScreen.main.bounds.height)
                    .scaledToFit()
                    
            }else{
                Text("Image is empty")
            }
            */
            MapViewLesson1()
            //MapViewLesson2()
        }
        .onAppear{
            //displayMkMapSnapShot()
           //displayMkMapSnapShotFirst()
            displayMkMapSnapShotSecond()
            //takeSnapShot()
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
    
    //
    @ViewBuilder
    func MapViewLesson1()->some View{
        VStack{
            MapViewLesson1ViewRepresentable(directions: $directions)
            //MapViewLesson1ViewRepresentableDrawMKPolyline(lineCoordinatesTest: lineCoordinatesTest)
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
            
            //MapViewLesson3ViewRepresentable()
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
    /**
     MAP SNAPSHOT
     */
    
    @State private var mapImage: UIImage?
    
    
    private let lineCoordinates: [LocationAnnotation] = [
        LocationAnnotation(coordinate: CLLocationCoordinate2D(latitude: -1.282406660482146, longitude: 36.815689146920086)),
        LocationAnnotation(coordinate: CLLocationCoordinate2D(latitude: -1.283849, longitude: 36.818916)),
        LocationAnnotation(coordinate: CLLocationCoordinate2D(latitude: -1.285182, longitude: 36.822621)),
        LocationAnnotation(coordinate: CLLocationCoordinate2D(latitude: -1.288291, longitude: 36.828562)),
        LocationAnnotation(coordinate: CLLocationCoordinate2D(latitude: -1.289907, longitude: 36.832105)),
        LocationAnnotation(coordinate: CLLocationCoordinate2D(latitude: -1.291325, longitude: 36.835590)),
        LocationAnnotation(coordinate: CLLocationCoordinate2D(latitude: -1.292909, longitude: 36.838598)),
        LocationAnnotation(coordinate: CLLocationCoordinate2D(latitude: -1.295385, longitude: 36.843193)),
        LocationAnnotation(coordinate: CLLocationCoordinate2D(latitude: -1.297748, longitude: 36.847289)),
        LocationAnnotation(coordinate: CLLocationCoordinate2D(latitude: -1.300384, longitude: 36.852077)),
        LocationAnnotation(coordinate: CLLocationCoordinate2D(latitude: -1.302739, longitude: 36.856173)),
        LocationAnnotation(coordinate: CLLocationCoordinate2D(latitude: -1.305261, longitude: 36.861426)),
        LocationAnnotation(coordinate: CLLocationCoordinate2D(latitude: -1.307685, longitude: 36.866409)),
        LocationAnnotation(coordinate: CLLocationCoordinate2D(latitude: -1.310123, longitude: 36.871395))
    ]

    
    
    var lineCoordinatesTest: [CLLocationCoordinate2D] = [
        CLLocationCoordinate2D(latitude: -1.282406660482146, longitude: 36.815689146920086),
        CLLocationCoordinate2D(latitude: -1.283849, longitude: 36.818916),
        CLLocationCoordinate2D(latitude: -1.285182, longitude: 36.822621),
        CLLocationCoordinate2D(latitude: -1.288291, longitude: 36.828562),
        CLLocationCoordinate2D(latitude: -1.289907, longitude: 36.832105),
        CLLocationCoordinate2D(latitude: -1.291325, longitude: 36.835590),
        CLLocationCoordinate2D(latitude: -1.292909, longitude: 36.838598),
        CLLocationCoordinate2D(latitude: -1.295385, longitude: 36.843193),
        CLLocationCoordinate2D(latitude: -1.297748, longitude: 36.847289),
        CLLocationCoordinate2D(latitude: -1.300384, longitude: 36.852077),
        CLLocationCoordinate2D(latitude: -1.302739, longitude: 36.856173),
        CLLocationCoordinate2D(latitude: -1.305261, longitude: 36.861426),
        CLLocationCoordinate2D(latitude: -1.307685, longitude: 36.866409),
        CLLocationCoordinate2D(latitude: -1.310123, longitude: 36.871395)
    ]

    
    
    private func displayMkMapSnapShotFirst(){
        let options : MKMapSnapshotter.Options =  MKMapSnapshotter.Options()
        let region = MKCoordinateRegion(
            center: lineCoordinates.first?.coordinate ?? CLLocationCoordinate2D(),
            span: MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15)
        )
        
        options.region = region
        //options.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40.71, longitude: -74.00), span: MKCoordinateSpan())
        
        options.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        options.scale = UIScreen.main.scale
        options.mapType = .standard
        
        
        
        
        let snapshot = MKMapSnapshotter(options: options)
        snapshot.start {(snapshot, error) in
            //guard let self = self else {return}
            guard error == nil ,let snapshot = snapshot else {return}
            
            UIGraphicsBeginImageContextWithOptions(snapshot.image.size, true, snapshot.image.scale)
            snapshot.image.draw(at: .zero)
            
            //for coordinate in self.lineCoordinatesTest {
            for (index, annotation) in lineCoordinates.enumerated() {
                let point = snapshot.point(for: annotation.coordinate)
                
                if index == 0 {
                    
                    let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "ReuseId")
                    annotationView.drawHierarchy(
                        in: CGRect(x: point.x, y: point.y, width: annotationView.bounds.size.width, height: annotationView.bounds.size.height),
                        afterScreenUpdates: true
                    )
                } else if index == lineCoordinates.count - 1 {
                    
                    let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "ReuseId")
                    annotationView.drawHierarchy(
                        in: CGRect(x: point.x, y: point.y, width: annotationView.bounds.size.width, height: annotationView.bounds.size.height),
                        afterScreenUpdates: true
                    )
                    
                }
                
                
                let drawnImage = UIGraphicsGetImageFromCurrentImageContext()
                self.mapImage = drawnImage
            }
        }
    }
    
    private func displayMkMapSnapShotSecond() {
        let options: MKMapSnapshotter.Options =  MKMapSnapshotter.Options()
        let polyLine = MKPolyline(coordinates: lineCoordinatesTest, count: lineCoordinatesTest.count)
        let span = calculateSpan(for: lineCoordinatesTest.count)
        //let region = MKCoordinateRegion(polyLine.boundingMapRect)
        
       // let region = MKCoordinateRegion(boundingMapRect(for: lineCoordinatesTest))
        
        //let region = MKCoordinateRegion(center: lineCoordinates.first?.coordinate ?? CLLocationCoordinate2D(),span:span)
        
        //let region = MKCoordinateRegion(center: lineCoordinatesTest.first ?? CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 0.22, longitudeDelta: 0.14))
        
//        let region = MKCoordinateRegion(
//            center: lineCoordinatesTest.first ?? CLLocationCoordinate2D(),
//            latitudinalMeters: 8000,
//            longitudinalMeters: 8000
//        )
        
        let centerCoord = getCenterCoord(LocationPoints: lineCoordinatesTest)
        
       let region = MKCoordinateRegion(center: centerCoord, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.05))

        
        options.region = region
        options.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        options.scale = UIScreen.main.scale
        options.mapType = .standard
        
        let snapshot = MKMapSnapshotter(options: options)
        snapshot.start { (snapshot, error) in
            guard error == nil, let snapshot = snapshot else { return }
            
            UIGraphicsBeginImageContextWithOptions(snapshot.image.size, true, snapshot.image.scale)
            snapshot.image.draw(at: .zero)
            
            let context = UIGraphicsGetCurrentContext()
            
            // Drawing polylines
            if let context = context {
                context.setStrokeColor(UIColor.red.cgColor)
                context.setLineWidth(5.0)
                context.setLineCap(.round)
                context.setLineJoin(.round)
                
                var points: [CGPoint] = []
                for coordinate in self.lineCoordinates {
                    let point = snapshot.point(for: coordinate.coordinate)
                    points.append(point)
                }
                
                context.addLines(between: points)
                context.strokePath()
            }
            
            // Drawing annotations
            for (index, annotation) in self.lineCoordinates.enumerated() {
                let point = snapshot.point(for: annotation.coordinate)
                
                if index == 0 || index == self.lineCoordinates.count - 1 {
//                    let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "ReuseId")
//                    annotationView.drawHierarchy(
//                        in: CGRect(x: point.x, y: point.y, width: annotationView.bounds.size.width, height: annotationView.bounds.size.height),
//                        afterScreenUpdates: true
//                    )
                }
            }
            
            let drawnImage = UIGraphicsGetImageFromCurrentImageContext()
            self.mapImage = drawnImage
            
            UIGraphicsEndImageContext()
        }
    }

    
    
    private func displayMkMapSnapShot(){
        let options : MKMapSnapshotter.Options =  MKMapSnapshotter.Options()
        let region = MKCoordinateRegion(
            center: lineCoordinates.first?.coordinate ?? CLLocationCoordinate2D(),
            span: MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15)
        )
        
        options.region = region
        
        options.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        options.scale = UIScreen.main.scale
        options.mapType = .standard
        
        let context = UIGraphicsGetCurrentContext()
        // Set the line color and width
        let lineColor = UIColor.systemBlue//UIColor.blue
        let lineWidth: CGFloat = 3.0
        context?.setStrokeColor(lineColor.cgColor)
        context?.setLineWidth(lineWidth)
        
        
        
        let snapshot = MKMapSnapshotter(options: options)
        snapshot.start {(snapshot, error) in
            guard error == nil ,let snapshot = snapshot else {return}
            
            UIGraphicsBeginImageContextWithOptions(snapshot.image.size, true, snapshot.image.scale)
            snapshot.image.draw(at: .zero)
            
            for (index, annotation) in lineCoordinates.enumerated() {
                let point = snapshot.point(for: annotation.coordinate)
                
                
                if index == 0 {
                    context?.move(to: point)
                    
                    let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "ReuseId")
                    annotationView.drawHierarchy(
                        in: CGRect(x: point.x, y: point.y, width: annotationView.bounds.size.width, height: annotationView.bounds.size.height),
                        afterScreenUpdates: true
                    )
                    //} else {
                } else if index == lineCoordinates.count - 1 {
                    
                    let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "ReuseId")
                    annotationView.drawHierarchy(
                        in: CGRect(x: point.x, y: point.y, width: annotationView.bounds.size.width, height: annotationView.bounds.size.height),
                        afterScreenUpdates: true
                    )
                    
                }
                context?.addLine(to: point)
                
                
                // Draw the polyline
                context?.strokePath()
                
                let drawnImage = UIGraphicsGetImageFromCurrentImageContext()
                self.mapImage = drawnImage
            }
        }
    }
    
    func takeSnapShot() {
        // Set the region of the map that is rendered. (by polyline)
        let polyLine = MKPolyline(coordinates: lineCoordinatesTest, count: lineCoordinatesTest.count)
        let span = calculateSpan(for: lineCoordinatesTest.count)
        //let region = MKCoordinateRegion(polyLine.boundingMapRect)
        
        //let region = MKCoordinateRegion(boundingMapRect(for: lineCoordinatesTest))
        
        //let region = MKCoordinateRegion(center: lineCoordinates.first?.coordinate ?? CLLocationCoordinate2D(),span:span)
        
        //let region = MKMapRectForCoordinateRegion(region: MKCoordinateRegion(polyLine.boundingMapRect))
        
        let centerCoord = getCenterCoord(LocationPoints: lineCoordinatesTest)
       let region = MKCoordinateRegion(center: centerCoord, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))

        let options = MKMapSnapshotter.Options()
        options.region = region
        // Set the scale of the image. We'll just use the scale of the current device, which is 2x scale on Retina screens.
        options.scale = UIScreen.main.scale
        // Set the size of the image output.
        options.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        // Show buildings and Points of Interest on the snapshot
        options.mapType = .standard
        options.showsBuildings = true
        options.showsPointsOfInterest = true
        

        let snapShotter = MKMapSnapshotter(options: options)
        
        snapShotter.start() { snapshot, error in
            guard let snapshot = snapshot else {
                return
            }
            
            
            // Don't just pass snapshot.image, pass snapshot itself!
            self.mapImage = self.drawLineOnImage(snapshot: snapshot)
        }
    }
    
    
    func MKMapRectForCoordinateRegion(region: MKCoordinateRegion) -> MKMapRect {
        
        let topLeft = CLLocationCoordinate2D(
            latitude: region.center.latitude + (region.span.latitudeDelta / 2),
            longitude: region.center.longitude - (region.span.longitudeDelta / 2)
        )
        
        let bottomRight = CLLocationCoordinate2D(
            latitude: region.center.latitude - (region.span.latitudeDelta / 2),
            longitude: region.center.longitude + (region.span.longitudeDelta / 2)
        )
        
        let a = MKMapPoint(topLeft)
        let b = MKMapPoint(bottomRight)
        
        return MKMapRect(
            origin: MKMapPoint(x: min(a.x, b.x), y: min(a.y, b.y)),
            size: MKMapSize(width: abs(a.x - b.x), height: abs(a.y - b.y))
        )
    }
    
    
    func getCenterCoord(LocationPoints: [CLLocationCoordinate2D]) -> CLLocationCoordinate2D{

        var x:Float = 0.0;
        var y:Float = 0.0;
        var z:Float = 0.0;

        for points in LocationPoints {

         let lat = GLKMathDegreesToRadians(Float(points.latitude));
         let long = GLKMathDegreesToRadians(Float(points.longitude));

            x += cos(lat) * cos(long);
            y += cos(lat) * sin(long);
            z += sin(lat);
        }

        x = x / Float(LocationPoints.count);
        y = y / Float(LocationPoints.count);
        z = z / Float(LocationPoints.count);

        let resultLong = atan2(y, x);
        let resultHyp = sqrt(x * x + y * y);
        let resultLat = atan2(z, resultHyp);



        let result = CLLocationCoordinate2D(latitude: CLLocationDegrees(GLKMathRadiansToDegrees(Float(resultLat))), longitude: CLLocationDegrees(GLKMathRadiansToDegrees(Float(resultLong))));

        return result;

    }
    
    func drawLineOnImage(snapshot: MKMapSnapshotter.Snapshot) -> UIImage? {
        let image = snapshot.image
        
        // for Retina screen
        UIGraphicsBeginImageContextWithOptions(image.size, true, 0)
        
        // draw original image into the context
        image.draw(at: CGPoint.zero)
        
        // get the context for CoreGraphics
        let context = UIGraphicsGetCurrentContext()
        
        // set stroking width and color of the context
        context?.setLineWidth(3.0)
        context?.setStrokeColor(UIColor.systemBlue.cgColor)
        
        // Here is the trick :
        // We use addLine() and move() to draw the line, this should be easy to understand.
        // The diificult part is that they both take CGPoint as parameters, and it would be way too complex for us to calculate by ourselves
        // Thus we use snapshot.point() to save the pain.
        context?.move(to: snapshot.point(for: lineCoordinatesTest[0]))
        
        //
        let startAnnotation = MKPointAnnotation()
        startAnnotation.title = ""
        
        let endAnnotation = MKPointAnnotation()
        endAnnotation.title = ""
        
        for i in 0...lineCoordinatesTest.count-1 {
            context?.addLine(to: snapshot.point(for: lineCoordinatesTest[i]))
            context?.move(to: snapshot.point(for: lineCoordinatesTest[i]))
            //
            let point = snapshot.point(for:lineCoordinatesTest[i])
            startAnnotation.coordinate = lineCoordinatesTest[i]
            endAnnotation.coordinate = lineCoordinatesTest[lineCoordinatesTest.count - 1]
            
//            let annotationView = MKMarkerAnnotationView(annotation: startAnnotation, reuseIdentifier: "ReuseId")
//            annotationView.drawHierarchy(
//                in: CGRect(x: point.x, y: point.y, width: annotationView.bounds.size.width, height: annotationView.bounds.size.height),
//                afterScreenUpdates: true
//            )
            
            let annotationImage = MKMarkerAnnotationView(annotation: startAnnotation, reuseIdentifier: "start").image
            let endAnnotationImage = MKMarkerAnnotationView(annotation: endAnnotation, reuseIdentifier: "end").image
            
            let startPoint = snapshot.point(for: startAnnotation.coordinate)
            let endPoint = snapshot.point(for: endAnnotation.coordinate)
            
        }
        
        // apply the stroke to the context
        context?.strokePath()
        
        // get the image from the graphics context
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // end the graphics context
        UIGraphicsEndImageContext()
        
        return resultImage
    }

    
    func calculateSpan(for coordinatesCount: Int) -> MKCoordinateSpan {
        // Define a base span value
        let baseSpan = 0.8
        
        // Calculate a factor based on the number of coordinates
        let factor = min(10.0 / Double(coordinatesCount), 0.5)
        
        // Adjust the base span using the factor
        let adjustedSpan = baseSpan * factor
        
        return MKCoordinateSpan(latitudeDelta: adjustedSpan, longitudeDelta: adjustedSpan)
    }
    
    
    func boundingMapRect(for coordinates: [CLLocationCoordinate2D]) -> MKMapRect {
//        guard !coordinates.isEmpty else {
//            return nil
//        }
        
        var boundingRect: MKMapRect = MKMapRect.null
        
        for coordinate in coordinates {
            let mapPoint = MKMapPoint(coordinate)
            let mapRect = MKMapRect(origin: mapPoint, size: MKMapSize(width: 0, height: 0))
            boundingRect = boundingRect.union(mapRect)
        }
        
        return boundingRect
    }
    
    
}

struct MKMapSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        MKMapSwiftUIView()
    }
}
