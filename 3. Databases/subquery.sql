SELECT 
  clients.code 
FROM 
  clients 
WHERE 
  id IN (
    SELECT 
      "clients"."id" 
    FROM 
      "clients" 
      INNER JOIN "client_users" ON "client_users"."client_id" = "clients"."id" 
      INNER JOIN "users" ON "users"."id" = "client_users"."user_id" 
    WHERE 
      users.last_sign_in_at > '2024-03-01' 
    GROUP BY 
      "clients"."id"
  )