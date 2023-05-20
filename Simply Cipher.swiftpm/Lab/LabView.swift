import SwiftUI

struct LabView: View {
    @State var stage = 1
    @State var inputOutput : [String] = ["", ""]
    @State var viewBlock: [Any] = []
    @State private var showingHelp = false
    
    func buildView(types: [Any], index: Int) -> AnyView {
        switch types[index].self {
        case is SubstitutionBlock.Type:
            return AnyView(
                SubstitutionBlock(encryptedText: $inputOutput[index+1], plainText: $inputOutput[index], index: index, viewBlock: $viewBlock)
            )
        case is CaesarBlock.Type:
            return AnyView(
                CaesarBlock(index: index, plainText: $inputOutput[index], encryptedText: $inputOutput[index+1])
            )
        default: return AnyView(EmptyView())
        }
    }
    
    func checkOccurance(list: [String]) -> Bool {
        let newList = Set(list)
        if newList.count >= 4 {
            return true
        } else {
            return false
        }
    }
    
    var body: some View {
        GeometryReader { geo in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(0..<viewBlock.count, id: \.self) { index in
                        self.buildView(types: self.viewBlock, index: index)
                            .padding(geo.size.width/25)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(RoundedRectangle(cornerRadius: 60, style: .continuous)
                                .fill(Color(UIColor.secondarySystemBackground))
                                .clipped(), alignment: .center)
                            .padding(.horizontal, geo.size.width/20)
                            .padding(.vertical, geo.size.width/30)
                        
                        if index != viewBlock.count-1 {
                            Image(systemName: "arrow.right")
                                .font(.system(size: 50))
                                .fontWeight(.bold)
                        }
                    }
                    VStack {
                        ZStack {
                            NavigationLink {
                                Result(encryptedText: inputOutput[inputOutput.count - 2], plainText: inputOutput.first!, randomText: inputOutput[inputOutput.count - 2], win: checkOccurance(list: inputOutput))
                            } label: {
                                ToggleButton(title: "Send", color: inputOutput.first == inputOutput[inputOutput.count - 2] ? Color.gray : Color.purple, icon: "paperplane.fill")
                            }
                            .disabled(inputOutput.first == inputOutput[inputOutput.count - 2])
                            .offset(x: -10, y: 100)
                            AddButton(viewBlock: $viewBlock, inputOutput: $inputOutput)
                        }
                    }
                    .frame(width: viewBlock.isEmpty ? geo.size.width : nil)

                }
                .animation(.easeIn, value: viewBlock.count)
            }
        }
        .onAppear(perform: {
            showingHelp = true
        })
        .toolbar {
            HStack {
                Text("Tap \(Image(systemName: "plus.square.fill")) to add more encryption")
                    .fontWeight(.semibold)
                    .padding(.trailing, 10)
                Button {
                    showingHelp = true
                } label: {
                    Image(systemName: "questionmark.circle.fill")
                        .font(.title2)
                }
            }
        }
        .sheet(isPresented: $showingHelp) {
            LabHelp()
        }
    }
}

struct Lab_Previews: PreviewProvider {
    static var previews: some View {
        LabView()
    }
}
