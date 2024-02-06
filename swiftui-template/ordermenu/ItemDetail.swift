//
//  ItemDetails.swift
//  swiftui-template
//
//  Created by Daniel Kimani on 01/02/2024.
//

import SwiftUI

struct ItemDetail: View {
    let item:MenuItem
    
    @EnvironmentObject var order : Order
    
    var body: some View {
        VStack{
            ZStack(alignment: .bottomTrailing){
                Image(item.mainImage)
                    .resizable()
                    .scaledToFit()
                
                Text("Photo by: \(item.photoCredit)")
                    .padding(4)
                    .background(.black)
                    .font(.caption)
                    .foregroundColor(.white)
                    .offset(x: -5,y: -5)
            }
            Text(item.description)
                .padding()
            
            Button(action: {
                order.add(item: item)
            }, label: {
                Text("Order This")
            }).buttonStyle(.borderedProminent)
            Spacer()
        }.navigationTitle(item.name)
    }
}

struct ItemDetails_Previews: PreviewProvider {
    static var previews: some View {
        ItemDetail(item: MenuItem.example).environmentObject(Order())
    }
}
