
class ProcessLine {
  private let line: String

  init(_ line: String) {
    self.line = line
  }

  private var components: [TextComponent] = []
  private var elements: [Element] = []
  private var chars: [Character] = []

  func getComponents() -> [TextComponent] {
    elements = []
    chars = []

    for char in line {
      switch char {
      case " ":
        appendWord()
        groupElements()
      case let char where isWordChar(char):
        chars.append(char)
      default:
        appendSymbol(char)
        break
      }
    }

    appendWord()
    groupElements()

    return components
  }

  private func appendSymbol(_ char: Character) {
    appendWord()
    elements.append(Element(text: String(char), isWord: false))
  }

  private func groupElements() {
    guard !elements.isEmpty else {
      return
    }
    components.append(TextComponent(elements: elements))
    elements.removeAll()
  }

  private func appendWord() {
    guard !chars.isEmpty else {
      return
    }
    elements.append(Element(text: String(chars), isWord: true))
    chars.removeAll()
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

