/// listen to english elements
protocol StringElementsListener {
  func onWord(_ word: String)
  func onSymbol(_ char: Character)
  func onCut(_ cutType: CutType)
}
