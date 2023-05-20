import SwiftUI

struct SubstitutionBlock: View {
    @Namespace private var animation
    @StateObject var vm = ViewModel()
    @Binding var encryptedText: String
    @State private var alphabets = ["a", "b", "c", "d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
    @Binding var plainText: String
    @State var index : Int
    @Binding var viewBlock: [Any]
    @State var draggedLetter: String?
    @State private var encode = true
    @State private var disable = false
    
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
            HStack {
                Text("\(Image(systemName: "\(index+1).circle.fill")) Substitution Cipher")
                    .font(.system(size: 40))
                    .fontWeight(.bold)
                    .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.teal, .mint]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                Spacer()
                Group {
                    if plainText == encryptedText {
                        Text("Change the key to encrypt")
                            .foregroundColor(.gray)
                    } else {
                        Text("\(Image(systemName: "checkmark.circle.fill")) Encrypted")
                            .foregroundColor(.green)
                    }
                }
                .font(.title2)
                .fontWeight(.bold)
            }
            .padding(.bottom, 10)
            
            HStack(spacing: 10) {
                Spacer()
                VStack(alignment: .leading) {
                    Text((index == 0 ? "Plain Text" : "Encrypted Text \(index)"))
                        .font(.title2)
                        .fontWeight(.medium)
                        .padding(.leading, 15)
                    textFieldBlock(text: $plainText, label: "", height: 180, disabled: index != 0)
                        .disabled(index != 0)
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
                    Text(("Encrypted Text \(index+1)"))
                        .font(.title2)
                        .fontWeight(.medium)
                        .padding(.leading, 15)
                    textFieldBlock(text: $encryptedText, label: "", height: 180, disabled: true)
                        .disabled(true)
                }
                Spacer()
            }
            .onChange(of: plainText) { text in
                withAnimation {
                    encryptedText = vm.SubstitudeCipher(text: plainText, alphabets: alphabets)
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation {
                        encryptedText = vm.SubstitudeCipher(text: plainText, alphabets: alphabets)
                    }
                }
                
            }
            Spacer()
            HStack {
                Spacer()
                SubstitutionModule(encode: $encode, alphabets: $alphabets, plainText: $plainText, encryptedText: $encryptedText, disable: $disable, draggedLetter: $draggedLetter)
                
                Spacer()
            }
            Spacer()
        }
    }
}
