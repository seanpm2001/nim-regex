import os
import std/[times, monotimes, stats]
from regex import nil

proc measureNimRegex(data: string) =
  var r: RunningStat
  var matches: int
  #const patternRe = regex.re"[\w\.+-]+@[\w\.-]+\.[\w\.-]+"
  const patternRe = regex.re"(?-U)[\w]+://[^/\s?#]+[^\s?#]+(?:\?[^\s#]*)?(?:#[^\s]*)?"
  for i in 1..3:
    matches = 0
    for _ in regex.findAll(data, patternRe):
      inc matches
  #echo matches
  doAssert matches == 5301 #92

proc main() =
  const data = staticRead("/home/esteban/AtomProjects/nim-regex/bench/input-text.txt")
  let emailStr = r"[\w\.+-]+@[\w\.-]+\.[\w\.-]+"
  let URIStr = r"[\w]+://[^/\s?#]+[^\s?#]+(?:\?[^\s#]*)?(?:#[^\s]*)?"
  let IPStr = r"(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9])\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9])"


  measureNimRegex(data)

  # Email
  #measureNimRegex(data, emailStr)
  # URI
  #measureNimRegex(data, URIStr)
  # IP
  #measureNimRegex(data, IPStr)

when isMainModule:
  main()
