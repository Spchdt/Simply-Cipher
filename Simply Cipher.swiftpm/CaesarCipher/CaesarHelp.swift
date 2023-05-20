import SwiftUI

struct CaesarHelp: View {
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
                        HelpItem(view: AnyView(Image(systemName: "chevron.left.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(Color.blue)), label: "Tap to shift the key by -1")
                        HelpItem(view: AnyView(Image(systemName: "chevron.right.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(Color.blue)), label: "Tap to shift the key by +1")
                        HelpItem(view: AnyView(Image(systemName: "doc.viewfinder")
                            .font(.largeTitle)
                            .foregroundColor(Color.white)
                            .frame(width: 55, height: 55)
                            .background(RoundedRectangle(cornerRadius: 13, style: .continuous)
                                .foregroundStyle(Color.blue)
                                .clipped(), alignment: .center)), label: "Tap to enter scanner mode. In this mode, you can encrypted any text around you in real time by using the camera.")
                        HelpItem(view: AnyView(ActionButton(title:"Encode", color: Color.blue, width: 100, height: 25, cornerRadius: 100)), label: "Tap to translate from plain text to encrypted text.")
                        HelpItem(view: AnyView(ActionButton(title:"Decode", color: Color.blue, width: 100, height: 25, cornerRadius: 100)), label: "Tap to translate from encrypted text to plain text.")
                        
                        Divider()
                            .padding(.horizontal, 100)
                    }
                }
            }
            .toolbar(content: {
                Button("Done") {
                    dismiss()
                }
            })
        }
        .background(Color.clear)
    }
}


struct HelpItem: View {
    var view: AnyView
    var label: String
    
    var body: some View {
        Divider()
            .padding(.horizontal, 100)
        HStack {
            view
            Spacer().frame(width: 50)
            Text(label)
                .font(.title2)
            
        }
        .padding(.horizontal, 100)
    }
}
