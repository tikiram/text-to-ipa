public func processText(_ text: String) async -> [TextLine] {
  var lines: [TextLine] = []

  text.enumerateLines { line, _ in
    let textLine = processLine(line)
    lines.append(textLine)
  }

  return lines
}

func processLine(_ line: String) -> TextLine {
  let components = ProcessLine(line).getComponents()
  return TextLine(components: components)
}
