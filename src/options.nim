import os
import strformat

var GENERATE_FLAG*:bool = false;

proc getOptions*():void =
    if paramCount() == 0:
        echo "You need to provide at least one argument! See -h for help";
        quit(1);
    if fileExists(paramStr(1)) == false:
        echo fmt"File {paramStr(1)} does not exist! First argument needs to be the file or -h";
        quit(1);
    for param in commandLineParams():
        if param == "-h":
            echo "USAGE klompcomp [PathToKlompSourceFile] [Flags...]";
            echo "FLAGS";
            echo "-g | only generate code, don't compile"
            quit(0);
        if param == "-g":
            GENERATE_FLAG = true;
