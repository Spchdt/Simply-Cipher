import SwiftUI

struct MenuView: View {
    let spacing: CGFloat = 20
    @Binding var firstTime: Bool
    @Binding var unlocked: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Text("Welcome,")
                    .font(.system(size: 45))
                    .fontWeight(.bold)
                
                HStack(spacing: 0) {
                    Text("let's learn about ")
                        .font(.system(size: 45))
                        .fontWeight(.semibold)
                    
                    Text("Cipher")
                        .font(.system(size: 60))
                        .fontWeight(.bold)
                        .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.blue, .cyan]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                }
            }
            Spacer()
                .frame(height: 40)
            HStack(alignment: .top, spacing: spacing) {
                VStack(spacing: spacing) {
                    NavigationLink {
                        CaesarCipherView()
                            .navigationBarBackButtonHidden(true)
                            .onDisappear {
                                withAnimation {
                                    if unlocked == 1 {
                                        unlocked += 1
                                    }
                                }
                            }
                    } label: {
                        CardButton(icon: "arrow.left.and.right.text.vertical", title: unlocked < 1 ? "Locked" : "Caesar Cipher", color: unlocked < 1 ? Color.gray : Color.blue)
                    }
                    .disabled(unlocked < 1)
                    
                    NavigationLink {
                        SubstitutionCipherView()
                            .navigationBarBackButtonHidden(true)
                            .onDisappear {
                                withAnimation {
                                    if unlocked == 2 {
                                        unlocked += 1
                                    }
                                }
                            }
                    } label: {
                        CardButton(icon: "rectangle.2.swap", title: unlocked < 2 ? "Locked" : "Substitute", color: unlocked < 2 ? Color.gray : Color.cyan)
                    }
                    .disabled(unlocked < 2)
                    
                    NavigationLink {
                        GameView()
                            .navigationBarBackButtonHidden(true)
                            .onDisappear {
                                withAnimation {
                                    if unlocked == 3 {
                                        unlocked += 1
                                    }
                                }
                            }
                    } label: {
                        CardButton(icon: "gamecontroller", title: unlocked < 3 ? "Locked" : "Practice Game", color: unlocked < 3 ? Color.gray : Color.green)
                    }
                    .disabled(unlocked < 3)
                    
                }
                VStack(spacing: spacing) {
                    NavigationLink {
                        LabView()
                    } label: {
                        BigCardButton(icon: "testtube.2", title: unlocked < 4 ? "Locked" : "Lab", color: unlocked < 4 ? Color.gray : Color.indigo, width: 200, height: 180, cornerRadius: 35)
                    }
                    .disabled(unlocked < 4)
                    
                    NavigationLink {
                        WelcomeView(firstTime: $firstTime)
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        CardButton(icon: "menucard", title:  "Welcome", color: Color.orange, width: 200, height: 55)
                        
                    }
                }
            }
            .animation(.easeIn, value: unlocked)
        }
    }
}

struct ContentView_Previews2: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
