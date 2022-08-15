import strformat
import std/strutils

proc functionCallToStd*(functionName:string, args:string):string =
    if functionName == "PutLine":
        var args2 = args.replace("(", "(@");
        return fmt"PutLine {args2};";
    else: #If it's not on the list, it's a user defined function.
        return functionName & args & ";";
