// Function to check if a number can be placed in a given cell
func isValid(_ puzzle: [[Int]], _ row: Int, _ col: Int, _ num: Int) -> Bool {
    // Check row and column
    for i in 0..<9 {
        if puzzle[row][i] == num || puzzle[i][col] == num {
            return false
        }
    }
    
    // Check subgrid
    let startRow = row - row % 3
    let startCol = col - col % 3
    for i in 0..<3 {
        for j in 0..<3 {
            if puzzle[startRow + i][startCol + j] == num {
                return false
            }
        }
    }
    
    return true
}

// Function to solve Sudoku puzzle using backtracking
func solveSudoku(_ puzzle: inout [[Int]]) -> Bool {
    for row in 0..<9 {
        for col in 0..<9 {
            if puzzle[row][col] == 0 {
                for num in 1...9 {
                    if isValid(puzzle, row, col, num) {
                        puzzle[row][col] = num
                        
                        if solveSudoku(&puzzle) {
                            return true
                        }
                        
                        puzzle[row][col] = 0
                    }
                }
                return false
            }
        }
    }
    return true
}

// Function to print a Sudoku grid
func printSudoku(_ puzzle: [[Int]]) {
    for row in puzzle {
        print(row.map { String($0) }.joined(separator: " "))
    }
}

// Main program
print("Enter Sudoku puzzle:")
var puzzle: [[Int]] = []
for _ in 1...9 {
    if let input = readLine(), input.count == 9 {
        let row = input.compactMap { Int(String($0)) }
        if row.count == 9 {
            puzzle.append(row)
        } else {
            print("Invalid row length. Please enter 9 digits.")
            break
        }
    } else {
        print("Invalid input. Please enter 9 digits.")
        break
    }
}

if puzzle.count == 9 && solveSudoku(&puzzle) {
    print("Solved Sudoku:")
    printSudoku(puzzle)
} else {
    print("No solution found.")
}
