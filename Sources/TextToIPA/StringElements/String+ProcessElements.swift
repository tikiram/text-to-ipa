enum CutType {
  case whitespace
  case newline
  case endOfFile
}

extension String {
  func processElements(_ listener: StringElementsListener) {

    var chars: [Character] = []

    for c in self {
      switch c {
      case let char where isWordChar(char):
        chars.append(char)
      default:
        if !chars.isEmpty {
          listener.onWord(String(chars))
          chars.removeAll()
        }

        if ![" ", "\n"].contains(c) {
          listener.onSymbol(c)
        }

        if c == "\n" {
          listener.onCut(.newline)
        } else if c == " " {
          listener.onCut(.whitespace)
        }
      }
    }

    if !chars.isEmpty {
      listener.onWord(String(chars))
      chars.removeAll()
    }
    listener.onCut(.endOfFile)

  }
}

func isWordChar(_ char: Character) -> Bool {

  let symbols: [Character] = ["-", "'", "’"]

  if symbols.contains(char) {
    return true
  }

  if char >= "a" && char <= "z" {
    return true
  }
  if char >= "A" && char <= "Z" {
    return true
  }

  return false
}
