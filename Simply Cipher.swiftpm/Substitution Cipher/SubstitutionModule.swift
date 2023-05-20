import SwiftUI

struct SubstitutionModule: View {
    @StateObject var vm = ViewModel()
    @Binding var encode: Bool
    @Binding var alphabets: [String]
    @Binding var plainText: String
    @Binding var encryptedText: String
    @Binding var disable: Bool
    @Binding var draggedLetter: String?
    
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
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                VStack {
                    HStack(alignment: .top) {
                        ForEach(vm.alphabet, id: \.self) { letter in
                            VStack {
                                Image(systemName: "\(letter).square.fill")
                                    .font(.system(size: 60))
                                    .symbolRenderingMode(.multicolor)
                                    .foregroundColor(plainText.lowercased().contains(letter.lowercased()) ? Color.teal : Color(UIColor.systemGray))
                                
                                if plainText.lowercased().contains(letter.lowercased()) {
                                    ZStack {
                                        Image(systemName: encode ? "arrow.down" : "arrow.up")
                                    }
                                    .font(.title)
                                    .foregroundColor(Color.teal)
                                    .fontWeight(.semibold)
                                } else {
                                    ZStack {
                                        Image(systemName: "arrow.down")
                                    }
                                    .font(.title)
                                    .foregroundColor(Color.clear)
                                    .fontWeight(.semibold)
                                }
                            }
                        }
                    }
                    HStack(alignment: .top) {
                        
                        ForEach(alphabets, id: \.self) { letter in
                            VStack {
                                if disable {
                                    Image(systemName: "\(letter).square.fill")
                                        .font(.system(size: 60))
                                        .symbolRenderingMode(.multicolor)
                                        .foregroundColor(isTheSameIndex(letter: letter) ? Color.teal.opacity(0.7) : Color(UIColor.systemGray3))
                                } else {
                                    Image(systemName: "\(letter).square.fill")
                                        .font(.system(size: 60))
                                        .symbolRenderingMode(.multicolor)
                                        .foregroundColor(isTheSameIndex(letter: letter) ? Color.teal.opacity(0.7) : Color(UIColor.systemGray3))
                                        .onDrag {
                                            self.draggedLetter = letter
                                            return NSItemProvider()
                                        }
                                        .onDrop(of: [.text],
                                                delegate: SubstitutionDropViewDelegate(destinationItem: letter, alphabets: $alphabets, draggedItem: $draggedLetter)
                                        )
                                }
                            }
                        }
                        .onChange(of: alphabets) { newValue in
                            if encode {
                                encryptedText = vm.SubstitudeCipher(text: plainText, alphabets: alphabets)
                            } else {
                                plainText = vm.SubstitudeCipher(text: encryptedText, alphabets: alphabets, encode: false)
                            }
                        }
                    }
                }
            }
            .frame(width: 900, height: 180)
            .background(RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(Color(UIColor.tertiarySystemBackground))
                .clipped(), alignment: .center)
        }
    }
}
