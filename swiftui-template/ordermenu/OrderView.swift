//
//  OrderView.swift
//  swiftui-template
//
//  Created by Daniel Kimani on 01/02/2024.
//

import SwiftUI

struct OrderView: View {
    @EnvironmentObject var order :Order
    var body: some View {
        NavigationStack{
            List{
                Section{
                    ForEach(order.items){item in
                        HStack{
                            Text(item.name)
                            Spacer()
                            Text("\(item.price)")
                        }
                    }
                }
                
                Section{
                    NavigationLink("Place Order"){
                        Text("Checl out")
                    }
                }
            }.navigationTitle("Order")
        }
        
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView().environmentObject(Order())
    }
}
