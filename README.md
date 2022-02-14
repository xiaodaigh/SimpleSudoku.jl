# SimpleSudoku

This package has one function `solve_sudoku` which takes a 9x9 integer array as input (where 0)
indicate unfilled positions and solves it. For example

```julia
using SimpleSudoku

grid_str = """
    300007400
    000010083
    500020700
    980000006
    000005001
    010000020
    620070000
    009600000
    050400000"""

grid = mapreduce(vcat, split(grid_str, "\n")) do str
    reshape(parse.(Int8, split(str, "")), 1, 9)
end

solved_grid, is_solution_valid = solve_sudoku(grid)

if is_solution_valid
    display(solved_grid)
    #  3  6  1  9  8  7  4  5  2
    #  2  9  7  5  1  4  6  8  3
    #  5  4  8  3  2  6  7  1  9
    #  9  8  5  2  4  1  3  7  6
    #  7  3  2  8  6  5  9  4  1
    #  4  1  6  7  3  9  5  2  8
    #  6  2  4  1  7  3  8  9  5
    #  1  7  9  6  5  8  2  3  4
    #  8  5  3  4  9  2  1  6  7
end
```
