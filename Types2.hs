{-# LANGUAGE DeriveGeneric #-}
module Types2 where
import qualified Data.Text as Text
import qualified GHC.Generics as Generics

-- This module is only needed so that GHC loads Types.hs to check
-- coherence of Family Instances for Rep in Generics

data A = A
  { a1 :: [Text.Text]
  } deriving (Generics.Generic)
