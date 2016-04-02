{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}
module Types where
import qualified Data.Aeson as Aeson
import qualified Data.Text as Text
import qualified GHC.Generics as Generics
import qualified Prelude as Prelude
import Data.Aeson
import Prelude ((.))

data X = X
  { x1 :: [Text.Text]
  , x2 :: Prelude.Bool
  , x3 :: Prelude.Maybe Text.Text
  , x4 :: Text.Text
  , x5 :: Prelude.Int
  } deriving (Generics.Generic)

instance Aeson.ToJSON X where
  toJSON
    (X a b c d e)
    = Aeson.object
        ("a" .= a :
           "b" .= b :
             Prelude.maybe Prelude.id ((:) . ("c" .=))
               c
               ("d" .= d : "e" .= e : Prelude.mempty))

-- GHC for some reason decides to specialize (.=) @ Text here and exposes
-- it via RULE.
