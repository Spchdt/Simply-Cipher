import SwiftUI

struct BigCardButton: View {
    var icon: String
    var title: String
    var color: Color
    
    var width: CGFloat = 300
    var height: CGFloat = 60
    var cornerRadius: CGFloat = 25
    
    var body: some View {
        VStack{
            Spacer()
            Image(systemName: icon)
                .font(.system(size: 50))
                .fontWeight(.bold)
            Spacer()
                .frame(height: 10)
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
