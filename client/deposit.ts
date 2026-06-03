import { SuiClient } from '@mysten/sui.js/client';
import { TransactionBlock } from '@mysten/sui.js/transactions';

// Example client for interacting with the lending module on Sui
export async function depositToPool(
  client: SuiClient,
  signer: any,
  poolId: string,
  coinId: string
) {
  const tx = new TransactionBlock();
  tx.moveCall({
    target: '0x...::lending::deposit', // Replace with actual package ID
    arguments: [tx.object(poolId), tx.object(coinId)],
  });

  const result = await client.signAndExecuteTransactionBlock({
    signer,
    transactionBlock: tx,
  });

  console.log('Deposit successful:', result);
  return result;
}