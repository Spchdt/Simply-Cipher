import SwiftUI
import VisionKit

struct CaesarLab: View {
    @Environment(\.dismiss) var dismiss
    @Namespace private var animation
    @StateObject var vm = ViewModel()
    @State private var bottomAlphabets = ["z", "a", "b", "c", "d"]
    @State private var currentShift = 0
    @State private var plainText = ""
    @State private var encryptedText = ""
    @State private var showingHelp = false
    @State private var showingScanner = false
    @State private var encode = true
    @State private var disable = false
    @State private var alreadyShowHelp = false
    let geo: GeometryProxy
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                HStack(spacing: 20) {
                    Text("Try it yourself!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.blue, .cyan]), startPoint: .topLeading, endPoint: .bottomTrailing)
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
                        .padding(.vertical, 8)
                        .padding(.horizontal, 15)
                        .background(RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .foregroundStyle(Color.blue)
                            .clipped(), alignment: .center)
                        
                    }
                    HStack {
                        ZStack {
                            if encode {
                                Spacer()
                                    .background(Capsule().fill(Color.blue)
                                        .clipped(), alignment: .center)
                                    .matchedGeometryEffect(id: "Encode", in: animation)
                            }
                            ActionButton(title:"Encode", color: Color.clear, width: 100, height: 25, cornerRadius: 100)
                        }
                        ZStack {
                            if !encode {
                                Spacer()
                                    .background(Capsule().fill(Color.blue)
                                        .clipped(), alignment: .center)
                                    .matchedGeometryEffect(id: "Encode", in: animation)
                            }
                            ActionButton(title:"Decode", color: Color.clear, width: 100, height: 25, cornerRadius: 100)
                        }
                    }
                    .padding(5)
                    .background(Capsule()
                        .fill(Color.blue.opacity(0.6))
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
                            .font(.largeTitle)
                    }
                    
                    
                }
                Spacer()
                    .frame(height: 50)
                HStack {
                    Spacer()
                    if encode {
                        textFieldBlock(text: $plainText, label: "Plain Text", disabled: false)
                            .matchedGeometryEffect(id: "PlainText", in: animation)
                            .animation(.easeIn, value: 10)
                    } else {
                        textFieldBlock(text: $encryptedText, label: "Encrypted Text", disabled: false)
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
                        textFieldBlock(text: $encryptedText, label: "Encrypted Text", disabled: true)
                            .matchedGeometryEffect(id: "EncryptedText", in: animation)
                    } else {
                        textFieldBlock(text: $plainText, label: "Plain Text", disabled: true)
                            .matchedGeometryEffect(id: "PlainText", in: animation)
                    }
                    Spacer()
                }
                .onChange(of: plainText) { text in
                    if encode {
                        withAnimation {
                            encryptedText = vm.caesarCipher(text: plainText, shift: currentShift)
                        }
                    }
                }
                .onChange(of: encryptedText) { text in
                    if !encode {
                        withAnimation {
                            plainText = vm.caesarCipher(text: encryptedText, shift: -currentShift)
                        }
                    }
                }
                Spacer()
                    .frame(height: 40)
                HStack {
                    Spacer()
                    ZStack(alignment: .top) {
                        CaesarModule(encode: $encode, currentShift: $currentShift, bottomAlphabets: $bottomAlphabets, plainText: $plainText, encryptedText: $encryptedText, disable: $disable)
                        VStack {
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
                    }
                    Spacer()
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
            CaesarHelp()
        }
        .sheet(isPresented: $showingScanner) {
            CaesarScanner(shift: encode ? currentShift : -currentShift)
        }
    }
}

struct CaesarScanner: View {
    @State private var startScanning = false
    @State private var scanText = ""
    var shift: Int
    
    var body: some View {
        GeometryReader {geo in
            VStack {
                DataScanner(startScanning: $startScanning, scanText: $scanText, shift: shift)
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
