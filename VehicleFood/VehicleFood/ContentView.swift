//
//  ContentView.swift
//  VehicleFood
//
//  Created by vivi on 06/02/23.
//

import SwiftUI

struct ContentView: View {
    @State var screenWidth = CGFloat(0)
    @State var screenHeight = CGFloat(0)
    
    
    var body: some View {
        NavigationView{
            MenuView()
        }
    }
}


extension UIScreen{
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenSize = UIScreen.main.bounds.size
}
