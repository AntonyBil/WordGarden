//
//  ContentView.swift
//  WordGarden
//
//  Created by apple on 30.08.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var wordsGuessed = 0
    @State private var wordsMissed = 0
    @State private var currentWordIndex = 0
    @State private var wordToGuess = ""
    @State private var revealdWord = ""
    @State private var lettersGuessed = ""
    @State private var gameStatusMassage = "How Many Guesses to Uncover the Hidden Word?"
    @State private var guessedLetter = ""
    @State private var imageName = "flower8"
    @State private var playAgainHidden = true
    
    @FocusState private var textFieldIsFocused: Bool
    private let wordsToGuess = ["SWIFT","DOG", "CAT"]
    
    var body: some View {
        VStack {
            HStack{
                VStack(alignment: .leading) {
                    Text("Word Gussed: \(wordsGuessed)")
                    Text("Word Missed: \(wordsMissed)")
                }
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text("Words to Guess: \(wordsToGuess.count - (wordsGuessed + wordsMissed))")
                    Text("Words in Game: \(wordsToGuess.count)")
                }
            }
            .padding(.horizontal)
            
            Spacer()
            
            Text(gameStatusMassage)
                .font(.title)
                .multilineTextAlignment(.center)
                .padding()
            
            Spacer()
            
            //TODO: Switch to wordsToGuess[currentWord]
            
            Text(revealdWord)
                .font(.title)
        
            if playAgainHidden {
                HStack {
                    TextField("", text: $guessedLetter)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 30)
                        .overlay {
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(.green, lineWidth: 2)
                        }
                        .keyboardType(.asciiCapable)
                        .submitLabel(.done)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.characters)
                        .onChange(of: guessedLetter) { _ in
                          guessedLetter = guessedLetter.trimmingCharacters(in: .letters.inverted)
                            guard let lastChar = guessedLetter.last else {
                                return
                            }
                            guessedLetter = String(lastChar).uppercased()
                        }
                        .onSubmit {
                            guard guessedLetter != "" else {
                                return
                            }
                            guessALetter()
                        }
                        .focused($textFieldIsFocused)
                    
                    Button("Gues a Letter") {
                        guessALetter()
                    }
                    .buttonStyle(.bordered)
                    .tint(.mint)
                    .disabled(guessedLetter.isEmpty)
                }
            } else {
                Button("Another Word?") {
                    //TODO: Another Word Button action
                    
                }
                .buttonStyle(.borderedProminent)
                .tint(.mint)
                
            }
            
            Spacer()
            
            Image(imageName)
                .resizable()
                .scaledToFit()
        }
        .ignoresSafeArea(edges: .bottom)
        .onAppear() {
            wordToGuess = wordsToGuess[currentWordIndex]
            //Create a string from a repeating value
            revealdWord = "_" + String(repeating: " _", count: wordToGuess.count - 1)
        }
    }
    func guessALetter() {
        textFieldIsFocused = false
        lettersGuessed = lettersGuessed + guessedLetter
        
        revealdWord = ""
        //loop through all letters in wordToGuess
        for letter in wordToGuess {
            if lettersGuessed.contains(letter) {
                revealdWord = revealdWord + "\(letter)"
            } else {
                revealdWord = revealdWord + "_ "
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
