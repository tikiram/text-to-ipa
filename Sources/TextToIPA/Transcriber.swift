public class Transcriber {

  private let dictionary: [String: [PhonesWord]]

  public init(_ dictionary: [String: [PhonesWord]]) {
    self.dictionary = dictionary
  }

  func getIPAs(word: String) throws -> [[String]] {
    let phonesWords = dictionary[word.lowercased()] ?? []

    return try phonesWords.map { try $0.toIPAComponents() }
  }
}
