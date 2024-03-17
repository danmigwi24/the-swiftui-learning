//
//  swiftui_templateApp.swift
//  swiftui-template
//
//  Created by Daniel Kimani on 16/01/2024.
//

import SwiftUI

@main
struct SwiftuiTemplateApp: App {
    
    @StateObject var order = Order()
    var body: some Scene {
        WindowGroup {
            //MainView().environmentObject(order)
            //SwiftUIViewBuilderScreen()
            MKMapSwiftUIView()
            //DependecyInjectionBootCamp()
        }
    }
}
