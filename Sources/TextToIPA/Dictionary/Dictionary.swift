import Foundation

func loadDictionary() async throws -> IPADictionary {
  let url = Bundle.module.url(forResource: "cmudict", withExtension: "dict")
  //  let url = Bundle.module.url(forResource: "dev.cmudict", withExtension: "dict")

  guard let url else {
    throw RuntimeError("Could not find dict file")
  }

  let content = try String(contentsOf: url, encoding: .utf8)

  let ipaWords = try await loadDictionaryText(content)

  return IPADictionary(ipaWords: ipaWords)
}

private func loadDictionaryText(_ text: String) async throws -> [String: [[String]]] {
  var ipaWords: [String: [[String]]] = [:]

  try processCMUDicEntries(text) { name, transcriptions in
    let uniqueTranscriptions = try transcriptions.removeDuplicatedUsingKey { try $0.toString() }
    ipaWords[name] = try uniqueTranscriptions.map { try $0.getElements() }
  }

  return ipaWords
}

  func getTranscriptionTexts(_ word: String) throws -> [[String]] {
    let serializedWord = word.replacingOccurrences(of: "’", with: "'")
    let ipaWord = ipaWords[serializedWord.lowercased()]
    let transcriptions = ipaWord?.transcriptions ?? []
    let uniqueTranscriptions = try transcriptions.removeDuplicatedUsingKey { try $0.toString() }
    return try uniqueTranscriptions.map { try $0.getElements() }
  }


private struct CMUdictEntry {
  let name: String
  let phones: [IPAPhone]

  // func toIPA() throws -> String {
  //   return try IPAWord(phones).toString()
  // }
}

private func processCMUdictEntry(_ entry: String) throws -> CMUdictEntry {
  let components = entry.split(separator: " ")

  let name = components[0].split(separator: "(")[0]

  let stringPhones = components.dropFirst()
  let phones = try stringPhones.map(phoneStringToPhone)

  return CMUdictEntry(name: String(name), phones: phones)
}

private func phoneStringToPhone(phone: Substring) throws -> IPAPhone {
  // ARPAbet have a max of 2-letter elements
  // then an stress or auxiliary symbol

  let corePhone = phone.prefix(2)

  guard phone.count > 2 else {
    return IPAPhone(core: String(corePhone), stress: nil)
  }

  let stress = phone.suffix(from: phone.index(phone.startIndex, offsetBy: 2))

  return IPAPhone(core: String(corePhone), stress: String(stress))
}

func processCMUDicEntries(_ text: String, _ action: @escaping (String, [IPATranscription]) -> Void)
  throws
{
  var previousName: String = ""
  var transcriptions: [IPATranscription] = []

  try text.processLines { line in
    let result = try processCMUdictEntry(line)

    if result.name != previousName {
      previousName = result.name
      action(previousName, transcriptions)
      transcriptions = []
    }
    transcriptions.append(IPATranscription(phones: result.phones))
  }
}
