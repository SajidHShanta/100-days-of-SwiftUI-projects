//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Sajid Shanta on 8/10/22.
//

import SwiftUI

struct FlagImage: View{
    var country: String
    
    var body: some View{
    Image(country)
        .renderingMode(.original)
        .clipShape(Capsule())
        .shadow(radius: 5)
    }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle.bold())
            .foregroundColor(.white)
    }
}

extension View {
    func prominentTitleStyle() -> some View {
        modifier(Title())
    }
}

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var score = 0
//    @State private var count = 1
    
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .prominentTitleStyle()
//                    .modifier(Title())
                
//                    .foregroundColor(.white)
//                    .font(.largeTitle.bold())
                
                VStack(spacing: 15) {
                    VStack{
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3) { number in
                        Button{
                            flagTapped(number)
                        } label: {
                            FlagImage(country: countries[number])
//                            Image(countries[number])
//                                .renderingMode(.original)
//                                .clipShape(Capsule())
//                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 50))
                .padding()
                
                Spacer()
                Spacer()

                
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue") {
                askNextQuestion()
            }
        } message: {
            Text("Your score is: \(score)")
        }
    }
    
    func flagTapped(_ number: Int) {
        if(number == correctAnswer) {
            scoreTitle = "Correct"
            score+=1
        } else {
            scoreTitle = "Wrong! It's the flag of \(countries[number])"
        }
        
        showingScore = true
    }
    
    func askNextQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
//    func restart() {
//        score = 0
//        count = 1
//    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



//VStack {
//    HStack{
//        Text("-*-")
//        Text("-*-")
//        Text("-*-")
//    }
//    HStack{
//        Text("-*-")
//        Text("-*-")
//        Text("-*-")
//    }
//    HStack{
//        Text("-*-")
//        Text("-*-")
//        Text("-*-")
//    }
//}
