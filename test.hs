module Test where
import Data.List.Split
enumerate = zip [0..]

-- function to initizlie a bunch of the same value in a 2d grid of user defined size
grid :: Int -> Int -> a -> [[a]]
grid x y = replicate y . replicate x

------------ DEFINITIONS -------------------
-- SOON: Will get info from Penrose not me plugging in automatic values

-- col definitions used in every function
col :: Int
col = 10

-- row definiton used in every function
row :: Int
row = 10

-------------------------------------------
-- FindMin calls the 4 "sweep" functions, in accordance with the fast sweeping method pseudocode
-------------------------------------------
fsm :: [Int] -> [Int]
fsm list =  (funcURtoLL (funcLLtoUR (funcULtoLR list [] 0 list) [] 0 (funcULtoLR list [] 0 list)) [] 0 (funcLLtoUR (funcULtoLR list [] 0 list) [] 0 (funcULtoLR list [] 0 list)))


-------------------------------------------
-- OPTIMIZE: the fact that we need to account for this later rather than in the iterations is hacky, but I wanted to avoid a million if statements, and i'm doing that here and I hate it

-- The sweeping functions don't account for grid edges so I need to iterate through at end and find those values
-------------------------------------------
-- cleanEdges :: Int -> Int -> Int -> [Int] -> [Int] -> [Int]
-- cleanEdges n rows cols newList oldList n =
--     let
--       x = (n) `div` (col)
--       y = (n) `mod` (col)
--       a = []
--     in
--       if ( x != 0 ) then
--         a ++ [oldList!!(n - row)]
--       if ( x != row - 1 ) then
--         a ++ [oldList!!(n + row)]
--       if ( y != 0 ) then
--         a ++ [oldList!!(n - 1)]
--       if ( y != col - 1 ) then
--         a ++ [oldList!!(n + 1)]
--       cleanEdges ( n+1 )  (newList ++ [minimum (map abs a)] ) tail(oldList)



-------------------------------------------
-- Sweep upper lef to lower right
-- params: original list, list [0..n-1], nth element we are looking at, list [n+1..end]
-------------------------------------------
funcULtoLR :: [Int] -> [Int] -> Int -> [Int] -> [Int]
-- base case, empty list
funcULtoLR g list _ [] = list
-- find all surrounding cells of a cell and see which has the smallest distance
funcULtoLR g beginList n endList =
    let
      x = (n) `div` (col)
      y = (n) `mod` (col)
    in
      if(y == 0 || y == (col-1) || x == 0 || x == (row-1)) then --avoid upper and lower boundaries
        funcULtoLR g (beginList ++ [g!!(n)]) (n+1) (tail(endList))      -- if at a boundary, dont check cells outside
      else
        funcULtoLR g (beginList ++
              [minimum [ abs ( g!!(n) ),
                         abs ( g!!(n+1)   + 1),
                         abs ( g!!(n-1)   + 1),
                         abs ( g!!(n+col) + 1),
                         abs ( g!!(n-col) + 1),
                         abs ( g!!(n+col-1) + 1), --diagonals
                         abs ( g!!(n+col+1) + 1),
                         abs ( g!!(n-col-1) + 1),
                         abs ( g!!(n-col+1) + 1)
                        ]
              ] )   (n+1)  (tail(endList))

-------------------------------------------
-- Sweep upper lef to lower right
-- params: original list, list [0..n-1], nth element we are looking at, list [n+1..end]
-------------------------------------------
funcLLtoUR :: [Int] -> [Int] -> Int -> [Int] -> [Int]
-- base case, empty list
funcLLtoUR g list _ [] = list
-- find all surrounding cells of a cell and see which has the smallest distance
funcLLtoUR g beginList n endList =
    let
      x = (row-1) - (n) `div` (col)
      y = (n) `mod` (col)
    in
      if(y == 0 || y == (col-1) || x == 0 || x == (row-1)) then --avoid upper and lower boundaries
        funcLLtoUR g (beginList ++ [g!!(n)]) (n+1) (tail(endList))
      else
        funcLLtoUR g (beginList ++
              [minimum [ abs ( g!!(n) ),
                         abs ( g!!(n+1)   + 1),
                         abs ( g!!(n-1)   + 1),
                         abs ( g!!(n+col) + 1),
                         abs ( g!!(n-col) + 1),
                         abs ( g!!(n+col-1) + 1), --diagonals
                         abs ( g!!(n+col+1) + 1),
                         abs ( g!!(n-col-1) + 1),
                         abs ( g!!(n-col+1) + 1)
                        ]
              ] )   (n+1)  (tail(endList))

-------------------------------------------
-- Sweep upper right to lower left
-- params: original list, list [0..n-1], nth element we are looking at, list [n+1..end]
-------------------------------------------
funcURtoLL :: [Int] -> [Int] -> Int -> [Int] -> [Int]
-- base case, empty list
funcURtoLL g list _ [] = list
-- find all surrounding cells of a cell and see which has the smallest distance
funcURtoLL g beginList n endList =
    let
      x = (n) `div` (col)
      y = (col-1)  - (n) `mod` (col)
    in
      if(y == 0 || y == (col-1) || x == 0 || x == (row-1)) then --avoid upper and lower boundaries
        funcURtoLL g (beginList ++ [g!!(n)]) (n+1) (tail(endList))
      else
        funcURtoLL g (beginList ++
              [minimum [ abs ( g!!(n) ),
                         abs ( g!!(n+1)   + 1),
                         abs ( g!!(n-1)   + 1),
                         abs ( g!!(n+col) + 1),
                         abs ( g!!(n-col) + 1),
                         abs ( g!!(n+col-1) + 1), --diagonals
                         abs ( g!!(n+col+1) + 1),
                         abs ( g!!(n-col-1) + 1),
                         abs ( g!!(n-col+1) + 1)
                        ]
              ] )   (n+1)  (tail(endList))

-------------------------------------------
-- Sweep lower right to upper left
-- params: original list, list [0..n-1], nth element we are looking at, list [n+1..end]
-------------------------------------------
funcLRtoUL :: [Int] -> [Int] -> Int -> [Int] -> [Int]
-- base case, empty list
funcLRtoUL g list _ [] = list
-- find all surrounding cells of a cell and see which has the smallest distance
funcLRtoUL g beginList n endList =
    let
      x = (row-1) - (n) `div` (col)
      y = (col-1) - (n) `mod` (col)
    in
      if(y == 0 || y == (col-1) || x == 0 || x == (row-1)) then --avoid upper and lower boundaries
        funcLRtoUL g (beginList ++ [g!!(n)]) (n+1) (tail(endList))
      else
        funcLRtoUL g (beginList ++
                    [minimum [ abs ( g!!(n) ),
                               abs ( g!!(n+1)   + 1),
                               abs ( g!!(n-1)   + 1),
                               abs ( g!!(n+col) + 1),
                               abs ( g!!(n-col) + 1),
                               abs ( g!!(n+col-1) + 1), --diagonals
                               abs ( g!!(n+col+1) + 1),
                               abs ( g!!(n-col-1) + 1),
                               abs ( g!!(n-col+1) + 1)
                              ]
                    ] )   (n+1)  (tail(endList))
-------------------------------------------
-- this is the outermost "boundary" function, the one with understandable parameters
-- recieve the beginnings of a Level Set from inner boudanry function: findFun
-- params: row number, column number, radius of circle, x center, y center
-------------------------------------------
findBoundaries :: Int -> Int -> Int -> Int -> Int -> [Int]
findBoundaries row col radius xc yc =
  let x = (row * col - 1)
  in
    findFunc [] [0..x] radius xc yc -- this function calls another function which does the work but has more complicated params

-------------------------------------------
--OPTIMIZE: I'm having trouble with floating point numbers and its makign accuracy of measurement incorrect for distance funciton and where i measure distance between diagonal grids
-- need to get floats working for the level set distances

-- the inner "boundary" function (see findBoundaries) iterates over the array and creates a new array with the
-- dist^2 - radius^2 value for each cell.  If 0 == youre on the surface,
-- if negative th cell is inside the circle, if positive the cell is outside
-- the greater the magnitue, the farther the cell is from the surface
-- params: list, nCount list to iterate through, radius, x center, and y center
-------------------------------------------
findFunc :: [Int] -> [Int] -> Int -> Int -> Int -> [Int]
-- base case: done iterating through intitial list
findFunc list [] radius xc yc = list
-- for every element in the list find whether it is inside circle, add to final list, call again on tail
findFunc list nCount radius xc yc =
    let
    n = (head(nCount)) -- find which index we are on by getting head of list
    x = n `div` col
    y = n `mod` col
    a = ( ((x-xc) ^2) + ((y-yc) ^2) )  - radius^2 -- distance from center function
    in
      findFunc (list ++ ([a]) ) (tail(nCount)) radius xc yc -- append distance from center, recurse through rest of list

-------------------------------------------
--This function creates a 2d Grid from the 1d list we have been using to represent the 2d grid (easier to iterate through funcitonally)
-- params: list and length of column
-------------------------------------------
createGrid :: [Int] -> Int -> [[Int]]
createGrid list cols = chunksOf cols list



--------------- TESTING ------------------------

testBoundary = (findBoundaries (row) (col) 3 (row `div` 2) (col `div` 2))
testGrid = createGrid ( fsm testBoundary) (col)



---------------- PSEUDOCODE --------------------

-- containsLevelSet [outc, inc] [] = 0
--   grid (r' outc * 2) (r' outc * 2) 9000
--
--
--
--   -- for x in width that they overlap
--   --  for y in height that they overlap
--   --      if ( b.grid[ x,y ] <= 0 )
--   --         if ( a.grid[ x,y ] > 0 )
--   --             add to outsidePts
--
--
--   -- for x in outsidePts
--   --       sum and return average
--
-- bvhHelper [outc, inc] [] =
--     --iterate through BVH tree
--     --at smallest leaf node where still intersecting
--     containsLevelSet [outc, inc] []
--
-- contains :: ConstrFn
-- contains [C' outc, C' inc] [] =
--     --if contains BBox a BBox b
--     if (strictSubset [[xc' inc, yc' inc, r' inc], [xc' outc, yc' outc, r' outc]] > 0) then
--       strictSubset [[xc' inc, yc' inc, r' inc], [xc' outc, yc' outc, r' outc]]
--     else
--       bvhHelper [outc, inc] []
