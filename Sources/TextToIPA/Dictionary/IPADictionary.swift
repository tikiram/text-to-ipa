struct IPADictionary {
  private let entries: [String: [[String]]]

  init(ipaWords: [String: [[String]]]) {
    self.entries = ipaWords
  }

  func getTranscriptionTexts(_ word: String) -> [[String]] {
    // TODO: check how to handle new words
    if word == "a" {
      return [["ə"]]
    }
    if word == "A" {
      return [["eɪ"]]
    }

    let serializedWord = word.replacingOccurrences(of: "’", with: "'")
    return entries[serializedWord.lowercased()] ?? []
  }
}
