import strformat

proc functionCallToStd*(functionName:string, args:string):string =
    if functionName == "PutLine":
        var a:string = "sadfsf";
        echo "Strinis", a;
        return fmt"echo {args}";
    else: #If it's not on the list, it's a user defined function.
        return functionName & "<-" & "(" & args & ")";
