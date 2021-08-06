//
//  ApplicationState.swift
//  SwiftUIAssignment
//
//  Created by Arpit Mendpara on 2021-08-04.
//

import Foundation
import Combine

//MARK:- Store application state for jump to first page
class ApplicationState: ObservableObject{
    @Published var moveToHome: Bool = false
}
