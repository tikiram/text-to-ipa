func processText(_ text: String) async -> Document {
  var lines: [TextLine2] = []

  text.enumerateLines { line, _ in
    let textLine = processLine(line)
    lines.append(textLine)
  }

  return Document(lines: lines)
}

func processLine(_ line: String) -> TextLine2 {
  let components = ProcessLine(line).getComponents()
  return TextLine2(components: components)
}
