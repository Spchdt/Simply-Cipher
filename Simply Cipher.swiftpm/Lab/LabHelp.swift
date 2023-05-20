import SwiftUI

struct LabHelp: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Spacer()
                    .frame(height: 60)
                Text("Multiple Encryption")
                    .font(.system(size: 40))
                    .fontWeight(.bold)
                    .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.indigo, .purple]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                    .padding(.leading, 100)
                VStack(alignment: .leading) {
                    Spacer()
                        .frame(height: 20)
                    Divider()
                    
                    Text("Multiple encryption is when you encrypt an already-encrypted message, making it more secure and harder to decrypt by an unknown stranger.")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Spacer()
                        .frame(height: 20)
                    
                    Text("Tap the \(Image(systemName: "plus.square.fill")) button to create a new encryption. Here, you can keep adding the encryption as many times as you want!")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Spacer()
                        .frame(height: 20)
                    
                    Text("When you're done, hit \(Image(systemName: "paperplane.fill")) to test your encryption.")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    
                    Spacer()
                        .frame(height: 50)
                    HStack {
                        Spacer()
                        VStack {
                            Text("🗝️🗝️🗝️")
                                .font(.system(size: 70))
                            
                            Spacer()
                                .frame(height: 100)
                            Button {
                                dismiss()
                            } label: {
                                ActionButton(title: "Let's begin", color: Color.indigo, width: 150)
                            }
                        }
                        Spacer()
                    }
                    Spacer()
                }
                .padding(.horizontal, 80)
                Spacer()
                
            }
        }
        .background(Color.clear)
    }
}
