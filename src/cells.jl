import Base: getindex
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

function getindex{T<:Real}(cell::SpiceCell{T}, ind)
    return cell.data[CTRLSZ + ind]
end

typealias SpiceCharCell SpiceCell{SpiceChar,2}
typealias SpiceDoubleCell SpiceCell{SpiceDouble,1}
typealias SpiceIntCell SpiceCell{SpiceInt,1}

function SpiceIntCell(size)
    strc = Cell{SpiceInt}(0, size)
    self = SpiceCell(Vector{SpiceInt}(CTRLSZ + size), strc)
    base = pointer(self.data, 1)
    data = pointer(self.data, CTRLSZ + 1)
    self.cell.base = base
    self.cell.data = data
    return self
end

function SpiceDoubleCell(size)
    strc = Cell{SpiceDouble}(0, size)
    self = SpiceCell(Vector{SpiceDouble}(CTRLSZ + size), strc)
    base = pointer(self.data, 1)
    data = pointer(self.data, CTRLSZ + 1)
    self.cell.base = base
    self.cell.data = data
    return self
end

appnd_fun(::Type{SpiceInt}) = :appndi_c
appnd_fun(::Type{SpiceDouble}) = :appndd_c
appnd_fun(::Type{SpiceChar}) = :appndc_c

function appnd{T}(item, cell::SpiceCell{T})
    c = Ref(cell.cell)
    ccall((appnd_fun(T), libcspice), Void, (T, Ref{Cell{T}}), item, cell.cell)
    handleerror()
    return nothing
end

