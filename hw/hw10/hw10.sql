CREATE TABLE parents AS
  SELECT "abraham" AS parent, "barack" AS child UNION
  SELECT "abraham"          , "clinton"         UNION
  SELECT "delano"           , "herbert"         UNION
  SELECT "fillmore"         , "abraham"         UNION
  SELECT "fillmore"         , "delano"          UNION
  SELECT "fillmore"         , "grover"          UNION
  SELECT "eisenhower"       , "fillmore";

CREATE TABLE dogs AS
  SELECT "abraham" AS name, "long" AS fur, 26 AS height UNION
  SELECT "barack"         , "short"      , 52           UNION
  SELECT "clinton"        , "long"       , 47           UNION
  SELECT "delano"         , "long"       , 46           UNION
  SELECT "eisenhower"     , "short"      , 35           UNION
  SELECT "fillmore"       , "curly"      , 32           UNION
  SELECT "grover"         , "short"      , 28           UNION
  SELECT "herbert"        , "curly"      , 31;

CREATE TABLE sizes AS
  SELECT "toy" AS size, 24 AS min, 28 AS max UNION
  SELECT "mini"       , 28       , 35        UNION
  SELECT "medium"     , 35       , 45        UNION
  SELECT "standard"   , 45       , 60;


-- All dogs with parents ordered by decreasing height of their parent
CREATE TABLE by_parent_height AS
  SELECT child FROM parents JOIN dogs ON dogs.name = parent GROUP BY child,parent ORDER BY height DESC; 


-- The size of each dog
CREATE TABLE size_of_dogs AS
  SELECT name, sizes.size FROM dogs JOIN sizes ON dogs.height WHERE dogs.height > sizes.min AND dogs.height <= sizes.max;


-- Filling out this helper table is optional
CREATE TABLE siblings AS
  SELECT a.child AS first, b.child AS second, c.size AS size FROM parents AS a, parents AS b, size_of_dogs AS c, size_of_dogs AS d
  WHERE a.parent = b.parent  AND a.child < b.child AND a.child = c.name AND b.child = d.name AND c.size = d.size;
-- Sentences about siblings that are the same size
CREATE TABLE sentences AS
  SELECT "The two siblings, " || family.first || " plus " || family.second || " have the same size: " || family.size FROM siblings AS family;



-- Height range for each fur type where all of the heights differ by no more than 30% from the average height
CREATE TABLE low_variance AS
  SELECT fur, MAX(height) - MIN(height) 
  FROM dogs 
  GROUP BY fur 
  HAVING height >= 0.7 * (SELECT AVG(height)) AND height <= 1.3 * (SELECT AVG(height));

