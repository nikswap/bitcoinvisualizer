CREATE TABLE inputs (
        id          INTEGER
    ,   txid        CHAR(64)
    ,   outputno    INTEGER
);

CREATE TABLE addresses (
        id      INTEGER
    ,   addr    CHAR(33)
);

CREATE TABLE addresses_outputs (
        outputid    INTEGER
    ,   addressid   INTEGER
);

CREATE TABLE outputs (
        id          INTEGER
    ,   txid        CHAR(64)
    ,   outputno    INTEGER
    ,   value       INTEGER
    ,   type        ENUM(pubkeyhash,....)
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
        id              INTEGER
    ,   txid            CHAR(64)
    ,   transactiondate DATETIME
);

CREATE INDEX transaction_txid_idx ON transactions (txid);
CREATE INDEX outputs_txid_outputno ON outputs (txid,outputno);
CREATE INDEX inputs_outputno ON inputs (outputno);