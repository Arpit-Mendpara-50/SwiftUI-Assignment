//
//  DetialView.swift
//  SwiftUIAssignment
//
//  Created by Arpit Mendpara on 2021-08-04.
//

import SwiftUI

struct DetailView: View {
    
    //MARK:- Variables
    @EnvironmentObject var appState: ApplicationState
    @State var pin: Markers
    @State private var showingAlert = false
    
    var body: some View{
        NavigationView{
            VStack{
                Text(pin.description ?? "N/A")
                    .padding()
                Button("Show Alert") {
                    showingAlert = true
                }.padding()
                .background(Color.accentColor)
                .foregroundColor(Color.init("ForegroundColor"))
                .cornerRadius(5.0)
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Important message!"), message: Text("Are you sure to go to Home Screen?"), primaryButton:  .default(Text("No")), secondaryButton: .default(Text("Yes"), action: {
                        self.appState.moveToHome = true
                    }))
                }
            }
        }.navigationBarHidden(true)
    }
    
}
