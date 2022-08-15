import os

var INPUT_FILE_PATH:string;

proc getOptions*():void =
    if paramCount() == 0:
        echo "You need to provide at least one argument! See -h for help";
        quit(1);
    for param in commandLineParams():
        if paramStr(1) == "-h":
          echo "USAGE klompcomp [PathToKlompSourceFile] [Flags...]";
          quit(0);