//
//  Person.swift
//  AsyncAwaitDemo
//
//  Created by Javier Rodríguez Gómez on 27/5/23.
//

import Foundation

struct Person: Codable {
    let name: String
    let role: String
    let thumb: String
}

struct Population: Codable {
    let persons: [Person]
}
