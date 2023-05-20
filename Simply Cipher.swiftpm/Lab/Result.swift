//
//  Result.swift
//  Zipher
//
//  Created by Supachod Trakansirorut on 14/4/2566 BE.
//

import SwiftUI

struct Result: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var vm = ViewModel()
    @Namespace private var animation
    let encryptedText: String
    let plainText: String
    @State var randomText : String
    @State var win: Bool
    @State private var send = 0
    let ending = 0
    @State private var random = false
    @State private var exposed = false
    
    @State private var reveal = false
    let timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
    
    func start() {
        withAnimation(.easeInOut(duration: 4)) {
            send += 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                random = true
                if win {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                        random = false
                        withAnimation(.easeInOut(duration: 4)) {
                            send += 1
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                            withAnimation {
                                reveal = true
                            }
                        }
                    }
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                        reveal = true
                    }
                }
            }
        }
    }
    
    var body: some View {
        VStack {
            ZStack {
                VStack {
                    Text("Your message is safely delivered!")
                        .font(.system(size: 40))
                        .fontWeight(.bold)
                        .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.green, .mint]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                        .padding(.bottom, 5)
                    Text("You did it, multiple encryption does really help strengthen the security")
                        .font(.title)
                        .fontWeight(.semibold)
                }
                .opacity(win && reveal ? 1 : 0)
                VStack {
                    Text("Uh oh, your message got exposed!")
                        .font(.system(size: 40))
                        .fontWeight(.bold)
                        .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.red, .orange]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                        .padding(.bottom, 5)
                    Text("Tip: Encrypt your message multiple times helps strengthen the security")
                        .font(.title)
                        .fontWeight(.semibold)
                }
                .opacity(!win && reveal ? 1 : 0)
                VStack {
                    Text("Tap start to send your message")
                        .font(.system(size: 40))
                        .fontWeight(.bold)
                        .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.blue, .teal]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                        .padding(.bottom, 5)
                    Text(".")
                        .font(.title)
                        .fontWeight(.semibold)
                        .hidden()
                }
                .opacity(send == 0 ? 1 : 0)
                .animation(nil, value: send)
                VStack {
                    Text("Sending the message...")
                        .font(.system(size: 40))
                        .fontWeight(.bold)
                        .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.blue, .teal]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                        .padding(.bottom, 5)
                        .opacity(send != 0 && !reveal ? 1 : 0)
                        .animation(nil, value: send)
                    Text("Your message gets intercepted by a malicious person. Let's see how it goes...")
                        .font(.title)
                        .fontWeight(.semibold)
                        .opacity(random && !reveal ? 1 : 0)
                }
                
            }
            HStack {
                VStack {
                    VStack {
                        if send == 0 {
                            Text(encryptedText)
                                .font(.largeTitle)
                                .fontWeight(.semibold)
                                .padding(20)
                                .frame(width: 300)
                                .background(RoundedRectangle(cornerRadius: 25, style: .continuous)
                                    .fill(Color(UIColor.secondarySystemBackground))
                                    .clipped(), alignment: .center)
                                .matchedGeometryEffect(id: "message", in: animation)
                            
                        }
                    }
                    .frame(width: 300, height: 100)
                    Image(systemName: "iphone.gen3")
                        .font(.system(size: 200))
                }
                VStack {
                    if send == 1 {
                        Text(reveal ? plainText : randomText)
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                            .padding(20)
                            .frame(width: 300)
                            .background(RoundedRectangle(cornerRadius: 25, style: .continuous)
                                .fill(Color(UIColor.secondarySystemBackground))
                                .clipped(), alignment: .center)
                            .matchedGeometryEffect(id: "message", in: animation)
                    }
                }
                .frame(width: 500)
                VStack {
                    VStack {
                        if send == 2 && win == true {
                            Text(reveal ? plainText : encryptedText)
                                .font(.largeTitle)
                                .fontWeight(.semibold)
                                .padding(20)
                                .frame(width: 300)
                                .background(RoundedRectangle(cornerRadius: 25, style: .continuous)
                                    .fill(Color(UIColor.secondarySystemBackground))
                                    .clipped(), alignment: .center)
                                .matchedGeometryEffect(id: "message", in: animation)
                        }
                    }
                    .frame(width: 300, height: 100)
                    Image(systemName: "iphone.gen3")
                        .font(.system(size: 200))
                }
                .onReceive(timer) { time in
                    if random == true {
                        randomText = vm.caesarCipher(text: encryptedText, shift: Int.random(in: 0..<25))
                    }
                }
            }
            ZStack {
                if reveal {
                    Button {
                        dismiss()
                    } label: {
                        ActionButton(title: win ? "Return" : "Try again", color: Color.indigo, width: 150)
                    }
                } else {
                    Button {
                        start()
                    } label: {
                        ToggleButton(title: "Start", color: send != 0 ? Color.gray : Color.indigo, icon: "play.fill")
                    }
                    .disabled(send != 0)
                    .animation(nil, value: send)
                }
            }
        }
    }
}
