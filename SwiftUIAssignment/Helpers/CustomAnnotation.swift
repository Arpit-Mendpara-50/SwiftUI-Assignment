//
//  CustomAnnotation.swift
//  SwiftUIAssignment
//
//  Created by Arpit Mendpara on 2021-08-06.
//

import SwiftUI

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
