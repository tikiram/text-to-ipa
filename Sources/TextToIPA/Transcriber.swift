public class Transcriber {

  private let dictionary: [String: [PhonesWord]]
  private let alphabetDictionary: [String: [PhonesWord]]

  public init(_ dictionary: [String: [PhonesWord]], alphabetDictionary: [String: [PhonesWord]]) {
    self.dictionary = dictionary
    self.alphabetDictionary = alphabetDictionary

  }

  func getIPAs(word: String) throws -> [[String]] {
    if word == "a" {
      return [["ə"]]
    }
    if word == "A" {
      return [["eɪ"]]
    }
    
    let phonesWords = getPhoneWords(word)

    let ipas = try phonesWords.map { try $0.toIPAComponents() }

    // TODO: move this to an extension? removeDuplicatesByKey
    let result = ipas.reduce(into: [String: [String]]()) { result, element in
      result[element.joined()] = element
    }
    return Array(result.values)
  }

  private func getPhoneWords(_ word: String) -> [PhonesWord] {
    // Note: this is too much for single letters
    //    if word.count == 1 {
    //      if let letterPhonesWords = alphabetDictionary[word] {
    //        return letterPhonesWords
    //      }
    //
    //      let phonesWords = dictionary[word.lowercased()] ?? []
    //
    //      if phonesWords.count > 1 {
    //        let letterPhonesWord = alphabetDictionary[word.uppercased()]?[0]
    //        return phonesWords.filter { $0.toString() != letterPhonesWord?.toString() }
    //      }
    //
    //      return phonesWords
    //    }
    
    let serializedWord = word.replacingOccurrences(of: "’", with: "'")

    let phonesWords = dictionary[serializedWord.lowercased()] ?? []
    return phonesWords
  }
}
