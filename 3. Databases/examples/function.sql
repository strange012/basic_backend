CREATE OR REPLACE FUNCTION multiply_three_numbers(a INT, b INT, c INT)
RETURNS INT AS $$
    SELECT a * b * c;
$$ LANGUAGE SQL;
