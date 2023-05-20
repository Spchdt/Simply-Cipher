import SwiftUI
import VisionKit

struct DataScanner: UIViewControllerRepresentable {
    @Binding var startScanning: Bool
    @Binding var scanText: String
    var shift: Int?
    var encode: Bool?
    var alphabets: [String]?
    
    
    func makeUIViewController(context: Context) -> DataScannerViewController {
        let controller = DataScannerViewController(
            recognizedDataTypes: [.text(languages: ["en"])],
            qualityLevel: .balanced,
            recognizesMultipleItems: true,
            isHighlightingEnabled: false
        )
        
        controller.delegate = context.coordinator
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: DataScannerViewController, context: Context) {
        
        if startScanning {
            try? uiViewController.startScanning()
        } else {
            uiViewController.stopScanning()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self, shift: shift, encode: encode, alphabets: alphabets)
    }
    
    class Coordinator: NSObject, DataScannerViewControllerDelegate {
        var parent: DataScanner
        var shift: Int?
        var encode: Bool?
        var alphabets: [String]?
        
        init(_ parent: DataScanner, shift: Int?, encode: Bool?, alphabets: [String]?) {
            self.parent = parent
            self.shift = shift
            self.encode = encode
            self.alphabets = alphabets
        }
        
        //Dictionary to store our custom highlights keyed by their associated item ID.
        var itemHighlightViews: [RecognizedItem.ID: HighlightView] = [:]
        // For each new item, create a new highlight view and add it to the view hierarchy.
        func dataScanner (_ dataScanner: DataScannerViewController, didAdd addItems: [RecognizedItem],
                          allItems: [RecognizedItem]) {
            
            func caesarCipher(text: String, shift: Int) -> String {
                var answer = ""
                
                for char in text {
                    if char.isLetter && char.isASCII {
                        let intChar = Int(char.asciiValue!)
                        var letter: Character
                        
                        if (char.isUppercase) {
                            letter = Character(UnicodeScalar((intChar + shift-65) % 26 + 65)!)
                        } else {
                            letter = Character(UnicodeScalar((intChar + shift-97) % 26 + 97)!)
                        }
                        answer.append(letter)
                        
                    } else {
                        answer.append(char)
                    }
                }
                return answer
            }
            
            func SubstitudeCipher(text: String, alphabets: [String], encode: Bool = true) -> String {
                let alphabet = ["a", "b", "c", "d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
                var tempText = ""
                for letter in text {
                    
                    if letter.isNumber || letter == " " {
                        tempText += "\(letter)"
                    } else {
                        let upper = letter.isUppercase
                        
                        if encode {
                            if let index = alphabet.firstIndex(of: "\(letter.lowercased())") {
                                tempText += upper ? alphabets[index].uppercased() : alphabets[index]
                            }
                        } else {
                            if let index = alphabets.firstIndex(of: "\(letter.lowercased())") {
                                tempText += upper ? alphabet[index].uppercased() : alphabet[index]
                            }
                        }
                    }
                }
                return tempText
            }
            
            
            for item in addItems {
                var cipherText = ""
                func getText() -> String {
                    switch item {
                    case .text(let text):
                        return text.transcript
                    default: break
                    }
                    return ""
                }
                if shift != nil {
                    cipherText = caesarCipher(text: getText(), shift: shift!)
                } else if encode != nil && alphabets != nil {
                    cipherText = SubstitudeCipher(text: getText(), alphabets: alphabets!, encode: encode!)
                }
                
                let newView = HighlightView(text: cipherText)
                itemHighlightViews[item.id] = newView
                dataScanner.overlayContainerView.addSubview(newView)
                
            }
        }
        
        // Animate highlight views to their new bounds
        func dataScanner (_ dataScanner: DataScannerViewController, didUpdate updatedItems:
                          [RecognizedItem], allItems: [RecognizedItem]) {
            for item in updatedItems {
                if let view = itemHighlightViews[item.id] {
                    animate(view: view, toNewBounds: item.bounds)
                }
            }
        }
        
        func animate(view: UIView, toNewBounds newBounds: RecognizedItem.Bounds) {
            let rect = CGRect(origin: newBounds.bottomLeft,
                              size: CGSize(width: newBounds.topRight.x - newBounds.topLeft.x,
                                           height: newBounds.topRight.y - newBounds.bottomRight.y))
            
            view.frame = rect
        }
        
        // Yeet highlights when their associated items are removed
        func dataScanner (_ dataScanner: DataScannerViewController, didRemove removedItems:
                          [RecognizedItem], allItems: [RecognizedItem]) {
            for item in removedItems {
                if let view = itemHighlightViews[item.id] {
                    itemHighlightViews.removeValue(forKey: item.id)
                    view.removeFromSuperview( )
                }
            }
        }
    }
}

