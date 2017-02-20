import Base: getindex, endof, push!, append!, show
export SpiceIntCell, SpiceDoubleCell, SpiceCharCell, appnd, push!, append!, card

const CTRLSZ = 6

dtype(::Type{SpiceChar}) = 0
dtype(::Type{SpiceDouble}) = 1
dtype(::Type{SpiceInt}) = 2

type Cell{T}
    dtype::SpiceInt
    length::SpiceInt
    size::SpiceInt
    card::SpiceInt
    isset::SpiceInt
    adjust::SpiceInt
    init::SpiceInt
    base::Ptr{Void}
    data::Ptr{Void}
    function Cell(length, size)
        new(dtype(T), length, size, 0, 1, 0, 0)
    end
end

type SpiceCell{T,N}
    data::Array{T,N}
    cell::Cell{T}
end

typealias SpiceCharCell SpiceCell{SpiceChar,2}
typealias SpiceDoubleCell SpiceCell{SpiceDouble,1}
typealias SpiceIntCell SpiceCell{SpiceInt,1}

endof(cell::SpiceCell) = cell.cell.card
show{T}(io::IO, cell::SpiceCell{T,1}) = print(io, "SpiceCell{$(T.name.name)}($(cell.cell.size))")
show{T}(io::IO, cell::SpiceCell{T,2}) = print(io, "SpiceCell{$(T.name.name)}($(cell.cell.size),$(cell.cell.length))")

function check_ind(cell, inds)
    ind = collect(inds)[end]
    if ind > cell.cell.size
        error("Index $ind is out of bounds. The size of this SpiceCell is $(cell.cell.size).")
    elseif ind > cell.cell.card
        error("The element at index $ind is unassigned.")
    end
end

function getindex{T<:Real}(cell::SpiceCell{T}, ind)
    check_ind(cell, ind)
    return cell.data[CTRLSZ + ind]
end

function getindex(cell::SpiceCharCell, ind::Int)
    check_ind(cell, ind)
    str = cell.data[:, CTRLSZ + ind]
    return String(str[1:findfirst(str .== 0)-1])
end

function getindex(cell::SpiceCharCell, ind)
    check_ind(cell, ind)
    str = cell.data[:, CTRLSZ + ind]
    return vec(mapslices(x -> String(x[1:findfirst(x .== 0)-1]), str, 1))
end

function SpiceCell{SpiceChar}(::Type{SpiceChar}, size, length)
    # We add an extra element for the null-byte terminator.
    nlength = length + 1
    strc = Cell{SpiceChar}(nlength, size)
    data = fill(UInt8(0), (nlength, CTRLSZ + size))
    self = SpiceCell(data, strc)
    base = pointer(self.data, 1)
    data = pointer(self.data, CTRLSZ * nlength + 1)
    self.cell.base = base
    self.cell.data = data
    return self
end

"""
    SpiceCharCell(size, length)

Create a SpiceCharCell that can contain up to `size` strings with `length` characters.
"""
SpiceCharCell(size::Int, length::Int) = SpiceCell(SpiceChar, size, length)

function SpiceCell{T<:Real}(::Type{T}, size)
    strc = Cell{T}(0, size)
    data = Vector{T}(CTRLSZ + size)
    self = SpiceCell(data, strc)
    base = pointer(self.data, 1)
    data = pointer(self.data, CTRLSZ + 1)
    self.cell.base = base
    self.cell.data = data
    return self
end

"""
    SpiceDoubleCell(size)

Create a SpiceDoubleCell that can contain up to `size` elements.
"""
SpiceDoubleCell(size) = SpiceCell(SpiceDouble, size)

"""
    SpiceIntCell(size)

Create a SpiceIntCell that can contain up to `size` elements.
"""
SpiceIntCell(size) = SpiceCell(SpiceInt, size)

for (t, f) in zip((SpiceInt, SpiceDouble), ("appndi_c", "appndd_c"))
    @eval begin
        function appnd(item, cell::SpiceCell{$t})
            c = Ref(cell.cell)
            ccall(($f, libcspice), Void, ($t, Ref{Cell{$t}}), item, cell.cell)
            handleerror()
            return nothing
        end
    end
end

"""
    appnd(item, cell)

Append an `item` to the char/double/integer SpiceCell `cell`.

[https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/appndc_c.html](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/appndc_c.html)
[https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/appndd_c.html](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/appndd_c.html)
[https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/appndi_c.html](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/appndi_c.html)
"""
function appnd(item, cell::SpiceCell{SpiceChar})
    c = Ref(cell.cell)
    ccall((:appndc_c, libcspice), Void, (Cstring, Ref{Cell{SpiceChar}}), item, cell.cell)
    handleerror()
    return nothing
end

"""
    push!(cell, items...)

Insert one or more `items` at the end of the char/double/integer SpiceCell `cell`.
"""
push!(cell::SpiceCell, items...) = foreach(x -> appnd(x, cell), items)

"""
    append!(cell, collection)

Append all items from `collection` to the char/double/integer SpiceCell `cell`.
"""
append!(cell::SpiceCell, collection) = foreach(x -> appnd(x, cell), collection)

"""
    card(cell)

Returns the cardinality (number of elements) of a SpiceCell `cell`.
"""
card(cell::SpiceCell) = Int(cell.cell.card)