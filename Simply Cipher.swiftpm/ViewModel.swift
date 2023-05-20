import SwiftUI

class ViewModel: ObservableObject {
    //Original alphabets
    @Published var alphabet = ["a", "b", "c", "d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
    
    //Encrypt/Decrypted text with Caesar Cipher
    func caesarCipher(text: String,shift: Int) -> String {
        var answer = ""
        
        for char in text {
            if char.isLetter {
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
    
    //Encrypt/ Decrypted text with Substitution Cipher
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
    
}
