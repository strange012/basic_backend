SELECT 
  "clients"."id", 
  "clients"."code", 
  max(users.last_sign_in_at) as client_last_sign_in, 
  count(users.id) as login_count 
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
GROUP BY 
  "clients"."id" 
HAVING 
  (
    count(users.id) > 10
  ) 
ORDER BY 
  clients.code