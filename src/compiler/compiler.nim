import std/lists
import os
import std/strutils
import std/sequtils
import strformat
import osproc
import ../parser/tokens
import ./standardFunctions

var OUTPUT_FILE:string = paramStr(1);
var OUTPUT_CODE:string;

var hhgh = split(OUTPUT_FILE, '/');
OUTPUT_FILE = hhgh[hhgh.len() - 2] & "/program.nim";


proc compile*(tokens:SinglyLinkedList[Token]):void =
    var index:int = 0;
    for token in tokens:
        if token.name == TokenType.MUTABLE_VARIABLE_DECLARATION:
            if tokens.toSeq[index + 2].var_type == "string": #If the variable is a string.
                OUTPUT_CODE.add(fmt"var {tokens.toSeq[index + 1].var_name}:{tokens.toSeq[index + 2].var_type} = ""{tokens.toSeq[index + 3].string_iteral}"";{'\n'}");
        if token.name == TokenType.FUNCTION_CALL:
            echo fmt"function {tokens.toSeq[index].var_name} called with {tokens.toSeq[index].arguments}";
            OUTPUT_CODE.add(functionCallToStd(tokens.toSeq[index].var_name, tokens.toSeq[index].arguments));
        index = index + 1;
    echo OUTPUT_CODE;
    writeFile(OUTPUT_FILE, OUTPUT_CODE);
    discard execCmd(fmt"nim c {OUTPUT_FILE}");
    
