module lending::lending {
    use sui::object::{Self, UID};
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};
    use sui::coin::{Self, Coin};
    use sui::sui::SUI;

    /// Basic lending pool on Sui
    struct LendingPool has key {
        id: UID,
        total_deposited: u64,
    }

    public entry fun create_pool(ctx: &mut TxContext) {
        let pool = LendingPool {
            id: object::new(ctx),
            total_deposited: 0,
        };
        transfer::share_object(pool);
    }

    public entry fun deposit(pool: &mut LendingPool, coin: Coin<SUI>, _ctx: &mut TxContext) {
        let amount = coin::value(&coin);
        pool.total_deposited = pool.total_deposited + amount;
        transfer::public_transfer(coin, tx_context::sender(_ctx));
    }
}