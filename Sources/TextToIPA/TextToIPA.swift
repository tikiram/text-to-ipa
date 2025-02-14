import Foundation

public class TextToIPA {
  func load() throws {

    // let url = Bundle.module.url(forResource: "cmudict", withExtension: "dict")
    let url = Bundle.module.url(forResource: "dev.cmudict", withExtension: "dict")

    guard let url else {
      throw RuntimeError("Could not find dict file")
    }

    let content = try String(contentsOf: url, encoding: .utf8)

    var dictionary = [String: String]()

    content.enumerateLines { line, _ in
      let parts = line.split(separator: " ").map(String.init)
      if parts.isEmpty {
        print("TODO")
      }
    }
  }

}

struct CMUdictEntry {
  let name: String
  let phones: [Phone]

  func toIPA() throws -> String {
    return try IPAText(phones).toString()
  }
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

func phoneToIPA(_ phone: Phone) throws -> String {

  guard let coreIpa = ipaEquivalent[phone.core] else {
    throw RuntimeError("No IPA equivalent for \(phone.core)")
  }

  guard let stress = phone.stress else {
    return coreIpa
  }

  guard let ipaStress = stressEquivalent[stress] else {
    throw RuntimeError("No stress equivalent for \(stress)")
  }

  return coreIpa + ipaStress
}

func ARPAbetToIPA(phone: Substring) throws -> String {
  // ARPAbet have a max of 2-letter elements
  // then an stress or auxiliary symbol

  let corePhone = phone.prefix(2)
  guard let coreIpa = ipaEquivalent[String(corePhone)] else {
    throw RuntimeError("No IPA equivalent for \(corePhone)")
  }

  guard phone.count > 2 else {
    return coreIpa
  }

  let stress = phone.suffix(from: phone.index(phone.startIndex, offsetBy: 2))

  guard let ipaStress = stressEquivalent[String(stress)] else {
    throw RuntimeError("No stress equivalent for \(stress)")
  }

  return coreIpa + ipaStress
}
