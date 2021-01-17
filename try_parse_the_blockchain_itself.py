import os
from blockchain_parser.blockchain import Blockchain
import mysql.connector

db = mysql.connector.connect(host='<your ip>',user='bitcoin',password='password',db='bitcoin')

# Instantiate the Blockchain by giving the path to the directory
# containing the .blk files created by bitcoind

cur = db.cursor()
print(dir(cur))


counter = 500
c2 = 0
# blockchain = Blockchain(os.path.expanduser('C:\\Users\\Analyst\\AppData\\Roaming\\Bitcoin\\blocks'))
blockchain = Blockchain(os.path.expanduser('/mnt/c/Users/Analyst/AppData/Roaming/Bitcoin/blocks/'))
for block in blockchain.get_unordered_blocks():
    # if counter == 0 or c2 > 100000:
    #     # break
    #     pass
    print('[+] PROCESSING BLOCK',block)
    for tx in block.transactions:
        # print('*'*80)
        #print(tx.inputs)
        #print(dir(tx.inputs[0]))
        cur.execute('INSERT INTO transactions (txid, transactiondate) VALUES (%s,%s)',(tx.hash,tx.locktime))
        transid = cur.lastrowid
        # print('[+] INPUT ADDRESS')
        for no, inp in enumerate(tx.inputs):
            # print("tx=%s outputno=%d seq=%d" % (inp.transaction_hash, no, inp.sequence_number))
            inp_id = -1
            try:
                cur.execute('INSERT INTO inputs (txid, outputno) VALUES (%s, %s)',(inp.transaction_hash, no))
                inp_id = cur.lastrowid
            except:
                cur.execute('SELECT id FROM inputs WHERE txid=%s AND outputno=%s',(inp.transaction_hash, no))
                inp_id=cur.fetchone()[0]
            cur.execute('INSERT INTO trans_inputs (transid,inputid) VALUES (%s,%s)',(transid,inp_id))
        # print('[+] OUTPUT ADDRESSES')
        for no, output in enumerate(tx.outputs):
            # print("tx=%s outputno=%d type=%s value=%s" % (tx.hash, no, output.type, output.value),output.addresses)
            cur.execute('INSERT INTO outputs (txid, outputno,type,value) VALUES (%s,%s,%s,%s)',(tx.hash, no, output.type,output.value))
            outputid = cur.lastrowid
            cur.execute('INSERT INTO trans_outputs (transid,outputid) VALUES (%s,%s)',(transid,outputid))
            for addr in output.addresses:
                cur.execute('INSERT INTO ADDRESSES (addr) VALUES (%s)',(addr.address,))
                addrid = cur.lastrowid
                cur.execute('INSERT INTO addresses_outputs (outputid,addressid) VALUES (%s,%s)',(outputid,addrid))
    #     if no > 0:
    #         counter -= 1
    # c2 += 1
    db.commit()

cur.close()
db.close()


