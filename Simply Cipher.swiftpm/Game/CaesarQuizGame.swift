//
//  FallingGame.swift
//  Zipher
//
//  Created by Supachod Trakansirorut on 12/4/2566 BE.
//

import SwiftUI

struct CaesarQuizGame: View {
    @Binding var stage: Int
    @StateObject var vm = ViewModel()
    @State private var round = 0
    @State private var qTexts = ["WWDC23", "Hello", "Rainbow", "Finder"]
    @State private var qKeys = [2, 4, 25, 10]
    @State private var qAnswer = ["Ans 1","Ans 2","Ans 3","Ans 4"]
    @State private var qCorrect = "Ans 2"
    @State private var correct = false
    @State private var incorrect = false
    
    func generateAnswer() {
        var nums = [Int](0...25)
        nums.remove(at: qKeys[round])
        nums.shuffle()
        
        let ans1 = vm.caesarCipher(text: qTexts[round], shift: qKeys[round])
        let ans2 = vm.caesarCipher(text: qTexts[round], shift: nums[0])
        let ans3 = vm.caesarCipher(text: qTexts[round], shift: nums[1])
        let ans4 = vm.caesarCipher(text: qTexts[round], shift: nums[2])
        
        let answers = [ans1, ans2, ans3, ans4]
        
        qCorrect = ans1
        qAnswer = answers.shuffled()
    }
    
    var body: some View {
        VStack(spacing: 15) {
            ZStack {
                Text("\(Image(systemName: "xmark.circle.fill")) Incorrect, try again!")
                    .foregroundColor(Color.red)
                    .opacity(incorrect ? 1 : 0)
                Text("\(Image(systemName: "checkmark.circle.fill")) Correct!")
                    .foregroundColor(Color.green)
                    .opacity(correct ? 1 : 0)
                Text("Encrypt message with a given key")
                    .font(.system(size: 40))
                    .fontWeight(.bold)
                    .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.purple, .indigo]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                    .opacity(incorrect || correct ? 0 : 1)
            }
            .font(.system(size: 50))
            .fontWeight(.bold)
            .padding(.bottom, 50)
            HStack {
                Text("What does")
                Text(qTexts[round])
                    .padding(.horizontal, 15)
                    .padding(.vertical, 10)
                    .background(RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .foregroundColor(Color(UIColor.tertiarySystemFill))
                        .clipped(), alignment: .center)
                Text("encrypted with key of")
                Text("+\(qKeys[round])")
                    .padding(.horizontal, 15)
                    .padding(.vertical, 10)
                    .background(RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .foregroundColor(Color(UIColor.tertiarySystemFill))
                        .clipped(), alignment: .center)
                Text("encode to?")
            }
            .fontWeight(.bold)
            Spacer()
                .frame(height: 20)
            ForEach(qAnswer, id: \.self) { answer in
                HStack {
                    Image(systemName: "\(qAnswer.firstIndex(of: answer)! + 1).circle.fill")
                        .font(.largeTitle)
                    Button {
                        if answer == qCorrect {
                            withAnimation {
                                correct = true
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                if round == 3 {
                                    withAnimation {
                                        stage += 1
                                    }
                                } else {
                                    withAnimation {
                                        correct = false
                                        round += 1
                                    }
                                }
                            }
                        } else {
                            withAnimation {
                                incorrect = true
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                withAnimation {
                                    incorrect = false
                                }
                            }
                        }
                    } label: {
                        Text(answer)
                            .foregroundColor(answer == qCorrect && correct ? Color.white : Color(UIColor.label))
                            .frame(width: 250, height: 50)
                            .background(RoundedRectangle(cornerRadius: 15, style: .continuous)
                                .foregroundColor(answer == qCorrect && correct ? Color.green : Color(UIColor.tertiarySystemFill))
                                .clipped(), alignment: .center)
                        
                    }
                    .disabled(correct || incorrect)
                }
                .fontWeight(.semibold)
                
            }
        }
        .onChange(of: round, perform: { _ in
            generateAnswer()
        })
        .onAppear(perform: {
            generateAnswer()
        })
        .font(.title)
        
    }
}
