//
//  ColectFood.swift
//  VehicleFood
//
//  Created by vivi on 15/02/23.
//

import SwiftUI

struct SearchFoodView: View {
    @State var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State var screenWidth = CGFloat(0)
    @State var screenHeight = CGFloat(0)
    
    @State var points = 0
    @State var started = false
    @State var hunting = false
    
    @State var dx = CGFloat(0)
    @State var dy = CGFloat(0)
    @State var wayX = CGFloat(0)
    @State var wayY = CGFloat(0)
    
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
            self.randomWay()
            self.randomWayCalculator()
        }
        if(!hunting){
            self.sharkSearch()
            self.randomWayCalculator()
        } else {
            self.sharkHunt()
            self.parametersCalculator()
        }
        self.colisionChecker()
        
    }
    
    func parametersCalculator(){
        self.dx = self.fishPos.x - self.sharkPos.x
        self.dy = self.fishPos.y - self.sharkPos.y
    }
    
    func randomWay(){
        self.wayX = Double.random(in: 5.0 ... (screenWidth-30))
        self.wayY = Double.random(in: 5.0 ... (screenWidth-30))
    }
    
    func randomWayCalculator(){
        self.dx = self.wayX - self.sharkPos.x
        self.dy = self.wayY - self.sharkPos.y
    }
    
    func sharkSearch(){
        if(self.sharkPos.x < 30 || (self.sharkPos.x > self.screenWidth-30) || self.sharkPos.y < 30 || self.sharkPos.y > self.screenWidth-30){
            self.randomWay()
            self.randomWayCalculator()
        } else if((abs(self.sharkPos.x - self.wayX) < 20 && abs(self.sharkPos.y - self.wayY) < 20)){
            self.randomWay()
            self.randomWayCalculator()
        } else {
            withAnimation{
                self.sharkPos.x += dx*0.15
                self.sharkPos.y += dy*0.15
            }
        }
    }
    
    func sharkHunt(){
        withAnimation{
            self.sharkPos.x += dx*0.15
            self.sharkPos.y += dy*0.15
        }
    }
    
    func huntChecker(){
        if(abs(self.fishPos.x - self.sharkPos.x) < 50 && abs(self.fishPos.y - self.sharkPos.y) < 100){
            HapticManager.instance.impact(style: .light)
            self.hunting = true
        }
    }
    
    func colisionChecker(){
        if(abs(self.fishPos.x - self.sharkPos.x) < 15 && abs(self.fishPos.y - self.sharkPos.y) < 15){
            HapticManager.instance.impact(style: .heavy)
            self.points += 1
            self.hunting = false
            self.sharkSize = CGFloat(60)
            self.fishPos = CGPoint(x: Double.random(in: 5.0 ... (screenWidth-15)), y: Double.random(in: 5.0 ... (screenHeight-15)))
        }
    }
}
