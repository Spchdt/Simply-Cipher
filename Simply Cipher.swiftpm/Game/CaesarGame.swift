import SwiftUI

struct CaesarGame: View {
    @Binding var stage: Int
    @Namespace private var animation
    @StateObject var vm = ViewModel()
    @State private var bottomAlphabets = ["z", "a", "b", "c", "d"]
    @State private var currentShift = 0
    @State private var plainText = "Rggcv"
    @State private var encryptedText = "Rggcv"
    @State private var encode = false
    @State private var correct = false
    let geo: GeometryProxy
    @State var answerShift = 17
    @State private var disable = false
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                ZStack {
                    VStack {
                        Text("Decode the Secret Message")
                            .font(.system(size: 40))
                            .fontWeight(.bold)
                            .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.blue, .cyan]), startPoint: .topLeading, endPoint: .bottomTrailing)
                            )
                            .padding(.bottom, 5)
                        Text("Tap the \(Image(systemName: "chevron.left.circle.fill")) or \(Image(systemName: "chevron.right.circle.fill")) to shift the key +1 or -1. Search the right key to reveal the message.")
                            .font(.title2)
                            .fontWeight(.semibold)
                    }
                    .opacity(correct ? 0 : 1)
                    HStack {
                        Spacer()
                        Text("\(Image(systemName: "checkmark.circle.fill")) Correct!")
                            .font(.system(size: 50))
                            .fontWeight(.bold)
                            .foregroundColor(Color.green)
                            .opacity(correct ? 1 : 0)
                        Spacer()
                    }
                }
                .padding(.bottom, 30)
                HStack {
                    Spacer()
                    VStack(alignment: .leading) {
                        Text("Secret message")
                            .font(.title2)
                            .fontWeight(.medium)
                            .padding(.leading, 15)
                        textBlock(text: encryptedText)
                    }
                    Spacer()
                    VStack() {
                        Text("")
                            .font(.title2)
                            .foregroundColor(Color.clear)
                            .fontWeight(.medium)
                        Image(systemName: "arrow.right")
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                    }
                    Spacer()
                    VStack(alignment: .leading) {
                        Text("Message")
                            .font(.title2)
                            .fontWeight(.medium)
                            .padding(.leading, 15)
                        textBlock(text: plainText)
                            .foregroundColor(correct ? Color.green : nil)
                    }
                    Spacer()
                }
                .onChange(of: encryptedText) { text in
                    if !encode {
                        withAnimation {
                            plainText = vm.caesarCipher(text: encryptedText, shift: -currentShift)
                        }
                    }
                }
                .onChange(of: currentShift) { newValue in
                    withAnimation {
                        if currentShift == answerShift {
                            correct = true
                            disable = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                if plainText == "Apple" {
                                    encryptedText = "Ncgy Guwbchy"
                                    answerShift = 20
                                } else if plainText == "Time Machine" {
                                    encryptedText = "Htrrwp xzop"
                                    answerShift = 11
                                } else {
                                    stage += 1
                                }
                                correct = false
                                disable = false
                            }
                        }
                    }
                }
                Spacer()
                    .frame(height: 40)
                HStack {
                    Spacer()
                    CaesarModule(encode: $encode, currentShift: $currentShift, bottomAlphabets: $bottomAlphabets, plainText: $plainText, encryptedText: $encryptedText, disable: $disable)
                    
                    Spacer()
                }
            }
            .animation(.easeIn, value: correct)
        }
    }
}
