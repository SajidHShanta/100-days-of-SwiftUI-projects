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
    
    @State private var tappedFlug = 3
    @State private var degrees = 0.0
    
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
                            withAnimation(.linear(duration: 0.4)) {
                                tappedFlug = number
                                degrees += 360
                            }
                        } label: {
                            FlagImage(country: countries[number])
                                .opacity(tappedFlug == number || tappedFlug == 3 ? 1 : 0.25)
                                .scaleEffect(tappedFlug == number || tappedFlug == 3 ? 1 : 0.90)
//                            Image(countries[number])
//                                .renderingMode(.original)
//                                .clipShape(Capsule())
//                                .shadow(radius: 5)
                        }
                        .opacity(60)
                        .rotation3DEffect(.degrees(tappedFlug == number ? degrees : 0), axis: (x: 0.0, y: 1.0, z: 0.0))
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
        withAnimation() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.38) {
                showingScore = true}
        }
//        showingScore = true
    }
    
    func askNextQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        tappedFlug = 3
        degrees = 0
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
