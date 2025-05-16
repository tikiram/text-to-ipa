extension String {
  func toEnglishTextTree() -> TextTree {
    let textMaker = EnglishTextTreeMaker()
    self.processEnglishElements(textMaker)
    return TextTree(lines: textMaker.lines)
  }
}
