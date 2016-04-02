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

-- After you add C, GHC stops specializing (.=) @ Text

data C = C
  { c1 :: Prelude.Int
  , c2 :: Prelude.Maybe Text.Text
  , c3 :: Prelude.Maybe Text.Text
  }

instance Aeson.ToJSON C where
  toJSON (C a b c)
    = Aeson.object
        ("a" .= a :
           Prelude.maybe Prelude.id ((:) . ("b" .=)) b
             (Prelude.maybe Prelude.id ((:) . ("c" .=)) c
                Prelude.mempty))
