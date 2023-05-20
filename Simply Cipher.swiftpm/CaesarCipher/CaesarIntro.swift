import SwiftUI

struct CaesarIntro: View {
    let geo: GeometryProxy
    @Binding var page: Int
    
    var body: some View {
        HStack(alignment: .top) {
            VStack{
                Spacer()
                Image(systemName: "arrow.left.and.right.text.vertical")
                    .font(.system(size: 70))
                    .fontWeight(.bold)
                Spacer()
                
            }
            .frame(width: 200)
            .frame(maxHeight: .infinity)
            .foregroundColor(Color.white)
            .padding(10)
            .background(RoundedRectangle(cornerRadius: 40, style: .continuous)
                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.blue, .cyan]), startPoint: .topLeading, endPoint: .bottomTrailing)
                                )
                    .clipped(), alignment: .center)
            Spacer()
                .frame(width: 70)
            VStack(alignment: .leading) {
                Spacer()
                    .frame(height: 50)
                Text("Caesar Cipher?")
                    .font(.system(size: 50))
                    .fontWeight(.bold)
                    .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.blue, .cyan]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                Spacer()
                    .frame(height: 20)
                Text("The Caesar Cipher is used to encrypt messages. It works by shifting each letter of the alphabet down a certain number of places. To do it, simply:")
                    .font(.title)
                    .fontWeight(.semibold)
                Spacer()
                    .frame(height: 50)
                Text("\(Image(systemName: "1.circle.fill")) Write your 🗒️ message\n\(Image(systemName: "2.circle.fill")) Choose a number (this will be your 🗝️ key)")
                    .font(.title)
                    .foregroundColor(Color.blue)
                    .fontWeight(.semibold)
                Spacer()
                    .frame(height: 20)
                Text("Let's look at an example on the next page!")
                    .font(.title2)
                    .fontWeight(.semibold)
                Spacer()
                HStack {
                    Spacer()
                    Button {
                        withAnimation {
                            page = 2
                        }
                    } label: {
                        ActionButton(title: "Understand!", color: Color(UIColor.darkGray), width: 160)
                    }
                }
                .foregroundColor(Color.white)
            }
        }
    }
}
