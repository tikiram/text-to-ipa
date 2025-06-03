import Foundation

func loadIPADictionary() async throws -> IPADictionary {
  let url = Bundle.module.url(forResource: "cmudict", withExtension: "dict")

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

private struct CMUdictEntry {
  let name: String
  let phones: [IPAPhone]
}

func processCMUDicEntries(
  _ text: String, _ action: @escaping (String, [IPATranscription]) throws -> Void
)
  throws
{
  var previousName: String = ""
  var transcriptions: [IPATranscription] = []

  try text.processLines { line in
    let result = try processCMUdictEntry(line)

    if result.name != previousName {
      try action(previousName, transcriptions)
      previousName = result.name
      transcriptions = []
    }
    transcriptions.append(IPATranscription(phones: result.phones))
  }
}

private func processCMUdictEntry(_ entry: String) throws -> CMUdictEntry {
  let components = entry.split(separator: " ")

  let name = components[0].split(separator: "(")[0]

  // we remove the name and the possible comment
  // aalborg AO1 L B AO0 R G # place, danish
  let stringPhones = components.dropFirst().prefix { !$0.contains("#") }

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
