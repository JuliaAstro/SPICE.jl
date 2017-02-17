import Base: getindex, endof
export SpiceIntCell, SpiceDoubleCell, SpiceCharCell, appnd

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

function check_ind(cell, inds)
    ind = collect(inds)[end]
    if ind > cell.cell.size
        error("Index $ind is out of bounds. The size of this cell is $(cell.cell.size).")
    elseif ind > cell.cell.card
        error("The element at index $ind is unassigned.")
    end
end

function getindex(cell::SpiceCell, ind)
    check_ind(cell, ind)
    getindex(cell, ind)
end

function getindex{T<:Real}(cell::SpiceCell{T}, ind)
    return cell.data[CTRLSZ + ind]
end

function getindex(cell::SpiceCharCell, ind::Int)
    str = cell.data[:, CTRLSZ + ind]
    return String(str[1:findfirst(str .== 0)-1])
end

function getindex(cell::SpiceCharCell, ind)
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
SpiceDoubleCell(size) = SpiceCell(SpiceDouble, size)
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
function appnd(item, cell::SpiceCell{SpiceChar})
    c = Ref(cell.cell)
    ccall((:appndc_c, libcspice), Void, (Cstring, Ref{Cell{SpiceChar}}), item, cell.cell)
    handleerror()
    return nothing
end

