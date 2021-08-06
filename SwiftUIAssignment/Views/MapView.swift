//
//  MapView.swift
//  SwiftUIAssignment
//
//  Created by Arpit Mendpara on 2021-08-04.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    //MARK:- Variables
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 43.64852093920521, longitude: -79.38019037246704), span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
    @State private var markers: [Markers] = []
    
    var body: some View{
        NavigationView{
            //            VStack{
            //                Map(region: mapRegion)
            //                    .edgesIgnoringSafeArea(.all)
            //            }
            Map(coordinateRegion: $mapRegion, interactionModes: .all, showsUserLocation: true, annotationItems: markers) { pin in
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: pin.lat, longitude: pin.lon)) {
                    VStack{
                        PinButtonView(pin: pin)
                    }
                }
            }.edgesIgnoringSafeArea(.all)
            
        }.navigationBarHidden(true)
        .onAppear(perform: {
            loadAnnotationData()
        })
    }
    
    // MARK:- Load Annotation data method
    func loadAnnotationData() {
        guard let url = URL(string: "https://ibimobile-interview.s3.amazonaws.com/test_annotations.json") else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) {data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(MarkerJSONData.self, from: data) {
                    DispatchQueue.main.async {
                        self.markers = decodedResponse.markers
                    }
                    return
                }
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
            
        }.resume()
    }
    
}

/*
struct Map: UIViewRepresentable {
    
    MARK:- Variables
    let region: MKCoordinateRegion
    let mapView = MKMapView()
    @State private var markers: [Markers] = []
    @State private var polylines: [[Double]] = []
    @State private var lineCoordinates: [CLLocationCoordinate2D] = []
    
     MARK:- Load Annotation data method
    func loadAnnotationData() {
        guard let url = URL(string: "https:ibimobile-interview.s3.amazonaws.com/test_annotations.json") else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) {data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(MarkerJSONData.self, from: data) {
                    DispatchQueue.main.async {
                        print(decodedResponse.markers)
                        self.markers = decodedResponse.markers
                        for marker in markers{
                            let annotation = MKPointAnnotation()
                            annotation.coordinate = CLLocationCoordinate2D(latitude: marker.lat, longitude: marker.lon)
                            annotation.title = marker.name
                            mapView.addAnnotation(annotation)
                        }
                    }
                    return
                }
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
            
        }.resume()
    }
     MARK:- Load line data method
    func loadLineData() {
        guard let url = URL(string: "https:ibimobile-interview.s3.amazonaws.com/test_polyline.json") else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) {data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(LineJSONData.self, from: data) {
                    DispatchQueue.main.async {
                        print(decodedResponse.polyline[0][0])
                                                print(decodedResponse.polyline)
                        self.polylines = decodedResponse.polyline
                        for line in polylines{
                            lineCoordinates.append(CLLocationCoordinate2D(latitude: line[0], longitude: line[1]))
                            let polyline = MKPolyline(coordinates: lineCoordinates, count: lineCoordinates.count)
                            mapView.addOverlay(polyline)
                        }
                    }
                    return
                }
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
            
        }.resume()
    }
    
     MARK:- Setup Map
    func makeUIView(context: UIViewRepresentableContext<Map>) -> MKMapView {
        loadAnnotationData()
        loadLineData()
        mapView.delegate = context.coordinator
        mapView.region = region
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
    }
    
     MARK:- MapDelegate Coordinator
    func makeCoordinator() -> Map.Coordinator {
        return Map.Coordinator()
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        @State var tapped = true
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let render = MKPolylineRenderer(overlay: overlay)
            render.strokeColor = .blue
            render.lineWidth = 5
            return render
        }
        
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            print(view.annotation?.title as Any)
        }
        
    }
    
}
*/
