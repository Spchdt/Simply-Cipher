import SwiftUI

struct WinView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 10) {
            Text("Congrats! You did it")
                .font(.system(size: 50))
                .fontWeight(.bold)
            Text("Head back and explore the lab feature!")
                .font(.title)
                .fontWeight(.semibold)
            Text("🥳")
                .font(.system(size: 100))
                .padding(10)
            Button {
                dismiss()
            } label: {
                ActionButton(title: "Return", color: Color.gray)
            }
        }
    }
}
