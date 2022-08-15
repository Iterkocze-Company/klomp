#type TokenType* = ref object of RootObj
    #name*:string

#type MutableVariableDeclarationToken1* = ref object of TokenType

#type MutableVariableDeclarationToken* = ref object of Token

type TokenType* = enum
    MUTABLE_VARIABLE_DECLARATION,
    FUNCTION_CALL,
    VAR_NAME,
    VAR_TYPE,
    STRING_ITERAL

type VariableType* = enum
    STRING

type Token* = ref object of RootObj
    name*:TokenType
    var_name*:string
    next_token*:TokenType
    var_type*:string
    value*:string
    arguments*:string