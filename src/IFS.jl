export IFS, Sierpinski

"""
`IFS` is an iterated function system.
"""
immutable IFS
  funcs::Vector{AffineMap}
end

function IFS(args...)
  fun_list = [ f for f in args ]
  IFS(fun_list)
end

# Apply F to a single vector
function (F::IFS)(x::Vector)
  y = [ f(x) for f in F.funcs ]
  return Set(y)
end

# Apply F to a list of vectors
function (F::IFS)(xlist::Set)
  A = Set{Vector{Float64}}()
  for x in xlist
    A = union(A,F(x))
  end
  return A
end

function show(io::IO,F::IFS)
  nf = size(F.funcs)[1]
  for k=1:nf
    println(io,"#$k:\t$(F.funcs[k])")
  end
end

"""
`square_check(F)` checks if all functions `f` in the `IFS` pass
`square_check(f)`.
"""
function square_check(F::IFS)
  return all(square_check(f) for f in F.funcs)
end


"""
`Sierpinski()` returns an `IFS` that creates a Sierpinski triangle.
"""
function Sierpinski()
  A = 0.5 * eye(2)
  f1 = AffineMap(A,[0,0])
  f2 = AffineMap(A,[0.5,0])
  f3 = AffineMap(A,[0.25,0.5])
  return IFS(f1,f2,f3)
end
