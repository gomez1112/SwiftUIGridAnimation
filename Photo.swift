//
//  Photo.swift
//  SwiftUIGridViewAnimation
//
//  Created by Simon Ng on 25/9/2020.
//

import Foundation

struct Photo: Identifiable {
    var id = UUID()
    var name: String
}

let samplePhotos = (1...10).map { Photo(name: "coffee-\($0)") }
