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
        a, b = 5:16
        ur = a:b
        rs = equalranges(ur, 4)
        @test sum(length, rs) == length(ur)
    end
    @testset "splitranges" begin
        a, b = 1, 16
        ur = a:b
        rs = splitranges(ur, 3)
        @test sum(length, rs) == length(ur)
    end
    @testset "binaryranges" begin
        a, b = 7, 16
        ur = a:b
        rs = binaryranges(ur, 3)
        @test sum(length, rs) == length(ur)
        @test sum(length, binaryranges(1:2^10, 2^5 - 1)) == 2^10
    end
end

