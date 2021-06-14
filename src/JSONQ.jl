module JSONQ

using JSON3

const validator = r"^[\.\[\]a-zA-Z0-9]+$"

"""
    Ctx()

Holds validated and compiled JSON query expressions.
"""
struct Ctx
    compiled::Dict{String,Function}
    function Ctx()
        new(Dict{String,Function}())
    end
end

"""
    compile(ctx, expression_string; name=expression_string)

Compiles and adds a query to the context. The query can optionally be
given a short name to be used to refer subsequently (defaults to the
query representation string itself).

Query expression can contain a path represented in dotted notation
comprising of keys or array indices in the JSON dict. E.g.: `data[10].name`.
"""
function compile(ctx::Ctx, expression_string::AbstractString; name::AbstractString=expression_string)
    if match(validator, expression_string) === nothing
        throw(ArgumentError("Invalid query expression"))
    end

    f = Meta.parse("(x)->x" * expression_string)
    ctx.compiled[expression_string] = eval(f)
    nothing
end

"""
    execute(ctx, json, expression_string)

Execute a compiled query against provided json (which must be in a JSON3 representation) as input.

- `json`: A JSON3 Object or Array to run this against
- `name`: Name of the compiled query
"""
function execute(ctx::Ctx, json::Union{JSON3.Object,JSON3.Array}, name::AbstractString)
    compiled_expression = ctx.compiled[name]
    _execute(json, compiled_expression)
end

_execute(json::Union{JSON3.Object,JSON3.Array}, compiled_expression::Function) = compiled_expression(json)

end # module
