data Mood = Blah | Woot deriving Show

changeMood :: Mood -> Mood

-- this is pattern matching
-- if a type of Blah is passed into changeMood, we return a Woot
changeMood Blah = Woot
-- _ here is the fallback. If all previous pattern matched variations of
-- changeMood fail, this is the variation that will be executed, regardless of
-- the type passed into changeMood
changeMood _ = Blah
