{-# LANGUAGE OverloadedStrings #-}
module JoinPoint where

import SomethingInBetween ()
import SomethingInBetween2 ()
import Data.Aeson.Types
import Data.Text (Text)
import Control.Monad
import qualified Data.HashMap.Strict as HashMap

{-# NOINLINE aList #-}
aList :: IO [Object]
aList = return []

{-# NOINLINE makeObject #-}
makeObject :: [(Text,Value)] -> Object
makeObject = HashMap.fromList

{-# NOINLINE fetchText #-}
fetchText :: Object -> Text -> IO Text
fetchText _obj key = return key

{-# NOINLINE fetchInt #-}
fetchInt :: Object -> IO Int
fetchInt _b = return 5

-- We need all this to convince GHC that it's worth to use RULE for
-- specialized (.=) @ Text
anIntList :: IO [Int]
anIntList = do
    aList1 <- aList
    filter (> 0) <$> mapM (get2 <=< get) aList1
  where
  get2 x = fetchInt (makeObject ["" .= x])
  get x = fetchText x ""
