SELECT 
  "clients".*,
  "users".*
FROM 
  "clients" 
  INNER JOIN "client_users" ON 
    "client_users"."client_id" = "clients"."id" 
  INNER JOIN "users" ON 
    "users"."id" = "client_users"."user_id" 
WHERE 
  "clients"."code" BETWEEN 'A' 
  AND 'D' 
  AND (
    users.last_sign_in_at > '2024-03-01'
  ) 