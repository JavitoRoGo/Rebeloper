//
//  ContentView.swift
//  AsyncAwaitDemo
//
//  Created by Javier Rodríguez Gómez on 27/5/23.
//

import SwiftUI

@MainActor //esto es lo mismo que DispatchQueue.main, para actualizar la interfaz
//desde el hilo principal y que no salga el aviso violeta que dice que no podemos actualizar
//desde el background
struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    
    var body: some View {
        VStack {
            if viewModel.isFetching {
                ProgressView()
            } else {
                if viewModel.persons.count == 0 {
                    Text("Tap on Fetch to get population")
                        .foregroundColor(.gray)
                        .font(.caption)
                } else {
                    ScrollView {
                        ForEach(viewModel.persons, id:\.name) { person in
                            ZStack {
                                AsyncImage(url: URL(string: person.thumb)) { image in
                                    image.resizable()
                                        .scaledToFill()
                                        .frame(height: 200)
                                        .clipped()
                                } placeholder: {
                                    ZStack {
                                        Color.mint
                                        ProgressView()
                                    }
                                }
                                .frame(height: 200)
                                
                                VStack {
                                    Spacer()
                                    HStack {
                                        Text("\(person.name) - \(person.role)")
                                            .bold()
                                            .foregroundColor(.white)
                                            .background(
                                                Color.mint
                                                    .padding(.horizontal, -12)
                                            )
                                        Spacer()
                                    }
                                }
                                .padding(12)
                            }
                            .cornerRadius(15)
                            .shadow(color: .gray, radius: 5, x: 2, y: 2)
                            .padding(12)
                        }
                    }
                }
            }
        }
        .padding(.horizontal)
        .navigationTitle("Async/Await")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
//                    closuresFetch()
                    Task { await asyncAwaitFetch() }
                } label: {
                    Text("Fetch")
                }
            }
        }
        .task {
            await asyncAwaitFetch()
        }
    }
    
    func closuresFetch() {
        viewModel.isFetching = true
        viewModel.closuresFetch { error in
            viewModel.isFetching = false
            if let error {
                print(error.localizedDescription)
                return
            }
        }
    }
    
    func asyncAwaitFetch() async {
        viewModel.isFetching = true
        do {
            try await viewModel.asyncAwaitFetch()
            viewModel.isFetching = false
        } catch {
            print(error.localizedDescription)
            viewModel.isFetching = false
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
