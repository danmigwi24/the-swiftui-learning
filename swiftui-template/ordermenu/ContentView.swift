//
//  ContentView.swift
//  swiftui-template
//
//  Created by Daniel Kimani on 16/01/2024.
//

import SwiftUI

struct ContentView: View {
    let menu = Bundle.main.decode([MenuSection].self, from: "menu.json")
    var body: some View {
        NavigationStack{
            VStack {
                List{
                    ForEach(menu){ section in
                        Section(section.name){
                            ForEach(section.items){ item in
                                NavigationLink(value:item){
                                    ItemRow(item: item)
                                }
                               
                            }
                        }
                    }
                }
            }.navigationDestination(for: MenuItem.self, destination: { item in
                ItemDetail(item: item)
            })
            .navigationTitle("Menu")
            .listStyle(.grouped)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
