export
    wncard,
    wncomd,
    wncond,
    wncond!,
    wndifd,
    wnelmd,
    wnexpd,
    wnexpd!,
    wnextd,
    wnextd!,
    wnfetd,
    wnfild,
    wnfild!,
    wnfltd,
    wnfltd!,
    wnincd,
    wninsd,
    wninsd!,
    wnintd,
    wnreld,
    wnsumd,
    wnunid,
    wnvald,
    wnvald!

"""
    wncard(window)

Return the cardinality (number of intervals) of a double precision window.

### Arguments ###

- `window`: Input window

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/wncard_c.html)
"""
function wncard(window)
    ccall((:wncard_c, libcspice), SpiceInt, (Ref{Cell{SpiceDouble}},), window.cell)
end

"""
    wncomd(window, left, right)

Determine the complement of a double precision window with respect to a specified interval.

### Arguments ###

- `window`: Input window
- `left`:  Left endpoint of the complement interval
- `right`:  Right endpoint of the complement interval

### Output ###

Returns the complement of `window` with respect to `[left,right]`.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/wncomd_c.html)
"""
function wncomd(window, left, right)
    result = SpiceDoubleCell(window.cell.size + 1)
    ccall((:wncomd_c, libcspice), Cvoid,
          (SpiceDouble, SpiceDouble, Ref{Cell{SpiceDouble}}, Ref{Cell{SpiceDouble}}),
          left, right, window.cell, result.cell)
    handleerror()
    result
end

"""
    wncond!(window, left, right)

Contract each of the intervals of a double precision window.

### Arguments ###

- `window`: Window to be contracted
- `left`:  Amount added to each left endpoint
- `right`: Amount subtracted from each right endpoint

### Output ###

Returns the contracted window.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/wncond_c.html)
"""
function wncond!(window, left, right)
    ccall((:wncond_c, libcspice), Cvoid,
          (SpiceDouble, SpiceDouble, Ref{Cell{SpiceDouble}}),
          left, right, window.cell)
    handleerror()
    window
end

@deprecate wncond wncond!

"""
    wndifd(a, b)

Place the difference of two double precision windows into a third window.

### Arguments ###

- `a`: Input window
- `b`: Input window

### Output ###

Returns a window containing the difference of `a` and `b`.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/wndifd_c.html)
"""
function wndifd(a, b)
    c = SpiceDoubleCell(2 * (wncard(a) + wncard(b)))
    ccall((:wndifd_c, libcspice), Cvoid,
          (Ref{Cell{SpiceDouble}}, Ref{Cell{SpiceDouble}}, Ref{Cell{SpiceDouble}}),
          a.cell, b.cell, c.cell)
    handleerror()
    c
end

"""
    wnelmd(window, point)

Determine whether a point is an element of a double precision window.

### Arguments ###

- `window`: Input window
- `point`: Input point

### Output ###

Returns `true` if `point` is an element of `window`.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/wnelmd_c.html)
"""
function wnelmd(window, point)
    res = ccall((:wnelmd_c, libcspice), SpiceBoolean, (SpiceDouble, Ref{Cell{SpiceDouble}}),
                point, window.cell)
    handleerror()
    Bool(res)
end

"""
    wnexpd(window, left, right)

Expand each of the intervals of a double precision window.

### Arguments ###

- `left`: Amount subtracted from each left endpoint
- `right`: Amount added to each right endpoint

### Output ###

Returns the expanded window.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/wnexpd_c.html)
"""
function wnexpd!(window, left, right)
    ccall((:wnexpd_c, libcspice), Cvoid,
          (SpiceDouble, SpiceDouble, Ref{Cell{SpiceDouble}}),
          left, right, window.cell)
    handleerror()
    window
end

@deprecate wnexpd wnexpd!

"""
    wnextd!(window, side)

Extract the left or right endpoints from a double precision window.

### Arguments ###

- `window`: Window to be extracted
- `side`: Extract left (`:L`) or right (`:R`) endpoints

### Output ###

Returns the extracted window.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/wnextd_c.html)
"""
function wnextd!(window, side)
    ccall((:wnextd_c, libcspice), Cvoid, (SpiceChar, Ref{Cell{SpiceDouble}}),
          first(string(side)), window.cell)
    handleerror()
    window
end

@deprecate wnextd wnextd!

"""
    wnfetd(window, n)

Fetch a particular interval from a double precision window.

### Arguments ###

- `window`: Input window
- `n`: Index of interval to be fetched

### Output ###

Returns a tuple consisting of the left and right endpoints of the n-th interval
in the input window.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/wnfetd_c.html)
"""
function wnfetd(window, n)
    left = Ref{SpiceDouble}()
    right = Ref{SpiceDouble}()
    ccall((:wnfetd_c, libcspice), Cvoid,
          (Ref{Cell{SpiceDouble}}, SpiceInt, Ref{SpiceDouble}, Ref{SpiceDouble}),
          window.cell, n - 1, left, right)
    handleerror()
    left[], right[]
end

"""
    wnfild!(window, small)

Fill small gaps between adjacent intervals of a double precision window.

### Arguments ###

- `window`: Window to be filled
- `small`: Limiting measure of small gaps

### Output ###

Returns the updated window.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/wnfild_c.html)
"""
function wnfild!(window, small)
    ccall((:wnfild_c, libcspice), Cvoid, (SpiceDouble, Ref{Cell{SpiceDouble}}),
          small, window.cell)
    handleerror()
    window
end

"""
    wnfild!(window, small)

Filter (remove) small intervals from a double precision window.

### Arguments ###

- `window`: Window to be filtered
- `small`: Limiting measure of small intervals

### Output ###

Returns the updated window.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/wnfltd_c.html)
"""
function wnfltd!(window, small)
    ccall((:wnfltd_c, libcspice), Cvoid, (SpiceDouble, Ref{Cell{SpiceDouble}}),
          small, window.cell)
    handleerror()
    window
end

@deprecate wnfltd wnfltd!

"""
    wnincd(window, left, right)

Determine whether an interval is included in a double precision window.

### Arguments ###

- `window`: Input window
- `left`: Left endpoint of the input interval
- `right`: Right endpoint of the input interval

### Output ###

Returns `true` when `(left, right)` is contained in `window`.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/wnincd_c.html)
"""
function wnincd(window, left, right)
    res = ccall((:wnincd_c, libcspice), SpiceBoolean,
                (SpiceDouble, SpiceDouble, Ref{Cell{SpiceDouble}}),
                left, right, window.cell)
    handleerror()
    Bool(res)
end

"""
    wninsd!(window, left, right)

Insert an interval into a double precision window.

### Arguments ###

- `window`: Input window
- `left`: Left endpoint of the new interval
- `right`: Right endpoint of the new interval

### Output ###

Returns the updated windows.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/wninsd_c.html)
"""
function wninsd!(window, left, right)
    ccall((:wninsd_c, libcspice), Cvoid,
          (SpiceDouble, SpiceDouble, Ref{Cell{SpiceDouble}}),
          left, right, window.cell)
    handleerror()
    window
end

@deprecate wninsd wninsd!

"""
    wnintd(a, b)

Place the intersection of two double precision windows into a third window.

### Arguments ###

- `a`: Input window
- `b`: Input window

### Output ###

Returns a window containing the intersection of `a` and `b`.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/wnintd_c.html)
"""
function wnintd(a, b)
    c = SpiceDoubleCell(2 * (wncard(a) + wncard(b)))
    ccall((:wnintd_c, libcspice), Cvoid,
          (Ref{Cell{SpiceDouble}}, Ref{Cell{SpiceDouble}}, Ref{Cell{SpiceDouble}}),
          a.cell, b.cell, c.cell)
    handleerror()
    c
end

"""
    wnreld(a, op, b)

Compare two double precision windows.

!!! note

    Consider using overloaded operators instead, i.e. `a == b`, `a ⊆ b`, and `a ⊊ b`.

### Arguments ###

- `a`: First window
- `op`: Comparison operator
- `b`: Second window

### Output ###

Returns the result of comparison `a (op) b`.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/wnreld_c.html)
"""
function wnreld(a, op, b)
    if op == :(==)
        op = "="
    elseif op == :(!=)
        op = "<>"
    else
        op = string(op)
    end
    res = ccall((:wnreld_c, libcspice), SpiceBoolean,
                (Ref{Cell{SpiceDouble}}, Cstring, Ref{Cell{SpiceDouble}}),
                a.cell, op, b.cell)
    handleerror()
    Bool(res)
end

Base.:(==)(a::SpiceDoubleCell, b::SpiceDoubleCell) = wnreld(a, :(==), b)
Base.:(⊆)(a::SpiceDoubleCell, b::SpiceDoubleCell) = wnreld(a, :<=, b)
Base.:(⊊)(a::SpiceDoubleCell, b::SpiceDoubleCell) = wnreld(a, :<, b)

"""
    wnsumd(window)

Summarize the contents of a double precision window.

### Arguments ###

- `window`: Window to be summarized

### Output ###

Returns a tuple consisting of:

- `meas`: Total measure of intervals in window
- `avg`: Average measure
- `stddev`: Standard deviation
- `shortest`: Location of shortest interval
- `longest`: Location of longest interval

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/wnsumd_c.html)
"""
function wnsumd(window)
    meas = Ref{SpiceDouble}()
    avg = Ref{SpiceDouble}()
    stddev = Ref{SpiceDouble}()
    shortest = Ref{SpiceInt}()
    longest = Ref{SpiceInt}()
    ccall((:wnsumd_c, libcspice), Cvoid,
          (Ref{Cell{SpiceDouble}}, Ref{SpiceDouble}, Ref{SpiceDouble},
           Ref{SpiceDouble}, Ref{SpiceInt}, Ref{SpiceInt}),
          window.cell, meas, avg, stddev, shortest, longest)
    handleerror()
    meas[], avg[], stddev[], shortest[] + 1, longest[] + 1
end

"""
    wnunid(a, b)

Place the union of two double precision windows into a third window.

### Arguments ###

- `a`: Input window
- `b`: Input window

### Output ###

Returns a window containing the union of `a` and `b`.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/wnunid_c.html)
"""
function wnunid(a, b)
    c = SpiceDoubleCell(2 * (wncard(a) + wncard(b)))
    ccall((:wnunid_c, libcspice), Cvoid,
          (Ref{Cell{SpiceDouble}}, Ref{Cell{SpiceDouble}}, Ref{Cell{SpiceDouble}}),
          a.cell, b.cell, c.cell)
    handleerror()
    c
end

"""
    wnvald!(window)

Form a valid double precision window from the contents of a window array.

### Arguments ###

- `window`: A (possibly uninitialized) `SpiceDoubleCell` containing endpoints of
    (possibly unordered and non-disjoint) intervals.

### Output ###

Returns the validated window.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/wnvald_c.html)
"""
function wnvald!(window)
    ccall((:wnvald_c, libcspice), Cvoid,
          (SpiceInt, SpiceInt, Ref{Cell{SpiceDouble}}),
          window.cell.size, card(window), window.cell)
    handleerror()
    window
end

@deprecate wnvald wnvald!

