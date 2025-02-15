
struct Element {
  let text: String
  let isWord: Bool

  func toString() -> String {
    return "(\(text)|\(isWord))"
  }
}
