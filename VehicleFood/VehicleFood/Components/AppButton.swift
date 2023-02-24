//
//  AppButton.swift
//  VehicleFood
//
//  Created by vivi on 19/02/23.
//

import Foundation
import SwiftUI

struct AppButton: View {
    let title: String
    let nextView: () -> AnyView
    let height: CGFloat
    let width: CGFloat
    let size: CGFloat
    
    var body: some View {
        NavigationLink(
            destination: {
            nextView()
        }, label: {
            Text(title)
                .font(.system(size: size))
                .bold()
                .foregroundColor(Color.white)
                .frame(width: width, height: height)
                .background(Color.blue)
                .cornerRadius(16)
        }
        )
    }
}
