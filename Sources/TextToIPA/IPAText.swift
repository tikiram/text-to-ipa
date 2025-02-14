class IPAText {
  private let phones: [Phone]
  init(_ phones: [Phone]) {
    self.phones = phones
  }

  func getComponents() throws -> [String] {
    var ipas: [String] = []

    for (index, phone) in phones.enumerated() {

      let stressMark = try phone.getStressMark()
      if let stressMark {
        let offset = try getStressOffset(currentIndex: index)
        ipas.insert(stressMark, at: ipas.count - offset)
      }
      ipas.append(try phone.getIpa())
    }
    return ipas
  }
  func toString() throws -> String {
    return try getComponents().joined()
  }

  private func getStressOffset(currentIndex index: Int) throws -> Int {
    return try isPreviousPhoneConsonant(currentIndex: index) ? 1 : 0
  }

  private func isPreviousPhoneConsonant(currentIndex index: Int) throws -> Bool {
    let previousPhone = index == 0 ? nil : phones[index - 1]
    return try previousPhone?.isConsonant() == true
  }

}
