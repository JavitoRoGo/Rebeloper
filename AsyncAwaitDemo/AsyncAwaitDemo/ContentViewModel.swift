//
//  ContentViewModel.swift
//  AsyncAwaitDemo
//
//  Created by Javier Rodríguez Gómez on 27/5/23.
//

import Combine
import SwiftUI

@MainActor
class ContentViewModel: ObservableObject {
    @Published var persons: [Person] = []
    @Published var isFetching: Bool = false
    
    // Llamada de red con URLSession y completionHandler sin async/await
    func closuresFetch(completion: @escaping (Error?) -> ()) {
        let url = URL(string: Setup.url)!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error {
                completion(error)
                return
            }
            guard let response else {
                completion(APIError.noResponse)
                return
            }
            if (response as? HTTPURLResponse)?.statusCode != 200 {
                completion(APIError.no200)
                return
            }
            guard let data else {
                completion(APIError.noData)
                return
            }
            
            DispatchQueue.main.async {
                do {
                    let decoded = try JSONDecoder().decode(Population.self, from: data)
                    self.persons = decoded.persons
                    completion(nil)
                } catch {
                    print("error: ", error)
                    completion(error)
                }
            }
        }
        
        task.resume()
    }
    
    // Llamada de red con async/await, mucho más sencillo
    func asyncAwaitFetch() async throws {
        let url = URL(string: Setup.url)!
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse else { throw APIError.noResponse }
        guard response.statusCode == 200 else { throw APIError.no200 }
        
        guard let decoded = try? JSONDecoder().decode(Population.self, from: data) else { throw APIError.noData}
        self.persons = decoded.persons
    }
}
