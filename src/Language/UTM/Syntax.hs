{-# LANGUAGE GeneralizedNewtypeDeriving #-}
module Language.UTM.Syntax where

import Data.Map (Map)
import Data.String

data TuringMachine = TuringMachine
    { startState :: State
    , acceptState :: State
    , rejectState :: State
    , blankSymbol :: Symbol
    , inputAlphabet :: [Symbol]
    , transitionFunction :: TransitionFunction
    } deriving (Eq, Show)

tapeAlphabet :: TuringMachine -> [Symbol]
tapeAlphabet tm = blankSymbol tm : inputAlphabet tm

type TransitionFunction = Map (State, Symbol) (State, Symbol, Action)

data Action
    = L -- ^ move head to the left
    | R -- ^ move head to the right
    deriving (Eq, Ord, Show)

data Tape = Tape [Symbol] Symbol [Symbol]
    deriving (Eq, Show)

data Configuration = Configuration State Tape
    deriving (Eq, Show)

-- | <https://en.wikipedia.org/wiki/Computation_history>
type ComputationHistory = [Configuration]

type Input = [Symbol]

newtype State = State String
    deriving (Eq, Ord, Show, IsString)

newtype Symbol = Symbol String
    deriving (Eq, Ord, Show, IsString)

syms :: String -> [Symbol]
syms = map (Symbol . return)

unsyms :: [Symbol] -> String
unsyms = concatMap (\(Symbol s) -> s)
