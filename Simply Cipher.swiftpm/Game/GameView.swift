import SwiftUI

struct GameView: View {
    @State private var stage = 1
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                CaesarGame(stage: $stage, geo: geo)
                    .opacity(stage == 1 ? 1 : 0)
                CaesarQuizGame(stage: $stage)
                    .opacity(stage == 2 ? 1 : 0)
                SubstitutionGame(stage: $stage, geo: geo)
                    .opacity(stage == 3 ? 1 : 0)
                WinView()
                    .opacity(stage == 4 ? 1 : 0)
            }
            .animation(.easeIn, value: stage)
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

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
