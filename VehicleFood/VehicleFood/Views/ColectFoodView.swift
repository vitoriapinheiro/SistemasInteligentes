//
//  ColectFood.swift
//  VehicleFood
//
//  Created by vivi on 15/02/23.
//

import SwiftUI

struct ColectFoodView: View {
    @State var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State var screenWidth = CGFloat(0)
    @State var screenHeight = CGFloat(0)
    
    @State var points = 0
    @State var started = false
    
    @State var dx = CGFloat(0)
    @State var dy = CGFloat(0)
    
    @State var sharkPos = CGPoint(x: UIScreen.screenWidth/4, y: UIScreen.screenHeight/6)
    @State var sharkSize = CGFloat(60)
    
    @State var fishPos = CGPoint(x: UIScreen.screenWidth/2, y: UIScreen.screenHeight/3)
    @State var fishSize = CGFloat(40)
    
    
    var body: some View {
        GeometryReader{ geo in
            ZStack {
                Text("Pontos: " + String(points))
                    .bold()
                    .fontWeight(Font.Weight.heavy)
                    .padding(20)
                    .foregroundColor(.black)
                    .position(CGPoint(x: screenWidth/2, y: 70))
                Image("Fish")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: self.fishSize, height: self.fishSize)
                    .position(self.fishPos)
                Image("Shark")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: self.sharkSize, height: self.sharkSize)
                    .position(self.sharkPos)
                
            }
            .background(
                Image("Ocean")
                    .resizable()
                    .ignoresSafeArea(.all)
                    .aspectRatio(contentMode: .fill)
            )
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
        if(!started){
//            MusicPlayer.shared.startBackgroundMusic(backgroundMusicFileName: "Jaws")
            self.started = true
        }
        self.colisionChecker()
        self.parametersCalculator()
        self.sharkMove()
        
    }
    
    func parametersCalculator(){
        self.dx = self.fishPos.x - self.sharkPos.x
        self.dy = self.fishPos.y - self.sharkPos.y
    }
    
    func sharkMove(){
        withAnimation{
            self.sharkPos.x += dx*0.15
            self.sharkPos.y += dy*0.15
            self.sharkSize += 3
        }
    }
    
    func colisionChecker(){
        if(abs(self.fishPos.x - self.sharkPos.x) < 15 && abs(self.fishPos.y - self.sharkPos.y) < 15){
            HapticManager.instance.impact(style: .heavy)
            withAnimation(){
                self.sharkSize += 1
            }
            self.points += 1
            self.sharkSize = CGFloat(60)
            self.fishPos = CGPoint(x: Double.random(in: 5.0 ... (screenWidth-15)), y: Double.random(in: 5.0 ... (screenHeight-15)))
        }
    }
}
