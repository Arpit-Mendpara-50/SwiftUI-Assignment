//
//  ContentView.swift
//  SwiftUIAssignment
//
//  Created by Arpit Mendpara on 2021-08-03.
//

import SwiftUI

struct ContentView: View {
    //MARK:- Variables
    @EnvironmentObject var appState: ApplicationState
    @State var isViewActive: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: MapView(), isActive: $isViewActive) {
                    Text("Show Map View")
                        .padding()
                        .background(Color.accentColor)
                        .foregroundColor(Color.init("ForegroundColor"))
                        .cornerRadius(5.0)
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

