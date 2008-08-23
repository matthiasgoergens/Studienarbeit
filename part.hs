part 0 _ = 0
part n k = sum $ map (part ) [1..n]