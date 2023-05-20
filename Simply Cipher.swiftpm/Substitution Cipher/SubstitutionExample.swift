import SwiftUI

struct SubstitutionExample: View {
    @StateObject var vm = ViewModel()
    @Binding var outerPage: Int
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var bottomAlphabets = ["z", "a", "b", "c", "d"]
    @State private var currentShift = 0
    @State private var encode = true
    @State private var disable =  false
    @State private var encryptedText = "BBQC23"
    @State private var alphabets = ["z", "w", "c", "q","e","f","g","h","i","j","k","l","m","n","o","p","d","r","s","t","u","v","b","x","y","a"]
    @State private var plainText = "WWDC23"
    let geo: GeometryProxy
    @State var draggedLetter: String?
    @State private var play = false
    
    func substitude() {
        var tempText = ""
        for letter in plainText {
            
            if letter.isNumber {
                tempText += "\(letter)"
            } else {
                let upper = letter.isUppercase
                
                if let index = vm.alphabet.firstIndex(of: "\(letter.lowercased())") {
                    tempText += upper ? alphabets[index].uppercased() : alphabets[index]
                } else {
                    return
                }
            }
        }
        encryptedText = tempText
    }
    
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
            Text("The Art of Substitution")
                .font(.largeTitle)
                .foregroundColor(Color.teal)
                .fontWeight(.bold)
            Spacer()
                .frame(height: 20)
            SubstitutionExampleText(encryptedText: $encryptedText, alphabets: $alphabets)
            Spacer()
                .frame(height: 30)
            VStack {
                HStack {
                    Spacer()
                    textBlock(text: plainText, width: 300, height: 80)
                    Spacer()
                    Image(systemName: "arrow.right")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                    Spacer()
                    textBlock(text: encryptedText, width: 300, height: 80)
                    Spacer()
                }
                Spacer()
                    .frame(height: 30)
                HStack {
                    Spacer()
                    SubstitutionModule(encode: $encode, alphabets: $alphabets, plainText: $plainText, encryptedText: $encryptedText, disable: $disable, draggedLetter: $draggedLetter)
                    Spacer()
                }
                .onReceive(timer) { time in
                    if play {
                        let oldPosition = Int.random(in: 0..<25)
                        let newPosition = Int.random(in: 0..<25)
                        withAnimation {
                            let movedLetter = alphabets.remove(at: oldPosition)
                            alphabets.insert(movedLetter, at: newPosition)
                        }
                    }
                    
                }
            }
            Spacer()
            VStack {
                Text("HOLD and DRAG any \(Image(systemName: "a.square.fill")) letter in the bottom row and DROP it in a new place.")
                    .font(.title2)
                    .foregroundColor(Color.teal)
                    .fontWeight(.semibold)
                ZStack {
                    Button {
                        withAnimation {
                            play.toggle()
                        }
                    } label: {
                        ToggleButton(title: play ? "Pause" : "Auto Play", color: Color.teal, icon: play ? "pause.fill" : "play.fill", width: 160)
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
                    .foregroundColor(Color.white)
                }
            }
        }
    }
}

struct SubstitutionExampleText: View {
    @StateObject var vm = ViewModel()
    @Binding var encryptedText: String
    @Binding var alphabets: [String]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Let's encrypt ")
            + Text("\"WWDC23\"")
                .fontWeight(.bold)
                .foregroundColor(Color.teal)
            + Text(" with the 🗝️ key of ")
            HStack {
                Text("          \u{2022} ")
                ForEach(alphabets, id: \.self) { letter in
                    Text(letter)
                }
            }
            .foregroundColor(Color.teal)
            
            Text("As the key changes, the original letter is mapped with a new symbol.")
                .font(.title2)
        }
        .font(.title)
        .fontWeight(.semibold)
    }
}
