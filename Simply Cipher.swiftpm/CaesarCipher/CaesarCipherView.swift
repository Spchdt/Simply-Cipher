import SwiftUI

struct CaesarCipherView: View {
    @State var outerPage = 1
    @State var page = 1
    
    var body: some View {
        GeometryReader { geo in
            TabView(selection: $outerPage) {
                TabView(selection: $page) {
                    CaesarIntro(geo: geo, page: $page)
                        .tag(1)
                    CaesarExample(outerPage: $outerPage, geo: geo)
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
                .tag(1)
                CaesarLab(geo: geo)
                    .padding(geo.size.width/25)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(RoundedRectangle(cornerRadius: 60, style: .continuous)
                        .fill(Color(UIColor.secondarySystemBackground))
                        .clipped(), alignment: .center)
                    .padding(.horizontal, geo.size.width/20)
                    .padding(.vertical, geo.size.width/30)
                
                    .tag(2)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
    }
}

struct CaesarCipherView_Previews: PreviewProvider {
    static var previews: some View {
        CaesarCipherView()
    }
}
