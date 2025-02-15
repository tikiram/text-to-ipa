
struct TextComponent {
  let elements: [Element]

  func toString() -> String {
    return elements.map { $0.toString() }.joined()
  }
}
