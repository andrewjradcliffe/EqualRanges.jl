#
# Date created: 2022-04-20
# Author: aradclif
#
#
############################################################################################

function binaryranges!(ranges::Vector{UnitRange{Int}}, start::Int, stop::Int, Lc::Int)
    L = stop - start + 1
    if L ≤ Lc
        push!(ranges, start:stop)
    else
        # If negative values, the bitshift will not work properly.
        # H = (start + stop) >> 1
        H = (stop - start) ÷ 2
        binaryranges!(ranges, start, H, Lc)
        binaryranges!(ranges, H + 1, stop, Lc)
    end
    return ranges
end

"""
    binaryranges(start, stop, chunksize)

Divide the range `start:stop` into segments by expanding a binary tree
until the interval covered by each terminal branch is ≤ `chunksize`.
"""
binaryranges(start::Int, stop::Int, Lc::Int) =
    binaryranges!(Vector{UnitRange{Int}}(), start, stop, Lc)

"""
    binaryranges(ur::UnitRange{Int}, chunksize)

Divide the range `ur` into segments, expanding until the interval covered by
each terminal branch is ≤ `chunksize`.
"""
binaryranges(ur::UnitRange{Int}, Lc::Int) = binaryranges(ur.start, ur.stop, Lc)
