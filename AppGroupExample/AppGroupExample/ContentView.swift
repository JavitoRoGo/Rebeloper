//
//  ContentView.swift
//  AppGroupExample
//
//  Created by Javier Rodríguez Gómez on 4/2/23.
//

import SwiftUI

struct ContentView: View {
    let sharedUserDefaults = UserDefaults(suiteName: SharedUserDefaults.suiteName)
    
    let username = "Alex"
    @State var text = ""
    
    var body: some View {
        VStack(spacing: 50) {
            Button("Save to UserDefaults") {
//                UserDefaults.standard.set(username, forKey: SharedUserDefaults.Keys.username)
                sharedUserDefaults?.set(username, forKey: SharedUserDefaults.Keys.username)
            }
            Button("Show saved UserDefaults") {
//                let saved = UserDefaults.standard.string(forKey: SharedUserDefaults.Keys.username) ?? "nada"
                guard let saved = sharedUserDefaults?.string(forKey: SharedUserDefaults.Keys.username) else { return }
                text = saved
                print(saved)
            }
            Text(text)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
