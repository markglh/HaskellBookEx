# Chapter 4 - Basic Datatypes

## 4.2 Types overview

* Expressions evaluate to values. 
* Every value has a _type_. 
* A type is synonymous with a set in maths -> set theory.
* Types group common sets of values together

A `type alias` is a way to refer to a type constructor or constant by an alternate name:
```Haskell
type Name = String
```

## 4.3 Anatomy of a data declaration

_Data declarations_ are how we define types

```haskell
-- data declaration for Bool
data Bool = False | True
--    [1]    [2] [3] [4]

-- [1]  - the type constructor
--      - this is what is used in type signatures
-- [2]  - a data constructor for the value False
-- [3]  - logical 'or'. Bool is either False or True
-- [4]  - data constructor for the value True
```

Data declarations for types can be found using `:info` in Prelude:

```haskell
:i Bool
data Bool = False | True
...
```

In the following data declaration, `deriving Show` allows values of the type to
be printed to the screen.

```haskell
data Mood = Blah | Woot deriving Show
```

Data declarations:
* *always* create a new type constructor
* _may_ or _may not_ create new data constructors.

### Exercises: Mood Swing

Given:

```haskell
data Mood = Blah | Woot deriving Show
```

1. Mood is the type constructor

2. A function accepting Mood in its type signature would accept either Blah or
   Woot as parameters

3.
    ```haskell
      changeMood :: Mood -> Woot
      -- This will always return Woot, not switch moods.
      -- We need it to return another Mood, because mood has Blah and Woot as
      -- its data constructors.

      -- correct type signature:
      changeMood :: Mood -> Mood
    ```

4. [4.3-mood.hs](/Chapter04/4.3-mood.hs)

## 4.4 Numeric Types
All use typeclass `Num`. Typeclasses add reusable functionality.
* `+`, `-`, `*`, etc.
* Unlike `Bool` which has two possible values, the data constructors for Numeric types aren't written out.
* Polymorphic under the surface, not assigned to a concrete type (e.g. `Int8`) until required.

### Integral Numbers
Whole numbers (- & +)
* `Int`
    - Fixed precision (range of values)
    - Rolls over at outer bound
* `Integer`
    - Supports unbounded (large and small) numbers
    - Recommended unless performance is a huge concern

Example `Int` out of bound error and rollover:
```Haskell
Prelude> import GHC.Int
 Prelude> 127 :: Int8
127
 Prelude> 128 :: Int8
<interactive>:11:1: Warning:
     Literal 128 is out of the
       Int8 range -128..127
     If you are trying to write a large
       negative literal,
     use NegativeLiterals
-128
 Prelude> (127 + 1) :: Int8
-128
```

We can find the min and max bounds using `minBound` and `maxBound` (`Bounded`)typeclasses:
```Haskell
Prelude> import GHC.Int
Prelude GHC.Int> minBound :: Int8
-128
Prelude GHC.Int> minBound :: Int16
-32768
Prelude GHC.Int> maxBound :: Int8
127
Prelude GHC.Int> maxBound :: Int16
32767
```

You can use `:i` to find out if a type has an instance of `Bounded`.

### Fractional
Fractional numbers implement the `Fractional` typeclass, which is a subclass of `Num`.
Division is always Fractional.

* `Float`
    - Single precision
    - Can shift no of bits used to represent numbers before / after the point
    - Don't use, sucks - inaccurate
* `Double`
    - Double Precision
    - Twice as many bits as float
* `Rational`
    - Represents a ratio of two integers
    - `1 / 2 :: Rational` will be a value carrying two `Integer` values. RAtio of 1 to 2.
    - Arbitrarily precise but not as efficient as `Scientific`
* `Scientific`
    - Space efficient and Arbitrarily precise
    - Stores coefficient as an `Integer` and exponent as `Int`
    - High upper limit
    - installed using `cabel install` / `stack install`

## 4.5 Comparing Values

* `Eq` is a typeclass that includes everything that can be compared.
* `Ord` is a typeclass that includes all the things that can be ordered.
* When comparing lists, all items in the list must implement the appropriate typeclass
* You can't compare different types using these comparators.

```Haskell
Prelude GHC.Int> :t (==)
(==) :: Eq a => a -> a -> Bool
Prelude GHC.Int> :t (<)
(<) :: Ord a => a -> a -> Bool
...
Prelude GHC.Int> 5 < 4
False
Prelude GHC.Int> 5 /= 4
True
Prelude GHC.Int> "Fred" == "Dave"
False

-- Haskell evaluates [Char] on a per character basis, stopping evaluation as
-- soon as matching indices yield a result
-- So, 'F' > 'D'
Prelude GHC.Int> "Fred" > "Dave"
True
Prelude GHC.Int> ['F', 'r', 'e', 'd'] > ['D', 'a', 'v', 'e']
True

Prelude GHC.Int> [1, 2] > [2, 1]
False
```

## 4.6 Go on and Bool me

Datatype with constructor Bool:
```Haskell
data Bool = False | True
```
We use type constructors in type signatures, not in epressions that make up out term-level code.

Case is important:
```Haskell
Prelude GHC.Int> :t True
True :: Bool
Prelude GHC.Int> not True
False
Prelude GHC.Int> not true

<interactive>:99:5: error:
    • Variable not in scope: true :: Bool
    • Perhaps you meant data constructor ‘True’ (imported from Prelude)
```

### Find the mistakes
1. `not True && true`           ->  `not True && True`
2. `not (x = 6)`                ->  `not (x == 6)`
3. `(1 * 2) > 5`                ->  :D
4. `[Merry] > [Happy]`          -> `["Merry"] > ["Happy"]`
5. `[1, 2, 3] ++ "look at me!"` ->  `['1', '2', '3'] ++ "look at me!"`


### Conditionals with if-then-else
Haskell doesn't have `if` statements, but it does have `if` expressions.

```Haskell
Prelude GHC.Int> if True then "meh" else "wat!"
"meh"
```

Example:
```Haskell
module GreetIfCool1 where

greetIfCool :: String -> IO () 
greetIfCool coolness =
    if cool
        then putStrLn "eyyyyy. What's shakin'?"
    else
        putStrLn "pshhhh." 
    where cool =
            coolness == "downright frosty yo"
```

Results in:
```Haskell
*GreetIfCool1 GHC.Int> greetIfCool "downright frosty yo"
eyyyyy. What's shakin'?
```

## 4.7 Tuples
* Pass around multiple values within a single value
* Referred to by the number of values in the tuple (AKA arity)
    - two-tuple / pair -> `(x, y)`
    - three-tuple / triple -> `(x, y, z)`
    - Tuples may not have only 1 value, but a zero-tuple exists, referred to by unit or ().
* Values can be different types
* The type info is different to `Bool`
    - It has two parameters (a & b)
    - These have to be applied to concrete types
    - `Product` type, not a `Sum` type.
* A `Product` type represents a logical conjunction, **both** arguments must be provided, though they can be the same.
* A `Sum` type only requires one value. Sum types use disjunction to produce a value, as with `Bool`: `data Bool = False | True

```Haskell
Prelude GHC.Int> :i (,)
data (,) a b = (,) a b  -- Defined in ‘GHC.Tuple’
```

The two-tuple has some convenience functions for getting the values:
```Haskell
Prelude GHC.Int> tup
(1,2)
Prelude GHC.Int> fst tup
1
Prelude GHC.Int> snd tup
2
Prelude GHC.Int> swap tup

<interactive>:129:1: error:
    Variable not in scope: swap :: (Integer, Integer) -> t
Prelude GHC.Int> import Data.Tuple
Prelude GHC.Int Data.Tuple> swap tup
(2,1)
```

The function definitions can look like type signatures for Tuples.
We can implement `fst` ourselves using pattern matching:
```Haskell
Prelude GHC.Int Data.Tuple> :{
Prelude GHC.Int Data.Tuple| fst'::(a,b)->a
Prelude GHC.Int Data.Tuple| fst'(a,b)=a
Prelude GHC.Int Data.Tuple| :}

Prelude GHC.Int Data.Tuple> :i fst
fst :: (a, b) -> a  -- Defined in ‘Data.Tuple’
Prelude GHC.Int Data.Tuple> :i fst'
fst' :: (a, b) -> a     -- Defined at <interactive>:150:1
```
## 4.8 Lists

Unlike tuples:
1. All elements must be the same type
2. Lists have their own distinct syntax: `[]` for the constructor in both type and term levels
3. The number of values isn't specified in the type

Lists can be concatnated (/flattened) using `concat`:

```Haskell
a = [1, 2, 3]
b = [4, 5, 6]
c = [a, b]

-- concat :: [[a]] -> [a]
Prelude GHC.Int Data.Tuple> c
[[1,2,3],[4,5,6]]
Prelude GHC.Int Data.Tuple> concat c
[1,2,3,4,5,6]
```

## Chapter Exercises

Prerequisite:
```Haskell
awesome = ["Papuchon", "curry", ":)"] 
also = ["Quake", "The Simons"] 
allAwesome = [awesome, also]
```

1. `length :: [a] -> Int` (ghci = `length :: Foldable t => t a -> Int`)
2. 
    a. 5
    b. 3
    c. 2
    d. 5
3. `6 / 3` is good. `6 / length [1, 2, 3]` isn't because `length [1, 2, 3]` isn't `Fractional`
4. `div 6 (length [1, 2, 3])` or `div 6 $ length [1, 2, 3]`
5. `2 + 3 == 5` is of type `Bool`, returns `True` because `+` is higher precedence. 
6. 
```Haskell
-- given
x = 5
x + 3 == 5

-- type == Bool
-- result == False
```
7. 
```Haskell
-- Res = True
length allAwesome == 2

-- Error, lists must be same type
length [1, 'a', 3, 'b']

-- Res = 5
length allAwesome + length awesome

-- res = False
(8 == 8) && ('b' < 'a')

-- Res = Error, 9 isn't a Bool
(8 == 8) && 9
```
8. 
```Haskell
isPalindrome x = x == reverse x
```
9. 
```Haskell
myAbs = if x >= 0 then x else negate x
```
10. `f a b = ((snd a, snd b), (fst a, fst b))`

### Correcting Syntax
1. 
```Haskell
 -- original
x = (+)
F xs = w 'x' 1
    where w = length xs

--fixed (backticks & caps)
x = (+)
f xs = w `x` 1
    where w = length xs
```
2.
```Haskell
-- original
\ X = x

-- fixed
-- The `\` means anonymous lambda
identity = \x -> x

-- equivalent to fucntion i such that
i x = x
```
3. 
```Haskell
-- original
f (a b) = A

-- fixed
f a = fst a
```

### Matching the functino names to their types
1. b) `show :: Show a => a -> String`
2. c) `(==) :: Eq a => a -> a -> Bool`
3. a) `fst :: (a, b) -> a`
4. d) `(+) :: Num a => a -> a -> a`



