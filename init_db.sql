create database bitcoin;
use bitcoin;

CREATE TABLE inputs (
        id          int PRIMARY KEY AUTO_INCREMENT
    ,   txid        CHAR(64)
    ,   outputno    INTEGER
);

CREATE TABLE addresses (
        id      int PRIMARY KEY AUTO_INCREMENT
    ,   addr    CHAR(40)
);

CREATE TABLE addresses_outputs (
        outputid    INTEGER
    ,   addressid   INTEGER
);

CREATE TABLE outputs (
        id          int PRIMARY KEY AUTO_INCREMENT
    ,   txid        CHAR(64)
    ,   outputno    INTEGER
    ,   value       BIGINT
    ,   type        ENUM('pubkeyhash','pubkey','p2sh','multisig','p2wpkh','p2wsh','unknown')
);

CREATE TABLE trans_inputs (
        transid     INTEGER
    ,   inputid     INTEGER
);

CREATE TABLE trans_outputs (
        transid     INTEGER
    ,   outputid     INTEGER
);

CREATE TABLE transactions (
        id              int PRIMARY KEY AUTO_INCREMENT
    ,   txid            CHAR(64)
    ,   transactiondate DATETIME
);

CREATE INDEX transaction_txid_idx ON transactions (txid);
CREATE INDEX outputs_txid_outputno ON outputs (txid,outputno);
CREATE INDEX inputs_outputno ON inputs (outputno);
CREATE UNIQUE INDEX inputs_uniq_trans_output ON inputs (txid, outputno);
CREATE UNIQUE INDEX addresses_addr_idx ON addresses (addr);

create user 'bitcoin'@'<your ip here>' identified by 'password';
GRANT  alter,create,delete,drop,index,insert,select,update,trigger,alter routine,
create routine, execute, create temporary tables ON bitcoin.* to 'bitcoin'@'<your ip here>';