import nimbench
import unicode
from re import nil
from regex import nil

func genText(): string {.compileTime.} =
  result = ""
  for _ in 0 .. 100000:
    result.add("a")
  result.add("sol")
  for _ in 0 .. 100000:
    result.add("b")
  #result.add("ฅ")
const text = genText()

var pattern2 = re.re"^\w*sol\w*$"

bench(re_sol, m):
  var d: bool
  for i in 0 ..< m:
    d = re.match(text, pattern2)
  doNotOptimizeAway(d)

const pattern4 = regex.re2(r"\w*sol\w*") #, {regex.RegexFlag.reAscii})

benchRelative(regex_sol, m):
  var m2: regex.RegexMatch2
  for i in 0 ..< m:
    discard regex.match(text, pattern4, m2)
  doNotOptimizeAway(m2)


bench(dummy, m):
  for i in 0 ..< m:
    memoryClobber()

when isMainModule:
  runBenchmarks()

#[
# Profiling:
# (but extract the bench to another module without nimbench)
# open the log with KCachegrind

$ nim c --debugger:native --threads:off -d:danger -d:useMalloc -o:bin/bench2 bench/bench2.nim && valgrind --tool=callgrind -v ./bin/bench2
]#
