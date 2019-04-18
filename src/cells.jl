import Base: getindex, push!, append!, show, length, size
export SpiceIntCell, SpiceDoubleCell, SpiceCharCell, appnd, push!, append!, card, length, copy, size_c

const CTRLSZ = 6

dtype(::Type{SpiceChar}) = 0
dtype(::Type{SpiceDouble}) = 1
dtype(::Type{SpiceInt}) = 2

mutable struct Cell{T}
    # Do not reorder these fields
    dtype::SpiceInt
    length::SpiceInt
    size::SpiceInt
    card::SpiceInt
    isset::SpiceInt
    adjust::SpiceInt
    init::SpiceInt
    base::Ptr{Cvoid}
    data::Ptr{Cvoid}
    function Cell{T}(length, size) where T
        new{T}(dtype(T), length, size, 0, 1, 0, 0)
    end
end

itertype(::Type{T}) where {T} = T
itertype(::Type{SpiceChar}) = String

init_data(::Type{T}, size, _) where {T} = Array{T}(undef, CTRLSZ + size)
init_data(::Type{SpiceChar}, size, length) = fill(SpiceChar(0), (length, CTRLSZ + size))

len(::Type{T}, _) where {T} = 0
len(::Type{SpiceChar}, length) = length += 1

dim(::Type{T}) where {T} = 1
dim(::Type{SpiceChar}) = 2

data_ptr(::Type{SpiceChar}, data, length) = GC.@preserve data pointer(data, CTRLSZ * length + 1)
data_ptr(::Type{T}, data, _) where {T} = GC.@preserve data pointer(data, CTRLSZ + 1)

mutable struct SpiceCell{S, T, N} <: AbstractArray{T, 1}
    data::Array{S, N}
    cell::Cell{S}

    function SpiceCell{T}(size::Integer, length::Integer=256) where T
        length = len(T, length)
        cell = Cell{T}(length, size)
        data = init_data(T, size, length)
        self = new{T, itertype(T), dim(T)}(data, cell)
        self.cell.base = GC.@preserve self pointer(self.data, 1)
        self.cell.data = data_ptr(T, self.data, length)
        self
    end
end

const SpiceDoubleCell = SpiceCell{SpiceDouble}
const SpiceIntCell = SpiceCell{SpiceInt}
const SpiceCharCell = SpiceCell{SpiceChar}

Base.IndexStyle(::SpiceCell) = IndexLinear()
Base.firstindex(cell::SpiceCell) = 1
Base.lastindex(cell::SpiceCell) = cell.cell.card

"""
    SpiceCharCell(size, length)

Create a SpiceCharCell that can contain up to `size` strings with `length` characters.
"""
SpiceCharCell

function show(io::IO, cell::SpiceCell{T}) where T
    print(io, "SpiceCell{$(T.name.name)}($(cell.cell.size))")
end
function show(io::IO, cell::SpiceCharCell)
    print(io, "SpiceCell{SpiceChar}($(cell.cell.size),$(cell.cell.length))")
end

function check_ind(cell, inds)
    ind = collect(inds)[end]
    if ind > cell.cell.size
        error("Index $ind is out of bounds. The size of this SpiceCell is $(cell.cell.size).")
    elseif ind > cell.cell.card
        error("The element at index $ind is unassigned.")
    end
end

function getindex(cell::SpiceCell, ind::Int)
    check_ind(cell, ind)
    cell.data[CTRLSZ .+ ind]
end

function getindex(cell::SpiceCharCell, ind::Int)
    check_ind(cell, ind)
    str = cell.data[:, CTRLSZ .+ ind]
    chararray_to_string(str)
end

"""
    SpiceDoubleCell(size)

Create a SpiceDoubleCell that can contain up to `size` elements.
"""
SpiceDoubleCell

"""
    SpiceIntCell(size)

Create a SpiceIntCell that can contain up to `size` elements.
"""
SpiceIntCell

for (t, f) in zip((SpiceInt, SpiceDouble), ("appndi_c", "appndd_c"))
    @eval begin
        function appnd(item, cell::SpiceCell{$t, $t})
            c = Ref(cell.cell)
            ccall(($f, libcspice), Cvoid, ($t, Ref{Cell{$t}}), item, cell.cell)
            handleerror()
            return nothing
        end
    end
end

"""
    appnd(item, cell)

Append an `item` to the char/double/integer SpiceCell `cell`.

### References ###

- [appndc - NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/appndc_c.html)
- [appndd - NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/appndd_c.html)
- [appndi - NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/appndi_c.html)
"""
function appnd(item, cell::SpiceCharCell)
    ccall((:appndc_c, libcspice), Cvoid, (Cstring, Ref{Cell{SpiceChar}}), item, cell.cell)
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

Returns the cardinality (number of elements) of `cell`.
"""
card(cell::SpiceCell) = Int(cell.cell.card)

"""
    length(cell)

Returns the cardinality (number of elements) of `cell`.
"""
length(cell::SpiceCell) = card(cell)

"""
    size(cell)

Returns the cardinality (number of elements) of `cell`.
"""
size(cell::SpiceCell) = (card(cell),)

"""
    copy(cell::SpiceCell)

Duplicate the SpiceCell `cell`.
"""
function Base.copy(cell::SpiceCell{T}) where {T}
    cell_copy = deepcopy(cell)
    cell_copy.cell.base = GC.@preserve cell_copy pointer(cell_copy.data, 1)
    cell_copy.cell.data = data_ptr(T, cell_copy.data, length)
    cell_copy
end

"""
    size_c(cell::SpiceCell)

Returns the maximum number of elements that `cell` can hold.
"""
size_c(cell) = cell.cell.size

