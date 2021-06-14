# JSONQ.jl

[![Build Status](https://github.com/tanmaykm/JSONQ.jl/workflows/CI/badge.svg)](https://github.com/tanmaykm/JSONQ.jl/actions?query=workflow%3ACI+branch%3Amain)
[![codecov.io](http://codecov.io/github/tanmaykm/JSONQ.jl/coverage.svg?branch=main)](http://codecov.io/github/tanmaykm/JSONQ.jl?branch=main)

Simple JSON path query in Julia.
Built upon the Julia [JSON3](https://github.com/quinnj/JSON3.jl) package.

The `JSONQ.Ctx` holds validated and compiled JSON query expressions.

The `JSONQ.compile` method compiles and adds a query to a `Ctx`.
The query can optionally be given a short name to be used to refer subsequently
(defaults to the query representation string itself).

`compile(ctx, expression_string; name=expression_string)`

Query expression can contain a path represented in dotted notation
comprising of keys or array indices in the JSON dict. E.g.: `data[10].name`.

The `JSONQ.execute` method executes a compiled query against provided input json.
The input must be in a JSON3 representation.

`execute(ctx, json, expression_string)`

Where:
- `json`: A JSON3 Object or Array to run this against
- `name`: Name of the compiled query
