import std/lists
import std/strutils
import strformat
import ./tokens

var tabAmmount = 0;

proc isValidVarName(name:string):bool =
    var allowedChars:seq[char] = @['a', 'b', 'c', 'd'];
    for chara in name:
        if chara in allowedChars == false:
            echo fmt"Illegal char in variable {name}";
            quit(1);
    
    return true;
    

proc parseFile*(path:string):SinglyLinkedList[Token] =
    var contents:string;   
    var return_list:SinglyLinkedList[Token];
    try:
        contents = readFile(path);
    except:
        echo fmt"Can't open/find file: {path}";
        quit(1);

    var splitted = split(contents, ";");
    var toItarate:seq[string];
    
    for line in splitted: # I have to do it, otherwise it never picks up anything besides the first line of the file when We actually want to parse it.
        var varnewLine = strip(line);
        toItarate.add(varnewLine);

    var finalSeq:seq[string];
    for line in toItarate:
        for line2 in split(line):
            finalSeq.add(line2);


    var index:int = 0;
    var validString:int = 0;
    var again:int = 0;
    var tmp_string = "";
    var endd:bool = false 
    for keyword in finalSeq:
        if keyword == "mutable":
            var var_type = "";
            if isValidVarName(finalSeq[index + 1]) == false:
                echo fmt"Variable name expected! but got {finalSeq[index + 1]}";
                quit(1);
            if finalSeq[index + 3] == "Text":
                var_type = "string";
            else:
                echo fmt"Unknown variable type {finalSeq[index + 3]}";
                quit(1);
            if finalSeq[index + 4] != ":-":
                echo fmt"Variables have to be initialised on declaration, but variable {finalSeq[index + 1]} wasn't";
                quit(1);
            while validString != 2:
                for chara in finalSeq[(index + 5) + again]:
                    if chara == '\"':
                        validString = validString + 1;
                    if chara != '\"':
                        tmp_string.add(chara);
                again = again + 1;
            return_list.add(Token(name:TokenType.MUTABLE_VARIABLE_DECLARATION, var_name:finalSeq[index + 1], value:tmp_string, var_type:var_type));
        if keyword == "<-":
            if startsWith(finalSeq[index + 1], "(") == false:
                echo fmt"Arguments for function {finalSeq[index - 1]} expected.";
                quit(1);
            again = 0;
            tmp_string = "";
            var functionName = finalSeq[index - 1];
            while endd == false:
                for chara in finalSeq[(index + 1) + again]:
                    tmp_string.add(chara);
                    if chara == ')':
                        endd = true;
                again = again + 1;
            return_list.add(Token(name:TokenType.FUNCTION_CALL, var_name:functionName, arguments:tmp_string));
        index = index + 1;
    return return_list;