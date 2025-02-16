import Foundation

public func loadDictionary() async throws -> [String: [PhonesWord]] {
   let url = Bundle.module.url(forResource: "cmudict", withExtension: "dict")
//  let url = Bundle.module.url(forResource: "dev.cmudict", withExtension: "dict")

  guard let url else {
    throw RuntimeError("Could not find dict file")
  }

  let content = try String(contentsOf: url, encoding: .utf8)

  var dictionary: [String: [PhonesWord]] = [:]

  var processError: Error?

  content.enumerateLines { line, shouldStop in
    do {
      let result = try processCMUdictEntry(line)
      if dictionary[result.name] == nil {
        dictionary[result.name] = []
      }
      dictionary[result.name]!.append(PhonesWord(phones: result.phones))
    } catch {
      // This closure can't throw an error
      shouldStop = true
      processError = error
    }
  }

  if let processError {
    throw processError
  }

  return dictionary
}

func processCMUdictEntry(_ entry: String) throws -> CMUdictEntry {
  let components = entry.split(separator: " ")

  let name = components[0].split(separator: "(")[0]

  let stringPhones = components.dropFirst()
  let phones = try stringPhones.map(phoneStringToPhone)

  return CMUdictEntry(name: String(name), phones: phones)
}

func phoneStringToPhone(phone: Substring) throws -> Phone {
  // ARPAbet have a max of 2-letter elements
  // then an stress or auxiliary symbol

  let corePhone = phone.prefix(2)

  guard phone.count > 2 else {
    return Phone(core: String(corePhone), stress: nil)
  }

  let stress = phone.suffix(from: phone.index(phone.startIndex, offsetBy: 2))

  return Phone(core: String(corePhone), stress: String(stress))
}
