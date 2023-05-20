import SwiftUI

struct CardButton: View {
    var icon: String
    var title: String
    var color: Color
    var width: CGFloat = 300
    var height: CGFloat = 65
    var cornerRadius: CGFloat = 25
    var center: Bool = false
    
    var body: some View {
        HStack{
            if center {
                Spacer()
            } else {
                Spacer()
                    .frame(width: 10)
            }
            Image(systemName: icon)
                .font(.title)
                .fontWeight(.bold)
            Text(title)
                .font(.title)
                .fontWeight(.bold)
            Spacer()
            
        }
        .frame(width: width, height: height)
        .foregroundColor(Color.white)
        .padding(10)
        .background(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
            .fill(color)
            .clipped(), alignment: .center)
        
    }
}
