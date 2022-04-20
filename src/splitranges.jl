#
# Date created: 2022-04-20
# Author: aradclif
#
#
############################################################################################
# A useful utility for dividing a range into segments of a given size

"""
    splitranges(start, stop, chunksize)

Divide the range `start:stop` into segments, each of size `chunksize`.
The last segment will contain the remainder, `(start - stop + 1) % chunksize`,
if it exists.
"""
function splitranges(start::Int, stop::Int, Lc::Int)
    L = stop - start + 1
    n, r = divrem(L, Lc)
    ranges = Vector{UnitRange{Int}}(undef, r == 0 ? n : n + 1)
    l = start
    @inbounds for i = 1:n
        l′ = l
        l += Lc
        ranges[i] = l′:(l - 1)
        # l′ = l + Lc
        # ranges[i] = l:(l′ - 1)
        # l = l′
        # ranges[i] = l:(l + Lc - 1)
        # l += Lc
    end
    if r != 0
        @inbounds ranges[n + 1] = (stop - r + 1):stop
    end
    return ranges
end

"""
    splitranges(ur::UnitRange{Int}, chunksize)

Divide the range `ur` into segments, each of size `chunksize`.
"""
splitranges(ur::UnitRange{Int}, Lc::Int) = splitranges(ur.start, ur.stop, Lc)
