extension String {
  func toTextTree() -> TextTree {
    let textMaker = TextTreeMaker()
    self.processElements(textMaker)
    return TextTree(lines: textMaker.lines)
  }
}
