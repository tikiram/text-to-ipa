
public struct TextLine {
  let components: [TextComponent]

  func toString() -> String {
    return components.map { $0.toString() }.joined(separator: " ")
  }
}
