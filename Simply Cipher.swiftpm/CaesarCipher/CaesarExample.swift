import SwiftUI

struct CaesarExample: View {
    @StateObject var vm = ViewModel()
    @Binding var outerPage: Int
    let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    @State private var bottomAlphabets = ["z", "a", "b", "c", "d"]
    @State private var currentShift = 0
    @State private var encryptedText = "WWDC23"
    @State private var play = false
    @State private var plainText = "WWDC23"
    @State private var encode = true
    @State private var disable = false
    let geo: GeometryProxy
    
    func incrementShift() {
        withAnimation {
            bottomAlphabets.remove(at: 0)
            currentShift += 1
            if currentShift == vm.alphabet.count {
                currentShift = 0
            }
            let newLetter = vm.caesarCipher(text: vm.alphabet[currentShift], shift: 3)
            bottomAlphabets.append(newLetter)
            
            encryptedText = vm.caesarCipher(text: plainText, shift: currentShift)
            
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Shifting is the key")
                .font(.largeTitle)
                .foregroundColor(Color.blue)
                .fontWeight(.bold)
            Spacer()
                .frame(height: 20)
            CaesarExampleText(currentShift: $currentShift, encryptedText: $encryptedText)
            Spacer()
                .frame(height: 30)
            VStack {
                HStack {
                    Spacer()
                    textBlock(text: plainText)
                    Spacer()
                    Image(systemName: "arrow.right")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                    Spacer()
                    textBlock(text: encryptedText)
                    Spacer()
                }
                Spacer()
                    .frame(height: 40)
                CaesarModule(encode: $encode, currentShift: $currentShift, bottomAlphabets: $bottomAlphabets, plainText: $plainText, encryptedText: $encryptedText, disable: $disable)
                    .onReceive(timer, perform: { time in
                        if play {
                            incrementShift()
                        }
                    })
                Spacer()
                ZStack(alignment: .top) {
                    VStack {
                        Text("TAP  \(Image(systemName: "chevron.left.circle.fill")) or \(Image(systemName: "chevron.right.circle.fill")) to shift the KEY by +1 or -1, respectively.")
                            .font(.title2)
                            .foregroundColor(Color.blue)
                            .fontWeight(.semibold)
                        Spacer()
                        ZStack {
                            Button {
                                withAnimation {
                                    play.toggle()
                                }
                            } label: {
                                ToggleButton(title: play ? "Pause" : "Auto Play", color: Color.blue, icon: play ? "pause.fill" : "play.fill", width: 160)
                            }
                            HStack {
                                Spacer()
                                
                                Button {
                                    withAnimation {
                                        outerPage = 2
                                    }
                                } label: {
                                    ActionButton(title: "Next", color: Color(UIColor.darkGray))
                                }
                            }
                        }
                        
                    }
                }
            }
        }
        .onAppear {
            incrementShift()
        }
    }
}


struct CaesarExampleText: View {
    @StateObject var vm = ViewModel()
    @Binding var currentShift: Int
    @Binding var encryptedText: String
    
    var body: some View {
        Group {
            Text("In this example, ")
            + Text("\"WWDC23\"")
                .fontWeight(.bold)
                .foregroundColor(Color.blue)
            + Text(" is our 🗒️ message, and the 🗝️ key is ")
            + Text("\(currentShift)")
                .fontWeight(.bold)
                .foregroundColor(Color.blue)
            + Text(" so...")
            
            Text("          \u{2022} ")
            + Text("W+\(currentShift) = \(vm.caesarCipher(text: "W", shift: currentShift))")
                .fontWeight(.bold)
                .foregroundColor(Color.blue)
            + Text(" and ")
            + Text("D+\(currentShift) = \(vm.caesarCipher(text: "D", shift: currentShift))")
                .fontWeight(.bold)
                .foregroundColor(Color.blue)
            + Text(" and ")
            + Text("C+\(currentShift) = \(vm.caesarCipher(text: "C", shift: currentShift))")
                .fontWeight(.bold)
                .foregroundColor(Color.blue)
            + Text(", which result in ")
            + Text("\"\(encryptedText)\"")
                .fontWeight(.bold)
                .foregroundColor(Color.blue)
        }
        .font(.title)
        .fontWeight(.semibold)
    }
}
