import SwiftUI

struct WelcomeView: View {
    @State var selection = 0
    @Binding var firstTime: Bool
    
    var body: some View {
        GeometryReader { geo in
            TabView(selection: $selection) {
                Welcome1(selection: $selection)
                    .tag(0)
                Welcome2(selection: $selection)
                    .tag(1)
                Welcome3(firstTime: $firstTime)
                    .tag(2)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .padding(geo.size.width/25)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(RoundedRectangle(cornerRadius: 60, style: .continuous)
                .fill(Color(UIColor.secondarySystemBackground))
                .clipped(), alignment: .center)
            .padding(.horizontal, geo.size.width/20)
            .padding(.vertical, geo.size.width/30)
        }
    }
}

struct Welcome1: View {
    @Binding var selection: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Spacer()
            Text("Welcome to")
                .font(.title)
                .fontWeight(.semibold)
                .padding(.bottom, -10)
            Text("Simply Cipher")
                .font(.system(size: 50))
                .fontWeight(.bold)
                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.blue, .teal]), startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                .padding(.bottom, 20)
            Text("Have you ever send a secret message to your friend before? You may or may not, but your phone surely does! iMessage, for example, takes your text and encrypts it into a secret message. After that, it gets forwarded to your friend's phone, which automatically decrypts the secret message into a readable text that your friend can read.")
                .font(.title2)
                .fontWeight(.semibold)
            Spacer()
            HStack(spacing: 40) {
                Spacer()
                BigCardButton(icon: "cloud", title: "Storage", color: Color.teal, width: 180, height: 180, cornerRadius: 40)
                BigCardButton(icon: "envelope", title: "Email", color: Color.mint, width: 180, height: 180, cornerRadius: 40)
                BigCardButton(icon: "message", title: "Messages", color: Color.green, width: 180, height: 180, cornerRadius: 40)
                Spacer()
            }
            Spacer()
            HStack {
                Spacer()
                Button {
                    withAnimation {
                        selection = 1
                    }
                } label: {
                    ActionButton(title: "Next", color: Color.blue, width: 150)
                }
            }
        }
        
    }
}

struct Welcome2: View {
    @Binding var selection: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Spacer()
            Text("What is Cryptography?")
                .font(.system(size: 50))
                .fontWeight(.bold)
                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.indigo, .purple]), startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                .padding(.bottom, 20)
            Text("Cryptography is when you and your friend come up with a secret code ,aka a key, together, in which only both of you know. Meaning, if a stranger come up and steals your message, they won't be able to know the meaning behind it because they don't know what the \"key\" you and your friend use to encrypt the message.")
                .font(.title2)
                .fontWeight(.semibold)
            Spacer()
            HStack(spacing: 40) {
                Spacer()
                VStack(spacing: 10) {
                    CardButton(icon: "cloud", title: "Message", color: Color.indigo, width: 250, height: 70, cornerRadius: 30, center: true)
                    Image(systemName: "plus")
                        .font(.system(size: 40))
                        .fontWeight(.bold)
                    CardButton(icon: "key", title: "Secret Key", color: Color.indigo, width: 250, height: 70, cornerRadius: 30, center: true)
                        .font(.body)
                }
                Image(systemName: "equal")
                    .font(.system(size: 40))
                    .fontWeight(.bold)
                BigCardButton(icon: "key.icloud", title: "Encrypted Message", color: Color.indigo, width: 300, height: 130, cornerRadius: 35)
                    .font(.body)
                Spacer()
            }
            Spacer()
            HStack {
                Spacer()
                Button {
                    withAnimation {
                        selection = 2
                    }
                } label: {
                    ActionButton(title: "Next", color: Color.blue, width: 150)
                }
            }
        }
    }
}

struct Welcome3: View {
    @Environment(\.dismiss) var dismiss
    @Binding var firstTime: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Spacer()
            Text("Basics of Cipher")
                .font(.system(size: 50))
                .fontWeight(.bold)
                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.blue, .cyan]), startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                .padding(.bottom, 20)
            Text("In cryptography, cipher is just a tehnique in which we can use to encrypt and decrypt a message. In the next few minutes, we are going to go learn the basics of ciphers! There are hundreds of ciphers out there, but today, our goal is to understand two of the simplest forms of cipher.")
                .font(.title2)
                .fontWeight(.semibold)
            Spacer()
            HStack(spacing: 40) {
                Spacer()
                CardButton(icon: "arrow.left.and.right.text.vertical", title: "Caesar Cipher", color: Color.blue, width: 320, height: 100, cornerRadius: 30, center: true)
                CardButton(icon: "rectangle.2.swap", title: "Substitute Cipher", color: Color.cyan, width: 320, height: 100, cornerRadius: 30, center: true)
                Spacer()
            }
            Spacer()
            HStack {
                Spacer()
                Button {
                    if firstTime {
                        withAnimation(.easeInOut(duration: 2)) {
                            firstTime = false
                        }
                    } else {
                        dismiss()
                    }
                } label: {
                    ActionButton(title: "Let's get started", color: Color.blue, width: 200)
                        .navigationBarBackButtonHidden(true)
                }
            }
        }
    }
}
