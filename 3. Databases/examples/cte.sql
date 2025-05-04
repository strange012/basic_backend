WITH last_clients AS (
  SELECT 
    clients.id, 
    clients.code 
  FROM 
    clients 
    INNER JOIN client_users ON client_users.client_id = clients.id 
    INNER JOIN users ON users.id = client_users.user_id 
  WHERE 
    users.last_sign_in_at > '2024-03-01' 
  GROUP BY 
    clients.id, 
    clients.code
) 
SELECT 
  last_clients.id, 
  last_clients.code, 
  sum(bills.amount) as total_amount 
FROM 
  last_clients 
  INNER JOIN bills ON last_clients.id = bills.client_id 
WHERE 
  bills.paid_at > '2024-03-01' 
GROUP BY 
  last_clients.id, 
  last_clients.code 
HAVING 
  sum(bills.amount) > 10000;
