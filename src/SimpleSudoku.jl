module SimpleSudoku

export solve_sudoku

# find zeros go through each one and find the ones that are not in the same row, column or box
function get_candidates(grid, row, col)
    grid_id_row = ceil(Int, row / 3)
    grid_id_col = ceil(Int, col / 3)

    candidates = setdiff(0:9, mapreduce(vcat, (
        grid[1:row-1, col],
        grid[row+1:9, col],
        grid[row, 1:col-1],
        grid[row, col+1:9], +
        # the 3x3 grid within which the cell is contained
        grid[(grid_id_row-1)*3+1:grid_id_row*3, (grid_id_col-1)*3+1:grid_id_col*3])) do items
        vec(items)
    end)

    candidates
end

get_candidates(grid, cart) = get_candidates(grid, cart[1], cart[2])


"""
    solve_sudoku(grid)

Args:

    grid a 9x9 integer array where 0 indicates unfilled poistions

Returns:
    Tuple{grid::Array{2}, is_solution_valid::Bool}

    where `grid` is a solved grid if the second return value is true
    If the second return value is false then it means there is
        no solution starting with the input grid
"""
function solve_sudoku(grid)
    @assert size(grid) == (9, 9)
    @assert all(in.(grid, Ref(0:9)))
    # these are the unfilled positions
    zero_pos = findall(==(0), grid)

    if length(zero_pos) == 0
        return grid, true
    end

    cand = get_candidates.(Ref(grid), zero_pos)

    # any of them has no possible candidates; then it's an invalid solution
    if any(length.(cand) .== 0)
        return grid, false
    end

    # find the cell with the lowest number of candidates
    idx = argmin(length.(cand))

    # try the candidates one by one
    zp = zero_pos[idx]
    for c in cand[idx]
        cgrid = copy(grid)
        cgrid[zp] = c
        new_grid, valid = solve_sudoku(cgrid)
        if valid
            return new_grid, true
        end
    end

    return grid, false
end

end
