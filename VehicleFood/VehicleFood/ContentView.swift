//
//  ContentView.swift
//  VehicleFood
//
//  Created by vivi on 06/02/23.
//

import SwiftUI

struct ContentView: View {
    @State var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State var screenWidth = CGFloat(0)
    @State var screenHeight = CGFloat(0)
    
    @State var points = 0
    
    @State var dx = CGFloat(0)
    @State var dy = CGFloat(0)
    
    @State var rectPos = CGPoint(x: UIScreen.screenWidth/4, y: UIScreen.screenHeight/4)
    @State var rectSize = CGFloat(20)
    
    @State var circPos = CGPoint(x: UIScreen.screenWidth/2, y: UIScreen.screenHeight/3)
    @State var circSize = CGFloat(15)
    
    
    var body: some View {
        GeometryReader{ geo in
           ZStack {
                Text(String(points))
                    .bold()
                    .padding(20)
                    .foregroundColor(.purple)
                Circle()
                    .frame(width: circSize)
                    .position(circPos)
                Rectangle()
                    .frame(width: rectSize, height: rectSize)
                    .position(rectPos)
                    .foregroundColor(.pink)
               Text(String(points))
                   .bold()
                   .padding(20)
                   .foregroundColor(.purple)
                   .position(CGPoint(x: screenWidth/2, y: 30))

            }
            .frame(width: geo.size.width, height: geo.size.height)
            .onReceive(self.timer){ _ in
                self.screenWidth = geo.size.width
                self.screenHeight = geo.size.height
                gameControl()
            }
    }
        .edgesIgnoringSafeArea(.all)
}
    func gameControl(){
        self.colisionChecker()
        self.parametersCalculator()
        self.rectMove()
        
        }
    
    func parametersCalculator(){
        self.dx = self.circPos.x - self.rectPos.x
        self.dy = self.circPos.y - self.rectPos.y
    }
    func rectMove(){
            withAnimation{
                self.rectPos.x += dx*0.1
                self.rectPos.y += dy*0.1
            }
        }
    func colisionChecker(){
        if(abs(self.circPos.x - self.rectPos.x) < 10 && abs(self.circPos.y - self.rectPos.y) < 10){
            withAnimation(){
                self.rectSize += 5
            }
            self.points += 1
            self.rectPos = CGPoint(x: UIScreen.screenWidth/4, y: UIScreen.screenHeight/4)
            self.rectSize = CGFloat(20)
            self.circPos = CGPoint(x: Double.random(in: 5.0 ... (screenWidth-15)), y: Double.random(in: 5.0 ... (screenHeight-15)))
        }
    }
    }

extension UIScreen{
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenSize = UIScreen.main.bounds.size
}
