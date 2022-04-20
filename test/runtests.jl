using EqualRanges
using Test

@testset "EqualRanges.jl" begin
    @testset "equalranges" begin
        M, N = 7, 22
        q, r = divrem(N, M)
        easy = [mthpair(q, r, M, m) for m = 1:M]
        fast = equalpairs(q, r, M)
        @test easy == fast
        easyr = [mthrange(q, r, M, m) for m = 1:M]
        fastr = equalranges(q, r, M)
        @test easyr == fastr
        @test sum(length, easyr) == N == sum(length, fastr)
        #
        M, N = 12, 10
        rr = equalranges(N, M)
        @test sum(length, rr) == N
        #
        start, stop = 5:16
        ur = start:stop
        rs = equalranges(ur, 4)
        @test sum(length, rs) == length(ur)
    end

end
