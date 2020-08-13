import os
import std/[times, monotimes, stats]
from regex import nil
from std/re import nil

proc measureNimRegex(data, pattern: string) =
  var r: RunningStat
  var matches: int
  let patternRe = regex.re(pattern)
  for i in 1..3:
    matches = 0
    let start = getMonoTime()
    for _ in regex.findAll(data, patternRe):
      inc matches
    r.push float((getMonoTime() - start).inMilliseconds)
  echo "nim-regex: ", r.mean, " - " , matches

proc measureRe(data, pattern: string) =
  var r: RunningStat
  var matches: int
  let patternRe = re.re(pattern)
  for i in 1..3:
    matches = 0
    let start = getMonoTime()
    for _ in re.findAll(data, patternRe):
      inc matches
    r.push float((getMonoTime() - start).inMilliseconds)
  echo "std/re: ", r.mean, " - " , matches


proc main() =
  when declared(paramStr):
    if paramCount() != 1:
      echo "Usage: ./benchmark [filename]"
      return
    let file = open(paramStr(1))
    defer: close(file)
    let data = file.readAll()
    let emailStr = r"[\w\.+-]+@[\w\.-]+\.[\w\.-]+"
    let URIStr = r"(?-U)[\w]+://[^/\s?#]+[^\s?#]+(?:\?[^\s#]*)?(?:#[^\s]*)?"
    let IPStr = r"(?-U)(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9])\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9])"

    # Email
    measureRe(data, emailStr)
    # URI
    measureRe(data, URIStr)
    # IP
    measureRe(data, IPStr)

    # Email
    measureNimRegex(data, emailStr)
    # URI
    measureNimRegex(data, URIStr)
    # IP
    measureNimRegex(data, IPStr)

when isMainModule:
  main()
