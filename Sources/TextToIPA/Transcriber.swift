enum TranscriberError: Error {
  case dictionaryNotLoaded
}

public class Transcriber {

  private var dictionary: [String: [PhonesWord]]

  public init(dictionary: [String: [PhonesWord]]) {
    self.dictionary = dictionary
  }

  public func parse(_ text: String) async throws -> TranscriptionDocument {
    let document = await processText(text)
    return try await document.transcribe(self)
  }

  public func getIPAs(word: String) throws -> [[String]] {
    if word == "a" {
      return [["ə"]]
    }
    if word == "A" {
      return [["eɪ"]]
    }

    let phonesWords = try getPhoneWords(word)

    let ipas = try phonesWords.map { try $0.toIPAComponents() }

    // TODO: move this to an extension? removeDuplicatesByKey
    let result = ipas.reduce(into: [String: [String]]()) { result, element in
      result[element.joined()] = element
    }
    return Array(result.values)
  }

  private func getPhoneWords(_ word: String) throws -> [PhonesWord] {

    let serializedWord = word.replacingOccurrences(of: "’", with: "'")
    let phonesWords = dictionary[serializedWord.lowercased()] ?? []
    return phonesWords
  }
}
