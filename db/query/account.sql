-- name: CreateAccount :one
INSERT INTO accounts( 
    owner,
    balance,
    currency
 ) VALUES ($1, $2, $3) RETURNING *;

-- name: GetAccount :one
SELECT * FROM accounts WHERE id = $1 LIMIT 1;

-- name: GetAccountForUpdate :one
SELECT * FROM accounts WHERE id = $1 LIMIT 1 FOR NO KEY UPDATE;

-- name: ListAccounts :many
SELECT * FROM accounts WHERE owner = $1 ORDER BY id LIMIT $2 OFFSET $3;

-- name: UpdateAccount :one
update accounts
set balance = $2
where id = $1
RETURNING *;

-- name: AddAccountBalance :one
update accounts
set balance = balance + sqlc.arg(amount)
where id = sqlc.arg(id)
RETURNING *;

-- name: DeleteAccount :exec
delete from accounts where id = $1;