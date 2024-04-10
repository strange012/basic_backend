
-- 2.1. Получить список всех клиентов, зарегистрированных за последние полгода, у кого есть неоплаченные инвойсы
sql = <<-SQL
SELECT DISTINCT c.*
FROM clients c
JOIN bills b ON c.id = b.client_id
WHERE c.created_at >= CURRENT_DATE - INTERVAL '6' MONTH
AND (b.status = 0 OR b.status = 1)
AND b.posted_at < CURRENT_DATE;
SQL

-- 2.2. Получить список всех клиентов, зарегистрированных за последние полгода, у кого есть неоплаченные рекуррентные инвойсы
sql = <<-SQL
SELECT DISTINCT c.*
FROM clients c
JOIN bills b ON c.id = b.client_id
JOIN recurring_invoices ri ON b.recurring_invoice_id = ri.id
WHERE c.created_at >= CURRENT_DATE - INTERVAL '6' MONTH
AND (b.status = 0 OR b.status = 1)
AND b.posted_at < CURRENT_DATE;
SQL

-- 2.3. Посчитать средний размер инвойса за полгода
sql = <<-SQL
SELECT AVG(base_amount) AS average_amount
FROM bills
WHERE posted_at >= CURRENT_DATE - INTERVAL '6' MONTH;
SQL

-- 2.4. Посчитать средний размер разового инвойса за полгода без экстремальных значений

