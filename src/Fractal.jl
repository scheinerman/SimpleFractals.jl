export Fractal, Triangle, Carpet
"""
A `Fractal` contains an `IFS` (iterated function system) and a
`PixelPicture` (bitmap image) that the `IFS` generates.

Standard constructors:
* `Fractal(F::IFS,P::PixelPicture)`
* `Fractal(F::IFS,n::Int)`
"""
type Fractal
  F::IFS
  P::PixelPicture
  function Fractal(FF::IFS,PP::PixelPicture)
    new(FF,PP)
  end
end

function Fractal(F::IFS, n::Int)
  @assert n>0
  P = PixelPicture(n)
  return Fractal(F,n)
end

draw(F::Fractal) = draw(F.P)
size(F::Fractal) = size(F.P)



function show(io::IO,FF::Fractal)
  n = size(FF)
  println(io,"$n-by-$n fractal image with this iterated function system:")
  show(io,FF.F)
end



randomize!(FF::Fractal) = randomize!(FF.P)

export step!

"""
`step!(FR)` applies a fractal's IFS to its image returning `true`
if there has been a change and `false` if no change.
"""
function step!(FR::Fractal)
  n = size(FR.P)
  pts = get_points(FR.P)
  newP = PixelPicture(n)
  for xy in pts
    for vv in FR.F(xy)
      set_point!(newP,vv)
    end
  end
  if FR.P.data != newP.data
    FR.P.data = newP.data
    return true
  end
  return false
end



"""
`Triangle(n)` set up `n`-by-`n` Triangle triangle.
"""
function Triangle(n::Int)
  F = Triangle_IFS()
  P = PixelPicture(n)
  FF = Fractal(F,P)

  return FF
end


"""
`Carpet(n)` set up an `n`-by-`n` Carpet gasket.
"""
function Carpet(n::Int)
  F = Carpet_IFS()
  P = PixelPicture(n)
  FF = Fractal(F,P)

  return FF
end


set_point!(F::Fractal,xy::Array{Float64,1})=set_point!(F.P,xy)

get_points(F::Fractal)=get_points(F.P)
