package DBTransactions

import (
	"context"
	"happ/ent"
)

func WithTx(ctx context.Context, client *ent.Client, fn func(tx *ent.Tx) error) error {
	tx, err := client.Tx(ctx)
	if err != nil {
		return err
	}
	// defer func() {
	// 		if v := recover(); v != nil {
	// 				tx.Rollback()
	// 				panic(v)
	// 		}
	// }()
	if err := fn(tx); err != nil {
		// if rerr := tx.Rollback(); rerr != nil {
		// 	err = fmt.Errorf("rolling back transaction: %w", rerr)
		// }
		tx.Rollback()
		return err
	}
	// if err := tx.Commit(); err != nil {
	// 		return fmt.Errorf("committing transaction: %w", err)
	// }
	tx.Commit()

	return nil
}
