import SwiftUI

//Drag and Drop features for Substitution Cipher Key
struct SubstitutionDropViewDelegate: DropDelegate {
    let destinationItem: String
    @Binding var alphabets: [String]
    @Binding var draggedItem: String?
    
    func dropUpdated(info: DropInfo) -> DropProposal? {
        return DropProposal(operation: .move)
    }
    
    func performDrop(info: DropInfo) -> Bool {
        draggedItem = nil
        return true
    }
    
    func dropEntered(info: DropInfo) {
        // Swap Items
        if let draggedItem {
            let fromIndex = alphabets.firstIndex(of: draggedItem)
            if let fromIndex {
                let toIndex = alphabets.firstIndex(of: destinationItem)
                if let toIndex, fromIndex != toIndex {
                    withAnimation {
                        self.alphabets.move(fromOffsets: IndexSet(integer: fromIndex), toOffset: (toIndex > fromIndex ? (toIndex + 1) : toIndex))
                    }
                }
            }
        }
    }
}
