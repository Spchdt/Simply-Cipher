import SwiftUI

struct textFieldBlock: View {
    @Binding var text: String
    let label: String
    var width: CGFloat = 350
    var height: CGFloat = 200
    var disabled: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.title2)
                .fontWeight(.medium)
                .padding(.leading, 15)
            TextField(disabled ? "" : "Enter text", text: $text, axis: .vertical)
                .lineLimit(5...10)
                .font(.title)
                .fontWeight(.semibold)
                .padding(30)
                .frame(width: width, height: height)
                .padding(.top, 20)
                .background(RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .fill(Color(UIColor.tertiarySystemBackground))
                    .clipped(), alignment: .center)
        }
    }
}
