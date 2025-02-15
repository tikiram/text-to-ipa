import Testing

@testable import TextToIPA

@Test func example() async throws {

  let dictionary = try await loadDictionary()

  print(try dictionary["about"]!.first!.toIPA())

  //  let textToIpa = TextToIPA()
  //  try textToIpa.something()

  //  let a = try processCMUdictEntry("water W AO1 T ER0").toIPA()
  //  let b = try processCMUdictEntry("weird W IH1 R D").toIPA()
  //  let c = try processCMUdictEntry("about AH0 B AW1 T").toIPA()
  //  let d = try processCMUdictEntry("episode EH1 P AH0 S OW2 D").toIPA()
  //  let e = try processCMUdictEntry("episode(2) EH1 P IH0 S OW2 D").toIPA()
  //  let f = try processCMUdictEntry("awful AA1 F AH0 L").toIPA()
  //  let g = try processCMUdictEntry("awful(2) AO1 F AH0 L").toIPA()
  //  print(a)
  //  print(b)
  //  print(c)
  //  print(d)
  //  print(e)
  //  print(f)
  //  print(g)

}

@Test func example2() async throws {

  let text = """
    This is some text...

    over multiple lines
    """

  let document = await processText(text)

  print(document)
}


@Test func example3() async throws {

  let text = """
    This is some text...

    over multiple lines
    """

  let document = await processText(text)
  
  let dictionary = try await loadDictionary()
  let transcriber = Transcriber(dictionary)
  
  let transcriptionDocument = try await document.transcribe(transcriber)

  transcriptionDocument.printFullString()
}


