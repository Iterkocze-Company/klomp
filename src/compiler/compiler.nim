import std/lists
import os
import std/strutils
import std/sequtils
import strformat
import osproc
import ../parser/tokens
import ./standardFunctions
import ../options

var OUTPUT_FILE:string;
var OUTPUT_CODE:string;

proc prepareFiles():void =
    OUTPUT_FILE = paramStr(1);
    var hhgh = split(OUTPUT_FILE, '/');
    OUTPUT_FILE = hhgh[hhgh.len() - 2] & "/program.nim";


proc compile*(tokens:SinglyLinkedList[Token]):void =
    prepareFiles();
    OUTPUT_CODE.add("import klompstd\n");
    var index:int = 0;
    for token in tokens:
        if token.name == TokenType.MUTABLE_VARIABLE_DECLARATION:
            if tokens.toSeq[index].var_type == "string": #If the variable is a string.
                OUTPUT_CODE.add(fmt"var {tokens.toSeq[index].var_name}:{tokens.toSeq[index].var_type} = ""{tokens.toSeq[index].value}"";{'\n'}");

        if token.name == TokenType.FUNCTION_CALL:
            OUTPUT_CODE.add(functionCallToStd(tokens.toSeq[index].var_name, tokens.toSeq[index].arguments));
        index = index + 1;
    echo OUTPUT_CODE;
    writeFile(OUTPUT_FILE, OUTPUT_CODE);
    if GENERATE_FLAG == false:
        discard execCmd(fmt"nim c {OUTPUT_FILE}");
    
