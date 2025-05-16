class EnglishTextTreeMaker: StringElementsListener {
  private(set) var lines: [TextLine] = []
  private var islands: [TextIsland] = []
  private var elements: [TextElement] = []

  func onWord(_ word: String) {
    elements.append(TextElement(text: word, isWord: true))
  }

  func onSymbol(_ char: Character) {
    elements.append(TextElement(text: String(char), isWord: false))
  }

  func onCut(_ cutType: CutType) {
    if !elements.isEmpty {
      islands.append(TextIsland(elements: elements))
      elements.removeAll()
    }

    switch cutType {
    case .newline, .endOfFile:
      lines.append(TextLine(islands: islands))
      islands.removeAll()
      break
    case .whitespace:
      break
    }
  }
}
