public func processText(_ text: String) async -> Document {
  var lines: [TextLine] = []

  text.enumerateLines { line, _ in
    let textLine = processLine(line)
    lines.append(textLine)
  }

  return Document(lines: lines)
}

func processLine(_ line: String) -> TextLine {
  let components = ProcessLine(line).getComponents()
  return TextLine(components: components)
}
