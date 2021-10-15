# EqualRanges
A straightforward package which provides the most efficient computations
of a common task: Euclidean division of a length `N` into `M` parts, where
the remainder (if it is nonzero) is distributed across the parts. Motivation
can be found in not only the direct use of the package, but in the fact that
it serves as a reference implementation. See the code and docstrings
for a demonstration of the fewest possible multiply/add/subtract operations;
these may be handy for a scenario where one wishes to build a range-based
without explicitly calling the functions here.

May eventually submit pull request to julia/base;
insertion target TBD.
