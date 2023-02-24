//
//  Menu.swift
//  VehicleFood
//
//  Created by vivi on 20/02/23.
//

import SwiftUI

struct MenuView: View {
    
    
    var body: some View {
        GeometryReader{ geo in
            ZStack{
                VStack{
                    Spacer(minLength: 20)
                    Text("Come peixe")
                        .font(.system(size: 48))
                        .bold()
                        .foregroundColor(Color.white)
                    Spacer(minLength: 80)
                    AppButton(
                        title: "Coletando comida",
                        nextView: {AnyView(ColectFoodView())},
                        height: 56,
                        width: 272,
                        size: 20)
                    AppButton(
                        title: "Procurando comida",
                        nextView: {AnyView(SearchFoodView())},
                        height: 56,
                        width: 272,
                        size: 20)
                    AppButton(
                        title: "Evolução do ecossistema",
                        nextView: {AnyView(EcosystemView())},
                        height: 56,
                        width: 272,
                        size: 20)
                    Spacer(minLength: 20)
                }
            }
            .frame(width: geo.size.width, height: geo.size.height)
            .edgesIgnoringSafeArea(.all)
            .background(
                Image("Ocean")
                    .resizable()
                    .ignoresSafeArea(.all)
                    .aspectRatio(contentMode: .fill)
            )
        }
        
    }
}
