{-# LANGUAGE MultiParamTypeClasses, OverloadedStrings #-}

module Database.Esqueleto.Pgtrgm (similarity, wordSimilarity) where

import Database.Esqueleto (Esqueleto, SqlBackend, SqlExpr, SqlQuery, SqlString, Value)
import Database.Esqueleto.Internal.Sql (unsafeSqlFunction)

class Esqueleto query expr backend => EsqueletoPgtrgm query expr backend where
    similarity :: (SqlString a, SqlString b) => expr (Value a) 
               -> expr (Value b) -> expr (Value Double)
    wordSimilarity :: (SqlString a, SqlString b) => expr (Value a) 
                   -> expr (Value b) -> expr (Value Double)
infixl 2 `similarity`
infixl 2 `wordSimilarity`

instance EsqueletoPgtrgm SqlQuery SqlExpr SqlBackend where
    similarity a b = unsafeSqlFunction "similarity" (a, b)
    wordSimilarity a b = unsafeSqlFunction "word_similarity" (a, b)