import SwiftUI

struct SubstitutionIntro: View {
    let geo: GeometryProxy
    @Binding var page: Int
    var body: some View {
        HStack(alignment: .top) {
            VStack{
                Spacer()
                Image(systemName: "rectangle.2.swap")
                    .font(.system(size: 70))
                    .fontWeight(.bold)
                Spacer()
                
            }
            .frame(width: 200)
            .frame(maxHeight: .infinity)
            .foregroundColor(Color.white)
            .padding(10)
            .background(RoundedRectangle(cornerRadius: 40, style: .continuous)
                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.teal, .mint]), startPoint: .topLeading, endPoint: .bottomTrailing)
                                )
                    .clipped(), alignment: .center)
            Spacer()
                .frame(width: 70)
            VStack(alignment: .leading) {
                Spacer()
                    .frame(height: 50)
                Text("Substitution Cipher?")
                    .font(.system(size: 50))
                    .fontWeight(.bold)
                    .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.teal, .mint]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                Spacer()
                    .frame(height: 20)
                Group {
                    Text("In Substitution Cipher, we use any set of symbols to represent each letter in our message. The symbols can be emojis, images, or just random order of alphabets.")
                        .font(.title)
                        .fontWeight(.semibold)
                    Spacer()
                        .frame(height: 50)
                    Text("\(Image(systemName: "1.circle.fill")) Write your 🗒️ message\n\(Image(systemName: "2.circle.fill")) Think of a random set of alphabets.\n          e.g. 🗝️ key = \"q, r, a, c, u, m....., p, u, f, d\"")
                        .font(.title)
                        .foregroundColor(Color.teal)
                        .fontWeight(.semibold)
                    Spacer()
                }
                HStack {
                    Spacer()
                    Button {
                        withAnimation {
                            page = 2
                        }
                    } label: {
                        ActionButton(title: "Understand!", color: Color(UIColor.darkGray), width: 160)
                    }
                    .offset(x: 70)
                }
                .foregroundColor(Color.white)
            }
            .padding(.trailing, 70)
        }
    }
}
