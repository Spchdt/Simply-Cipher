import SwiftUI

struct AddButton: View {
    @Namespace private var animation
    @State var expand = false
    @Binding var viewBlock: [Any]
    @Binding var inputOutput: [String]
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: expand ? 40 : 25, style: .continuous)
                    .frame(width: expand ? 200 : 80, height: expand ? 300 : 80)
                    .foregroundColor(Color.indigo)
                    .matchedGeometryEffect(id: "Shape", in: animation)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            expand.toggle()
                        }
                    }
                if !expand {
                    Image(systemName: "plus")
                        .foregroundColor(Color.white)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                } else {
                    VStack {
                        Spacer()
                        Button {
                            withAnimation {
                                inputOutput.append("")
                                viewBlock.append(CaesarBlock.self)
                                expand = false
                            }
                        } label: {
                            VStack {
                                Image(systemName: "arrow.left.and.right.text.vertical")
                                Text("Caesar")
                            }
                            .font(.title)
                            .foregroundColor(Color.white)
                            .frame(width: 180, height: 130)
                            .background(Color.white.opacity(0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                            .fontWeight(.bold)
                        }
                        
                        Spacer()
                        Button {
                            withAnimation {
                                inputOutput.append("")
                                viewBlock.append(SubstitutionBlock.self)
                                expand = false
                            }
                        } label: {
                            VStack {
                                Image(systemName: "rectangle.2.swap")
                                Text("Substitution")
                            }
                            .font(.title)
                            .foregroundColor(Color.white)
                            .frame(width: 180, height: 130)
                            .background(Color.white.opacity(0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                            .fontWeight(.bold)
                        }
                        Spacer()
                    }
                }
            }
            .frame(width: 200, height: 300)
            .padding(.trailing, 20)
        }
        .frame(height: 700)
    }
}
