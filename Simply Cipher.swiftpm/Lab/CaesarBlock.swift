import SwiftUI

struct CaesarBlock: View {
    @Namespace private var animation
    @StateObject var vm = ViewModel()
    @State private var bottomAlphabets = ["z", "a", "b", "c", "d"]
    @State private var currentShift = 0
    @State var index : Int
    @Binding var plainText: String
    @Binding var encryptedText: String
    @State private var encode = true
    @State private var disable = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("\(Image(systemName: "\(index+1).circle.fill")) Caesar Cipher")
                    .font(.system(size: 40))
                    .fontWeight(.bold)
                    .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.blue, .cyan]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                Spacer()
                Group {
                    if currentShift == 0 {
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
                    Text(index == 0 ? "Plain Text" : "Encrypted Text \(index)")
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
                    Text("Encrypted Text \(index+1)")
                        .font(.title2)
                        .fontWeight(.medium)
                        .padding(.leading, 15)
                    textFieldBlock(text: $encryptedText, label: "", height: 180, disabled: true)
                        .disabled(true)
                }
                Spacer()
            }
            
            .padding(.bottom, 30)
            .onChange(of: plainText) { text in
                encryptedText = vm.caesarCipher(text: plainText, shift: currentShift)
            }
            .onChange(of: currentShift) { newValue in
                encryptedText = vm.caesarCipher(text: plainText, shift: currentShift)
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation {
                        encryptedText = vm.caesarCipher(text: plainText, shift: currentShift)
                    }
                }
                
            }
            Spacer()
            HStack {
                Spacer()
                CaesarModule(encode: $encode, currentShift: $currentShift, bottomAlphabets: $bottomAlphabets, plainText: $plainText, encryptedText: $encryptedText, disable: $disable)
                
                Spacer()
            }
        }
    }
}
