(0,0)
     \
[p] x [q] x [p] + s + t

(r,c,h) -> (r+h',c+1, h') where h' <= h.

digraph

> {-# OPTIONS_GHC -XFlexibleContexts #-}
> module Main where
> import Control.Monad
> import Control.Applicative
> import qualified Data.Map as M
> import qualified Data.Set as S
> import Data.Set ((\\))
> import Data.Maybe

sets and maps..

> data Graph a = Graph (M.Map a (S.Set a)) deriving Show

> reachable :: Ord a => S.Set a -> Graph a -> S.Set a
> reachable roots (Graph graph) = helper roots S.empty
>     where helper roots reached
>               | S.null roots = reached
>               | otherwise = let reached' = (S.union reached roots)
>                                 new = ((setUnions $ S.map (graphLookup (Graph graph)) roots) \\ reached')
>                             in helper new reached'

> coreachable :: Ord a => a -> Graph a -> S.Set a
> coreachable end g = S.filter (S.member end . flip reachable g . S.singleton) . nodes $ g

> setUnions :: Ord a => S.Set (S.Set a) -> S.Set a
> setUnions = S.fold S.union S.empty
> graphLookup (Graph graph) v = M.findWithDefault S.empty v graph

> nodes :: Ord a => Graph a -> S.Set a
> nodes (Graph graph) = S.union starts (setUnions $ S.map (graphLookup (Graph graph)) starts)
>     where starts = M.keysSet graph

> restrict :: Ord a => S.Set a -> Graph a -> Graph a
> restrict s (Graph g) = Graph . M.filterWithKey (\k _ -> S.member k s) . M.map (S.intersection s) $ g

> restrictOnST s t g = restrict (coreachable t g) . restrict (reachable (S.singleton s) g) $ g

> data V = Node Integer Integer Integer | S | T deriving (Eq, Ord)
> instance Show V where
>     show S = "S"
>     show T = "T"
>     show (Node r c h) = "\"node"++show r++"_"++show c ++"\":h"++show h

> isV p q (Node r c h) = (r >= h * c) && (True)
> isV _ _ _ = True

> isV2 p q (a, b) = isV p q a && isV p q b

> graph p q h_ = Graph . M.fromListWith (S.union) .
>                map (\(a,b) -> (a, S.singleton b)) $
>                ([]
>                 -- ++ (filter (isV2 p q) $ liftA3 Node [1..p] [1..q] [1 .. h_] ++ [S, T])
>                 ++ [(S, Node h' 1 h') | h' <- [1..h_]]
>                 -- ++ [(Node r c h, Node r c h') | r <- [1..p], c <- [1..q], h <- [1..h_], h' <- [1..h-1]]
>                 ++ [(Node r c h, Node (r+h') (c+1) h') | c <- [1..q-1], h <- [1..h_], h' <- [1..h], r <- [1..p-h']]
>                 ++ [(Node p c h, T) | c <- [1..q], h <- [1..h_]]
>                )

-- >     where 

-- >       mdf = map dot1 . f
-- >       f = filter (isV2 p q)


> graphToList :: Ord a => Graph a -> [(a,a)]
> graphToList (Graph g) = join . map (\(k, a) -> (map ((,) k) . S.toList $ a)) . M.toList $ g

> ports :: Graph V -> M.Map (Integer, Integer) (S.Set Integer)
> ports g = M.fromListWith S.union . catMaybes . S.toList . S.map op . nodes $ g
>     where op S = Nothing
>           op T = Nothing
>           op (Node a b c) = Just ((a,b), S.singleton c)

> dotify graph = "strict digraph  network {\n"
>                ++"S [label=\"S\"];\n"
>                ++"T [label=\"T\"];\n"
>                ++"graph [rankdir = \"LR\", ranksep = equally];\n"
>                ++ (join . map n . M.toList $ ports graph)
>                ++ join (map dot1 . graphToList $ graph)
>                ++ "}\n"
>     where n ((r, c), p)
>                 = "node"++show r++"_"++show c++" [shape = record, label=\""
>                   ++ ""++show r++":"++show c++""++ (join . map (\h -> " | <h"++show h ++"> "++ show h++"") . reverse . S.toList $ p)++"\"];\n"


> dot1 (a,b) = show a ++ " -> " ++ show b ++ ";\n"

> main = do putStr $ dotify $ restrictOnST S T $ graph 7 4 7