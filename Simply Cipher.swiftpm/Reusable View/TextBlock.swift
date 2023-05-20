import SwiftUI

struct textBlock: View {
    let text: String
    var width: CGFloat = 350
    var height: CGFloat = 100
    
    var body: some View {
        Text(text)
            .font(.title)
            .fontWeight(.semibold)
            .frame(width: width, height: height)
            .background(RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(Color(UIColor.tertiarySystemBackground))
                .clipped(), alignment: .center)
    }
}
