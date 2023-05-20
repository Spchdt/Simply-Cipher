import SwiftUI

struct SubstitutionGame: View {
    @Binding var stage: Int
    @Namespace private var animation
    @StateObject var vm = ViewModel()
    @State private var encryptedText = "Dkfje"
    @State private var alphabets = ["b", "d", "a", "c", "g", "i", "e", "l", "f", "m", "s", "h", "o", "j", "k", "n", "y", "z", "p", "r", "w", "q", "u", "t", "v", "x"]
    @State private var plainText = ""
    @State var draggedLetter: String?
    @State private var play = true
    @State private var correct = false
    @State private var encode = false
    @State private var showingHelp = false
    @State private var showingScanner = false
    @State private var disable = false
    @State private var dragDisable = true
    @State private var answer = "Boing"
    let geo: GeometryProxy
    
    func isTheSameIndex(letter: String) -> Bool {
        var usedIndex: Array<Int> = []
        for letter in plainText {
            if let index = vm.alphabet.firstIndex(of: "\(letter.lowercased())") {
                usedIndex.append(index)
            }
        }
        if usedIndex.contains(alphabets.firstIndex(of: letter)!) {
            return true
        }
        
        return false
    }
    
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                VStack {
                    Text("Decode the Secret Message")
                        .font(.system(size: 40))
                        .fontWeight(.bold)
                        .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.teal, .mint]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                        .padding(.bottom, 5)
                    Text("Look at the key below and try to unveil the message." )
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
                textFieldBlock(text: $encryptedText, label: "Secret Message", height: 180, disabled: true)
                    .disabled(true)
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
                    Text("Plain Text")
                        .font(.title2)
                        .fontWeight(.medium)
                        .padding(.leading, 15)
                    textFieldBlock(text: $plainText, label: "", height: 180, disabled: disable)
                        .foregroundColor(correct ? Color.green : nil)
                        .disabled(disable)
                }
                Spacer()
            }
            .onChange(of: plainText) { text in
                withAnimation {
                    if plainText == answer {
                        correct = true
                        disable = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            if plainText == "Boing" {
                                encryptedText = "Pbibzf"
                                answer = "Safari"
                                disable = false
                            } else if plainText == "Safari" {
                                encryptedText = "Awngzrfjk"
                                answer = "Cupertino"
                                disable = false
                            } else {
                                stage += 1
                            }
                            correct = false
                            plainText = ""
                        }
                    }
                }
            }
            Spacer()
                .frame(height: 30)
            HStack {
                Spacer()
                SubstitutionModule(encode: $encode, alphabets: $alphabets, plainText: $plainText, encryptedText: $encryptedText, disable: $dragDisable, draggedLetter: $draggedLetter)
                
                Spacer()
            }
            
        }
        .animation(.easeIn, value: correct)
        .sheet(isPresented: $showingHelp) {
            CaesarHelp()
        }
        .sheet(isPresented: $showingScanner) {
            SubstitutionScanner(encode: encode, alphabets: alphabets)
        }
    }
}
