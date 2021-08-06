//
//  Annotation.swift
//  SwiftUIAssignment
//
//  Created by Arpit Mendpara on 2021-08-03.
//

import SwiftUI

//MARK:- Object mapper for markers API
struct MarkerJSONData: Decodable {
    let markers: [Markers]
}

struct Markers: Decodable, Identifiable {
    var id: UUID? = UUID()
    let lat: Double
    let lon: Double
    let name: String
    let description: String?
    let color: String
}

//MARK:- Object mapper for Polyline API
struct LineJSONData: Decodable {
    let polyline: [[Double]]
}
