WITH RECURSIVE directory_tree AS (
    SELECT id, name, parent_id, 1 AS level
    FROM doc_dirs
    WHERE parent_id IS NULL  -- Start from the root directory (where parent_id is NULL)

    UNION ALL

    SELECT d.id, d.name, d.parent_id, dt.level + 1
    FROM doc_dirs d
    INNER JOIN directory_tree dt ON d.parent_id = dt.id
)
SELECT id, name, level
FROM directory_tree
WHERE level > 3;