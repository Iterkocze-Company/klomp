import os
import ./parser/parser
import ./compiler/compiler
import ./options

when isMainModule:
  echo("KlompComp 0.0.0.1");
  getOptions();
  compile(parseFile(paramStr(1)));