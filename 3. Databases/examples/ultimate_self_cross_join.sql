CREATE TABLE sides(id SERIAL PRIMARY KEY, len INTEGER);


CREATE OR REPLACE FUNCTION triangle_area(a FLOAT, b FLOAT, c FLOAT) 
RETURNS FLOAT AS
$$
DECLARE
    p FLOAT;
    area FLOAT;
BEGIN
    IF a + b > c AND a + c > b AND b + c > a THEN
      p := (a + b + c) / 2;
      area := sqrt(p * (p - a) * (p - b) * (p - c));
      RETURN area;
    ELSE
      RETURN 0;
    END IF;
END;
$$ LANGUAGE plpgsql;

SELECT s1.len AS side1, s2.len AS side2, s3.len AS side3, triangle_area(s1.len, s2.len, s3.len) as area
FROM sides s1
INNER JOIN sides s2 ON s1.len <= s2.len
INNER JOIN sides s3 ON s2.len <= s3.len
WHERE triangle_area(s1.len, s2.len, s3.len) BETWEEN 3.2 AND 4.1
ORDER BY area;
