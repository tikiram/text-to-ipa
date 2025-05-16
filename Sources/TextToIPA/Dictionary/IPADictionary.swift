struct IPADictionary {
  private let ipaWords: [String: [[String]]]

  init(ipaWords: [String: [[String]]]) {
    self.ipaWords = ipaWords
  }

  func getTranscriptionTexts(_ word: String) throws -> [[String]] {
    // TODO: check how to handle new words
    if word == "a" {
      return [["ə"]]
    }
    if word == "A" {
      return [["eɪ"]]
    }

    let serializedWord = word.replacingOccurrences(of: "’", with: "'")
    return ipaWords[serializedWord.lowercased()] ?? []
  }
}

