import SwiftUI

struct ActionButton: View {
    var title: String
    var color: Color
    var width: CGFloat = 125
    var height: CGFloat = 35
    var cornerRadius: CGFloat = 15
    
    var body: some View {
        HStack{
            Spacer()
            Text(title)
                .font(.title2)
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
