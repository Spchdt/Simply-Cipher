import SwiftUI
import VisionKit

struct SubstitutionLab: View {
    @Environment(\.dismiss) var dismiss
    @Namespace private var animation
    @StateObject var vm = ViewModel()
    @State private var encryptedText = ""
    @State private var alphabets = ["a", "b", "c", "d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
    @State private var plainText = ""
    @State var draggedLetter: String?
    @State private var play = true
    @State private var encode = true
    @State private var disable = false
    @State private var showingHelp = false
    @State private var showingScanner = false
    @State private var alreadyShowHelp = false
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
            VStack(alignment: .leading) {
                HStack(spacing: 20) {
                    Text("Try it yourself!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.teal, .mint]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                    Spacer()
                    Button {
                        withAnimation {
                            showingScanner = true
                        }
                    } label: {
                        HStack {
                            Image(systemName: "doc.viewfinder")
                                .font(.largeTitle)
                            Text("Scan")
                                .font(.title2)
                                .fontWeight(.bold)
                        }
                        .foregroundColor(Color.white)
                        .padding(8)
                        .background(RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .foregroundStyle(Color.teal)
                            .clipped(), alignment: .center)
                        
                    }
                    HStack {
                        ZStack {
                            if encode {
                                Spacer()
                                    .background(Capsule().fill(Color.teal)
                                        .clipped(), alignment: .center)
                                    .matchedGeometryEffect(id: "Encode", in: animation)
                            }
                            ActionButton(title:"Encode", color: Color.clear, width: 100, height: 25, cornerRadius: 100)
                        }
                        ZStack {
                            if !encode {
                                Spacer()
                                    .background(Capsule().fill(Color.teal)
                                        .clipped(), alignment: .center)
                                    .matchedGeometryEffect(id: "Encode", in: animation)
                            }
                            ActionButton(title:"Decode", color: Color.clear, width: 100, height: 25, cornerRadius: 100)
                        }
                    }
                    .padding(5)
                    .background(Capsule()
                        .fill(Color.teal.opacity(0.6))
                        .clipped(), alignment: .center)
                    .onTapGesture(perform: {
                        withAnimation {
                            encode.toggle()
                        }
                    })
                    Button {
                        withAnimation {
                            showingHelp = true
                        }
                    } label: {
                        Image(systemName: "questionmark.circle.fill")
                            .foregroundColor(Color.teal)
                            .font(.largeTitle)
                    }
                }
                Spacer()
                    .frame(height: 30)
                HStack {
                    Spacer()
                    if encode {
                        textFieldBlock(text: $plainText, label: "Plain Text", height: 180, disabled: false)
                            .matchedGeometryEffect(id: "PlainText", in: animation)
                            .animation(.easeIn, value: 10)
                    } else {
                        textFieldBlock(text: $encryptedText, label: "Encrypted Text", height: 180, disabled: false)
                            .matchedGeometryEffect(id: "EncryptedText", in: animation)
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
                    if encode {
                        textFieldBlock(text: $encryptedText, label: "Encrypted Text", height: 180, disabled: true)
                            .matchedGeometryEffect(id: "EncryptedText", in: animation)
                    } else {
                        textFieldBlock(text: $plainText, label: "Plain Text", height: 180, disabled: true)
                            .matchedGeometryEffect(id: "PlainText", in: animation)
                    }
                    Spacer()
                }
                .onChange(of: plainText) { text in
                    if encode {
                        withAnimation {
                            encryptedText = vm.SubstitudeCipher(text: plainText, alphabets: alphabets)
                        }
                    }
                }
                .onChange(of: encryptedText) { text in
                    if !encode {
                        withAnimation {
                            plainText = vm.SubstitudeCipher(text: encryptedText, alphabets: alphabets, encode: false)
                        }
                    }
                }
                Spacer()
                    .frame(height: 30)
                HStack {
                    Spacer()
                    SubstitutionModule(encode: $encode, alphabets: $alphabets, plainText: $plainText, encryptedText: $encryptedText, disable: $disable, draggedLetter: $draggedLetter)
                    Spacer()
                }
            }
            
            Spacer()
            HStack {
                Spacer()
                
                Button {
                    withAnimation {
                        dismiss()
                    }
                } label: {
                    ActionButton(title: "Return", color: Color(UIColor.darkGray))
                }
            }
            
        }
        .onAppear(perform: {
            if !alreadyShowHelp {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    showingHelp = true
                    alreadyShowHelp = true
                }
            }
        })
        .sheet(isPresented: $showingHelp) {
            SubstitutionHelp()
        }
        .sheet(isPresented: $showingScanner) {
            SubstitutionScanner(encode: encode, alphabets: alphabets)
        }
    }
}

struct SubstitutionScanner: View {
    @State private var startScanning = false
    @State private var scanText = ""
    var encode: Bool
    var alphabets: [String]
    
    var body: some View {
        GeometryReader {geo in
            VStack {
                DataScanner(startScanning: $startScanning, scanText: $scanText, encode: encode, alphabets: alphabets)
                    .task {
                        if DataScannerViewController.isSupported && DataScannerViewController.isAvailable {
                            startScanning.toggle()
                        }
                    }
            }
            .frame(width: geo.size.width, height: geo.size.height)
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        }
    }
}
