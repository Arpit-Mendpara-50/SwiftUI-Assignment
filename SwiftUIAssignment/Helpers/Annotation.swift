//
//  Annotation.swift
//  SwiftUIAssignment
//
//  Created by Arpit Mendpara on 2021-08-03.
//

import SwiftUI

struct MrkerJSONData: Decodable {
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

struct LineJSONData1: Decodable {
    let polyline: [[Double]]
}

struct Polyline: Decodable {
    let coordintates: [Double]
}
