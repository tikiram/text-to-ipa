struct TextTree {
  let lines: [TextLine]

  func toString() -> String {
    return lines.map { $0.toString() }.joined(separator: "\n")
  }
}

struct TextLine {
  let islands: [TextIsland]

  func toString() -> String {
    return "[" + islands.map { $0.toString() }.joined(separator: "-") + "]"
  }

}

struct TextIsland {
  let elements: [TextElement]

  func toString() -> String {
    return "(" + elements.map { $0.toString() }.joined() + ")"
  }
}

struct TextElement {
  let text: String
  let isWord: Bool

  func toString() -> String {
    return text
  }
}
