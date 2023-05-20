import SwiftUI

struct SubstitutionHelp: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("Help")
                    .font(.system(size: 40))
                    .fontWeight(.bold)
                    .padding(.leading, 100)
                ScrollView {
                    VStack(alignment: .leading) {
                        Spacer()
                            .frame(height: 20)
                        HelpItem(view: AnyView(Image(systemName: "a.square.fill")
                            .symbolRenderingMode(.multicolor)
                            .font(.system(size: 60))
                            .offset(x: -5)
                            .foregroundColor(Color.teal)), label: "Hold and drag to the left or right to change the order of the key")
                        HelpItem(view: AnyView(Image(systemName: "doc.viewfinder")
                            .font(.largeTitle)
                            .foregroundColor(Color.white)
                            .frame(width: 55, height: 55)
                            .background(RoundedRectangle(cornerRadius: 13, style: .continuous)
                                .foregroundStyle(Color.teal)
                                .clipped(), alignment: .center)), label: "Tap to enter scanner mode. In this mode, you can encrypted any text around you in real time by using the camera.")
                        HelpItem(view: AnyView(ActionButton(title:"Encode", color: Color.teal, width: 100, height: 25, cornerRadius: 100)), label: "Tap to translate from plain text to encrypted text.")
                        HelpItem(view: AnyView(ActionButton(title:"Decode", color: Color.teal, width: 100, height: 25, cornerRadius: 100)), label: "Tap to translate from encrypted text to plain text.")
                        
                        Divider()
                            .padding(.horizontal, 100)
                    }
                }
                .toolbar(content: {
                    Button("Done") {
                        dismiss()
                    }
                })
            }
        }
    }
}
