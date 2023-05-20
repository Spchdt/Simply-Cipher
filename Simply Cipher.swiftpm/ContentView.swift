import SwiftUI

struct ContentView: View {
    //Show welcome first if the user open the app for the first time
    @AppStorage("firstTime") var firstTime = true

    //Track unlocked section
    @AppStorage("unlocked") var unlocked = 0
    
    var body: some View {
        GeometryReader { geo in
            NavigationStack {
                if firstTime {
                    WelcomeView(firstTime: $firstTime)
                        .onDisappear {
                            withAnimation() {
                                if unlocked == 0 {
                                    unlocked += 1
                                }
                            }
                        }
                } else {
                    Group {
                        MenuView(firstTime: $firstTime, unlocked: $unlocked)
                            .padding(geo.size.width/25)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(RoundedRectangle(cornerRadius: 60, style: .continuous)
                                .fill(Color(UIColor.secondarySystemBackground))
                                .clipped(), alignment: .center)
                            
                    }
                    .padding(.horizontal, geo.size.width/20)
                    .padding(.vertical, geo.size.width/30)
                }
            }
            .animation(.easeIn, value: firstTime)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
