#
# Date created: 2021-10-15
# Author: aradclif
#
#
############################################################################################
#### p. 1-5, 2021-10-05
"""
    mthpair(q::Int, r::Int, M::Int, m::Int)

Return the `m`ᵗʰ pair of (lower,upper) bounds for division of a length, N = `q``M` + `r`,
into `M` parts, where the remainder of Euclidean division, `r` is distributed equally
across the first `r` parts.

# Notes
Formally, the expression is:
(l, u) = ((m - 1)q + 1 + (m - 1), mq + m) if m ≤ r
         ((m - 1)q + 1 + r, mq + r)       if r < m ≤ M
This has a variety of algebraic simplifications, salient examples
of which are:
(l, u) = ((m - 1)q + m, mq + m)           if m ≤ r
         (mq + r - q + 1, mq + r)         if r < m ≤ M
(l, u) = (mq - q + m, mq + m)             if m ≤ r
         (mq + r - q + 1, mq + r)         if r < m ≤ M
(l, u) = (m(q + 1) - q, m(q + 1))         if m ≤ r
         (mq + r - q + 1, mq + r)         if r < m ≤ M

# Examples
```jldoctest
julia> M = 7; N = 22; q, r = divrem(N, M)
(3, 1)

julia> mthpair(q, r, M, 1)
(1, 4)

julia> mthpair(q, r, M, 2)
(5, 7)
```
"""
function mthpair(q::Int, r::Int, M::Int, m::Int)
    if m ≤ r
        u = m * q + m
        l = u - q
        return (l, u)
    elseif r < m ≤ M
        u = m * q + r
        l = u - q + 1
        return (l, u)
    end
end

"""
    mthpair(N::Int, M::Int, m::Int)

Return the `m`ᵗʰ pair of (lower, upper) bounds for division of a length `N` into `M` parts,
where the remainder (if it is nonzero) is equally distributed across the parts.
"""
function mthpair(N::Int, M::Int, m::Int)
    q, r = divrem(N, M)
    mthpair(q, r, M, m)
end

"""
    mthrange(q::Int, r::Int, M::Int, m::Int)

Return the `m`ᵗʰ range of (lower,upper) bounds for division of a length, N = `q``M` + `r`,
into `M` parts, where the remainder of Euclidean division, `r` is distributed equally
across the first `r` parts.

# Examples
```jldoctest
julia> M = 7; N = 22; q, r = divrem(N, M)
(3, 1)

julia> mthrange(q, r, M, 1)
1:4

julia> mthrange(q, r, M, 2)
5:7
```
"""
function mthrange(q::Int, r::Int, M::Int, m::Int)
    if m ≤ r
        u = m * q + m
        l = u - q
        return l:u
    elseif r < m ≤ M
        u = m * q + r
        l = u - q + 1
        return l:u
    end
end

"""
    mthrange(N::Int, M::Int, m::Int)

Return the `m`ᵗʰ range of (lower, upper) bounds for division of a length `N` into `M` parts,
where the remainder (if it is nonzero) is equally distributed across the parts.
"""
function mthrange(N::Int, M::Int, m::Int)
    q, r = divrem(N, M)
    mthrange(q, r, M, m)
end

"""
    equalpairs(q::Int, r::Int, M::Int)

Return the `M` pairs of (lower, upper) bounds which span a length of N = `q``M` + `r`.
More efficient than `[mthpair(q, r, M, m) for m = 1:M]`.

# Examples
```jldoctest
julia> M = 7; N = 22; q, r = divrem(N, M)
(3, 1)

julia> equalpairs(q, r, M)
7-element Vector{Tuple{Int64, Int64}}:
 (1, 4)
 (5, 7)
 (8, 10)
 (11, 13)
 (14, 16)
 (17, 19)
 (20, 22)
```
"""
function equalpairs(q::Int, r::Int, M::Int)
    ps = Vector{Tuple{Int,Int}}(undef, M)
    qp1 = q + 1
    # u = qp1
    u = r > 0 ? qp1 : q
    l = 1
    ps[1] = (l, u)
    m = 2
    while m ≤ M
        if m ≤ r
            u += qp1
            l = u - q
            ps[m] = (l, u)
        elseif r < m ≤ M
            u += q
            l = u - q + 1
            ps[m] = (l, u)
        end
        m +=1
    end
    return ps
end

"""
    equalpairs(N::Int, M::Int)

Return the `M` pairs of (lower, upper) bounds which divide a length `N` into `M` parts,
where the remainder (if it is nonzero) is equally distributed across the parts.
"""
function equalpairs(N::Int, M::Int)
    q, r = divrem(N, M)
    equalpairs(q, r, M)
end

"""
    equalranges(q::Int, r::Int, M::Int)

Return the `M` ranges of (lower, upper) bounds which span a length of N = `q``M` + `r`.
More efficient than `[mthrange(q, r, M, m) for m = 1:M]`.

# Examples
```jldoctest
julia> M = 7; N = 22; q, r = divrem(N, M)
(3, 1)

julia> equalranges(q, r, M)
7-element Vector{UnitRange{Int64}}:
 1:4
 5:7
 8:10
 11:13
 14:16
 17:19
 20:22
```
"""
function equalranges(q::Int, r::Int, M::Int)
    ps = Vector{UnitRange{Int}}(undef, M)
    qp1 = q + 1
    ## u = qp1
    u = r > 0 ? qp1 : q
    l = 1
    ps[1] = l:u
    m = 2
    while m ≤ M
        if m ≤ r
            u += qp1
            l = u - q
            ps[m] = l:u
        elseif r < m ≤ M
            u += q
            l = u - q + 1
            ps[m] = l:u
        end
        m +=1
    end
    return ps
end

"""
    equalranges(N::Int, M::Int)

Return the `M` ranges of (lower, upper) bounds which divide a length `N` into `M` parts,
where the remainder (if it is nonzero) is equally distributed across the parts.
"""
function equalranges(N::Int, M::Int)
    q, r = divrem(N, M)
    equalranges(q, r, M)
end
############################################################################################
# # Clearly less efficient.
# # Invokes 1 multiply, 1(2) add, 1 subtract per mthpair call, which
# # can be reduced to 1(2) add, 1 subtract per pair.
# function mpairs(q::Int, r::Int, M::Int)
#     ps = Vector{Tuple{Int,Int}}(undef, M)
#     m = 1
#     while m ≤ M
#         ps[m] = mthpair(q, r, M, m)
#         m += 1
#     end
#     return ps
# end
# function mranges(q::Int, r::Int, M::Int)
#     ps = Vector{UnitRange{Int}}(undef, M)
#     m = 1
#     while m ≤ M
#         ps[m] = mthrange(q, r, M, m)
#         m += 1
#     end
#     return ps
# end
# M = 7
# N = 22
# q, r = divrem(N, M)
# easy = [mthpair(q, r, M, m) for m = 1:M]
# fast = equalpairs(q, r, M)
# decent = mpairs(q, r, M)
# easy == fast
# @benchmark equalpairs(q, r, M) # 45.46ns
# @benchmark mpairs(q, r, M) # 49.64ns
# easyr = [mthrange(q, r, M, m) for m = 1:M]
# fastr = equalranges(q, r, M)
# decentr = mranges(q, r, M)
# easyr == fastr
# @benchmark equalranges(q, r, M) # 47.35
# @benchmark mranges(q, r, M) # 53.00
