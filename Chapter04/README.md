# Chapter 4 - Basic Datatypes

## 4.2 Types overview

* Expressions evaluate to values. 
* Every value has a _type_. 
* A type is synonymous with a set in maths -> set theory.
* Types group common sets of values together

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

4. [4.3.hs](/chapter-04/4.3.hs)
