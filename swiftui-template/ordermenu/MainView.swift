//
//  MainView.swift
//  swiftui-template
//
//  Created by Daniel Kimani on 01/02/2024.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView{
            ContentView()
                .tabItem{
                    Label("Menu", systemImage: "list.dash")
                }
            OrderView()
                .tabItem{
                    Label("Order", systemImage: "square.and.pencil")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environmentObject(Order())
    }
}
