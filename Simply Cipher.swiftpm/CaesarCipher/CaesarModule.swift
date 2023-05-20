import SwiftUI

struct CaesarModule: View {
    @StateObject var vm = ViewModel()
    @Binding var encode: Bool
    @Binding var currentShift: Int
    @Binding var bottomAlphabets: [String]
    @Binding var plainText: String
    @Binding var encryptedText: String
    @Binding var disable: Bool
    let originalAlphabet = ["z","a", "b", "c", "d"]
    
    func incrementShift() {
        withAnimation {
            bottomAlphabets.remove(at: 0)
            currentShift += 1
            if currentShift == vm.alphabet.count {
                currentShift = 0
            }
            let newLetter = vm.caesarCipher(text: vm.alphabet[currentShift], shift: 3)
            bottomAlphabets.append(newLetter)
            if encode {
                encryptedText = vm.caesarCipher(text: plainText, shift: currentShift)
            } else {
                plainText = vm.caesarCipher(text: encryptedText, shift: 26 - currentShift)
            }
            
        }
    }
    
    func decrementShift() {
        withAnimation {
            bottomAlphabets.remove(at: 4)
            currentShift -= 1
            if currentShift == -1 {
                currentShift = vm.alphabet.count - 1
            }
            let newLetter = vm.caesarCipher(text: vm.alphabet[currentShift], shift: 25)
            bottomAlphabets.insert(newLetter, at: 0)
            if encode {
                encryptedText = vm.caesarCipher(text: plainText, shift: currentShift)
            } else {
                plainText = vm.caesarCipher(text: encryptedText, shift: 26 - currentShift)
            }
        }
    }
    
    var body: some View {
        VStack(spacing: 10) {
            HStack(alignment: .top) {
                ForEach(originalAlphabet, id: \.self) { letter in
                    VStack {
                        Image(systemName: "\(letter).square.fill")
                            .font(.system(size: 60))
                            .symbolRenderingMode(.multicolor)
                            .foregroundColor(letter == "a" ? Color.blue : Color(UIColor.systemGray))
                        
                        if letter == "a" {
                            ZStack {
                                if encode {
                                    Image(systemName: "arrow.down")
                                    Text("+\(currentShift)")
                                        .offset(x: 40)
                                } else {
                                    Image(systemName: "arrow.up")
                                    Text("-\(currentShift)")
                                        .offset(x: 40)
                                }
                            }
                            .font(.title)
                            .foregroundColor(Color.blue)
                            .fontWeight(.semibold)
                        }
                    }
                }
            }
            HStack(spacing: 20) {
                Button {
                    decrementShift()
                } label: {
                    Image(systemName: "chevron.left.circle.fill")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }.disabled(disable)
                
                HStack {
                    ForEach(bottomAlphabets, id: \.self) { letter in
                        Image(systemName: "\(letter).square.fill")
                            .font(.system(size: 60))
                            .symbolRenderingMode(.multicolor)
                            .foregroundColor(letter == vm.alphabet[currentShift] ? Color.blue.opacity(0.7) : Color(UIColor.systemGray3))
                            .id(letter)
                    }
                }
                .frame(width: 450)
                .padding(10)
                .background(RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .fill(Color(UIColor.tertiarySystemBackground))
                    .clipped(), alignment: .center)
                Button {
                    incrementShift()
                } label: {
                    Image(systemName: "chevron.right.circle.fill")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                .disabled(disable)
            }   
        }
    }
}
