import Testing

@testable import TextToIPA

// @Test func example() async throws {

//   let dictionary = try await loadDictionary()

//   print(try dictionary["about"]!.first!.toIPA())

//   //  let textToIpa = TextToIPA()
//   //  try textToIpa.something()

//   //  let a = try processCMUdictEntry("water W AO1 T ER0").toIPA()
//   //  let b = try processCMUdictEntry("weird W IH1 R D").toIPA()
//   //  let c = try processCMUdictEntry("about AH0 B AW1 T").toIPA()
//   //  let d = try processCMUdictEntry("episode EH1 P AH0 S OW2 D").toIPA()
//   //  let e = try processCMUdictEntry("episode(2) EH1 P IH0 S OW2 D").toIPA()
//   //  let f = try processCMUdictEntry("awful AA1 F AH0 L").toIPA()
//   //  let g = try processCMUdictEntry("awful(2) AO1 F AH0 L").toIPA()
//   //  print(a)
//   //  print(b)
//   //  print(c)
//   //  print(d)
//   //  print(e)
//   //  print(f)
//   //  print(g)

// }

// @Test func example2() async throws {

//   let text = """
//     This is some text...

//     over multiple lines
//     """

//   let document = await processText(text)

//   print(document)
// }

// @Test func example4() async throws {

//   let alphabet = try await getAlphabetDictionary()

//   print(alphabet)
// }

@Test func example6() async throws {

  let text = """
    One day I stumbled on a twitter post said that you need to expose yourself with everything. That post slapped my face so hard. I felt stupid, like I’ve been doing wrong to myself.

    And here’s what I thought about throughout that day:

    Holding back because you want something to be perfect from the start? You know that’s wrong. Every “first” is always bad. But don’t be foolish enough to stop yourself from trying.

    Forget perfection. This isn’t an exam — it’s life. Making mistakes is a natural, everyday thing. Don’t exaggerate it. The times we get it right are often because we’ve already made mistakes or learned from someone who has.

    Listen to your heart. If you really want something, if you’re genuinely drawn to it, get obsessed. Greatness is built on a foundation of countless mistakes. It doesn’t magically show up.

    Will it scare you? YES. But if it scares you, it might be worth trying. By nature, we need stability. We want to survive, to avoid risks that could harm us. But it’s those who take risks who break through the barriers others can’t.

    If you fail, will it be embarrassing? YES. So what?

    Would you rather be embarrassed now or later? Embrace that first embarrassed failure like a victory; feel it as a winning step.

    The only person who never makes mistakes is the one who never does anything.

    So go out there. Do something great. Face everything like a winner. Expose yourself like a king — bold and unafraid.
    """

  let transcriber = try await loadTranscriber()

  let results = try transcriber.parse(text)

  print(results)
}


@Test func example7() async throws {

  let text = """
    I want water
    """

  let transcriber = try await loadTranscriber()

  let results = try transcriber.parse(text)

  print(results)
}

// @Test func example7() async throws {

//   let text = """
//     classes
//     """

//   let ipaLoader = IPALoader()
//   let transcriber = try await ipaLoader.load()

//   let document = try await transcriber.parse(text)

//   document.printFullString()
// }

@Test func example1() async throws {

  let text = """
    I want water
    """

  let textTree = text.toEnglishTextTree()

  print(textTree.toString())

  // assert(!textTree.toString().contains("\n"), "Result should not contain newlines")

}
