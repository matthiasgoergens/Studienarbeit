(0,0)
     \
[p] x [q] x [p] + s + t

(r,c,h) -> (r+h',c+1, h') where h' <= h.

digraph

> module Main where
> import Control.Monad
> import Control.Applicative
> import qualified Data.Map as M
> import qualified Data.Set as S

sets and maps..

> data Graph a = Graph (M.Map a (S.Set a))

> reachable :: Ord a => S.Set a -> Graph a -> S.Set a
> reachable roots (Graph graph) = helper roots S.empty
>     where helper roots reached
>               | S.null roots = reached
>               | otherwise = helper (S.fold S.union S.empty $ S.map lookup roots)
>                                    (S.union reached roots)
>           lookup v = M.findWithDefault S.empty v graph

> data V = Node Integer Integer Integer | S | T deriving (Eq, Ord)
> instance Show V where
>     show S = "S"
>     show T = "T"
>     show (Node r c h) = "node"++show r++"_"++show c ++"_"++show h

> isV p q (Node r c h) = (r >= h * c) && (True)
> isV _ _ _ = True

> isV2 p q (a, b) = isV p q a && isV p q b

> graph p q h_ = M.fromListWith (S.union) $
>                map (\(a,b) -> (a, S.singleton b)) $
>                ([]
>                 -- ++ (filter (isV2 p q) $ liftA3 Node [1..p] [1..q] [1 .. h_] ++ [S, T])
>                 ++ [(S, Node h' 1 h') | h' <- [1..h_]]
>                 -- ++ [(Node r c h, Node r c h') | r <- [1..p], c <- [1..q], h <- [1..h_], h' <- [1..h-1]]
>                 ++ [(Node  r c h, Node (r+h') (c+1) h') | c <- [1..q-1], h <- [1..h_], r <- [1..p-h], h' <- [1..h]]
>                 ++ [(Node p c h, T) | c <- [1..q], h <- [1..h_]]
>                )

-- >     where 

-- >       mdf = map dot1 . f
-- >       f = filter (isV2 p q)
-- >           n node = ""++show node++" [label=\""
-- >                    ++ case node
-- >                       of Node r c h -> "("++show r++", "++show c++", "++show h++")"
-- >                          S -> "S"
-- >                          T -> "T"
-- >                    ++"\"];\n"

> dotify graph = "digraph dataflow {\n"
>                ++ join (graph)
>                ++ "}\n"

> dot1 (a,b) = show a ++ " -> " ++ show b ++ ";\n"

> main = do print $ graph 3 3 3