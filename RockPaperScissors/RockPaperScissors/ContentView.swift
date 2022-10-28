//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Sajid Shanta on 15/10/22.
//

import SwiftUI

struct ContentView: View {
    let  rockPaperScissors = ["Rock", "Paper", "Scissors"]
    
    @State private var appsMove = Int.random(in: 0...2)
    @State private var playersMove = "Rock"
    @State private var isWin: Bool

    @State private var score = 0
    
    var body: some View {
        VStack {
            Text("Score: \(score)")
            
            Section {
                Picker("Player's move", selection: $playersMove){
                    ForEach(rockPaperScissors, id: \.self){
                        Text($0)
                    }
                }
            } header: {
                Text("Select your move")
            }
            .padding()

            .pickerStyle(.segmented)
            Text("App’s move: \(rockPaperScissors[appsMove])")
            Text(rockPaperScissors[appsMove] == playersMove ? "Win" : "Loss")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
