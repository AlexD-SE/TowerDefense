//
//  ContentView.swift
//  TD
//
//  Created by Alex Demerjian on 3/21/24.
//

import SwiftUI
import SpriteKit

struct MainView: View {
    
    @StateObject var model = MainViewModel()
    
    var body: some View {
        
        if let spriteKitView = model.spriteKitView{
            spriteKitView
                .background{
                    GeometryReader{
                        geometry in
                        Color.clear.onAppear(){
                            model.spriteKitViewGP = geometry
                        }
                    }
                }
        }
        
        HStack {
            
            VStack{
                Button{
                    model.spriteKitView.spawnEnemies(numOfEnemies: 20, interval: 1)
                }label:{
                    Text("Play")
                }
            }
            
            VStack{
                Button{
                    model.spriteKitView.spawnEnemies(numOfEnemies: 20, interval: 1)
                }label:{
                    Text("Play")
                }
            }
            
            VStack{
                Text("Spike Cannon")
                Image("SpikeCannonThumbnail")
                    .resizable()
                    .frame(width:50, height: 50)
                    .background{
                        GeometryReader{
                            geometry in
                            Color.clear.onAppear{
                                model.spikeCannonThumbnailGP = geometry
                            }
                        }
                    }
                    .gesture(DragGesture()
                        .onChanged{
                            value in
                            
                            model.updatePositionOfNewTower(of: .spikeCannon, to: value.location)
                        }
                        .onEnded{
                            value in
                            
                            model.finalizePositionOfNewTower(of: .spikeCannon, to: value.location)
                            
                        })
                
                Text("$10")
                
            }
            
            VStack{
                Text("Time Manipulator")
                Image("TimeManipulatorThumbnail")
                    .resizable()
                    .frame(width:50, height: 50)
                    .background{
                        GeometryReader{
                            geometry in
                            Color.clear.onAppear{
                                model.timeManipulatorThumbnailGP = geometry
                            }
                        }
                    }
                    .gesture(DragGesture()
                        .onEnded{
                            value in
                            //model.convertPosition(of: .timeManipulator, at: value.location)
                        })
                Text("$40")
            }
            
            VStack{
                Text("Bolt Striker")
                Image("BoltStrikerThumbnail")
                    .resizable()
                    .frame(width:50, height: 50)
                    .background{
                        GeometryReader{
                            geometry in
                            Color.clear.onAppear{
                                model.boltStrikerThumbnailGP = geometry
                            }
                        }
                    }
                    .gesture(DragGesture()
                        .onEnded{
                            value in
                            //model.convertPosition(of: .boltStriker, at: value.location)
                        })
                Text("$20")
                
            }
            
        }
        .padding()
        .onAppear{
            if let scene = SKScene(fileNamed: "TDBaseScene"){
                model.spriteKitView = SpriteKitView(scene: scene)
            }
        }
        
    }
        
}

#Preview {
    MainView()
}
