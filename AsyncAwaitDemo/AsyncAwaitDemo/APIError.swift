//
//  APIError.swift
//  AsyncAwaitDemo
//
//  Created by Javier Rodríguez Gómez on 27/5/23.
//

import Foundation

enum APIError: Error {
    case noResponse
    case no200
    case noData
}
