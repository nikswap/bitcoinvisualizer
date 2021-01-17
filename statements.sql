-- Find output id for address
SELECT
    outputid
FROM
    addresses_outputs
    INNER JOIN
    addresses ON addresses.id = addresses_outputs.addressid
WHERE    
    addresses.addr = '<address to find>'
;

-- Find output no and transaction id for a given address
SELECT
        txid
    ,   outputno
FROM
    outputs
WHERE
    outputs.id IN (
        SELECT
            outputid
        FROM
            addresses_outputs
            INNER JOIN
            addresses ON addresses.id = addresses_outputs.addressid
        WHERE    
            addresses.addr = '<address to find>'
    )
;

-- find input transactions ids given a trans id and output no to search for
SELECT
        inputs.txid
    ,   inputs.outputno
FROM
    transactions
    INNER JOIN 
        trans_inputs ON trans_inputs.transid = transactions.id
    INNER JOIN 
        inputs ON trans_inputs.inputid = inputs.id
WHERE
    transactions.txid = '<trans id at søge efter>'
--        AND
--     inputs.outputno = <output no to find>
;

-- Find address given transaction id
SELECT
    addresses.addr
FROM
    addresses_outputs
    INNER JOIN
        outputs ON addresses_outputs.outputid = outputs.id
    INNER JOIN
        addresses ON addresses_outputs.addressid = addresses.id
WHERE
    outputs.txid = '<trans id to find>'
        AND
    outputs.outputno = <output no to find> -- This is the output id from the outputs table. NOT from the inputs
;

-- Delete all data from tables
truncate inputs;
truncate outputs;
truncate addresses;
truncate transactions;
truncate addresses_outputs;
truncate trans_inputs;
truncate trans_outputs;