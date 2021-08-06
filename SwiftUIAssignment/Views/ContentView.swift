//
//  ContentView.swift
//  SwiftUIAssignment
//
//  Created by Arpit Mendpara on 2021-08-03.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @EnvironmentObject var appState: ApplicationState
    @State var isViewActive: Bool = false
    var body: some View {
        NavigationView {
                    VStack {
                        NavigationLink(destination: MapView(), isActive: $isViewActive) {
                            Text("Show Map View")
                        }
                        .isDetailLink(false)
                        .navigationTitle("SwiftUI-Assignment")
                    }
                }
        .onReceive(self.appState.$moveToHome) { response in
            if response{
                self.isViewActive = false
                self.appState.moveToHome = false
            }
        }
    }
}

struct MapView: View {
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 43.6559906645898, longitude: -79.3862065672875), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    @State private var markers: [Markers] = []
    
    var body: some View{
        
        NavigationView{
            Map(coordinateRegion: $mapRegion, interactionModes: .all, showsUserLocation: true, annotationItems: markers) { pin in
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: pin.lat, longitude: pin.lon)) {
                    VStack{
                        PinButtonView(pin: pin)
                        
                    }
                }
            }.edgesIgnoringSafeArea(.all)
        }.navigationBarHidden(true)
        .onAppear(perform: loadData)
    }
    
    func loadData() {
        guard let url = URL(string: "https://ibimobile-interview.s3.amazonaws.com/test_annotations.json") else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)

        URLSession.shared.dataTask(with: request) {data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(JSONData.self, from: data) {
                    DispatchQueue.main.async {
                        print(decodedResponse.markers)
                        self.markers = decodedResponse.markers
                    }
                    return
                }
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")

        }.resume()
    }
}

struct PinButtonView: View {
    @State private var showingEditScreen = false
    @State var pin: Markers

    var body: some View {
        NavigationLink(destination: DetailView(pin: pin)) {
            VStack{
                Text(pin.name)
                Image(systemName: "mappin").foregroundColor(Color.init(hex: pin.color)).padding().aspectRatio(contentMode: .fit).font(.largeTitle)
            }
        }
    }
}

struct DetailView: View {
    
    @EnvironmentObject var appState: ApplicationState
    @State var pin: Markers
    @State private var showingAlert = false

    var body: some View{
        NavigationView{
            VStack{
                Text(pin.name)
                Text(pin.description ?? "NA")
                Button("Show Alert") {
                            showingAlert = true
                }
                .alert(isPresented: $showingAlert) {
//                    Alert(title: Text("Important message"), message: Text("Wear sunscreen"), dismissButton: .default(Text("Got it!")))
                    Alert(title: Text("Important message"), message: Text("Tap Yes to go to Home Screen"), primaryButton: .default(Text("Yes"), action: {
                        self.appState.moveToHome = true
                    }), secondaryButton: .cancel())
                }
//                Button(action: {
//                    self.appState.moveToHome = true
//                }) {
//                    Text("Move to Home")
//                }
            }
        }.navigationBarHidden(true)
        
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

