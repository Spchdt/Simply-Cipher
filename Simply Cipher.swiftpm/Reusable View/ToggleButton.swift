import SwiftUI

struct ToggleButton: View {
    var title: String
    var color: Color
    var icon: String
    var width: CGFloat = 125
    var height: CGFloat = 35
    
    var body: some View {
        HStack{
            Spacer()
            Image(systemName: icon)
                .font(.title2)
                .fontWeight(.bold)
            Spacer()
                .frame(width: width/10)
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
            Spacer()
            
        }
        .frame(width: width, height: height)
        .foregroundColor(Color.white)
        .padding(10)
        .background(Capsule()
            .fill(color)
            .clipped(), alignment: .center)
        
    }
}
