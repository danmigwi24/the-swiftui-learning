//
//  SwiftUIViewBuilderScreen.swift
//  swiftui-template
//
//  Created by Daniel Kimani on 01/02/2024.
//

import SwiftUI

struct SwiftUIViewBuilderScreen: View {
    var body: some View {
        VStack{
            HeaderViewGeneric(
                title: "Title 1",
                content: {
                VStack(alignment: .leading){
                    Text("Subtitle 1")
                    Text("Subtitle 2")
                    Text("Subtitle 3")
                }
                }).padding()
            Spacer()
        }//.frame(maxWidth: .infinity)
    }
}


struct HeaderViewGeneric<Content:View>: View {
    let title:String
    let content : Content
    init(title: String, @ViewBuilder content:()-> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading){
            Text(title)
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            content
            
            RoundedRectangle(cornerRadius: 5)
                .frame(height: 2)
                
        }.frame(maxWidth: .infinity,alignment: .leading)
    }
}


struct SwiftUIViewBuilderScreen_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIViewBuilderScreen()
    }
}
