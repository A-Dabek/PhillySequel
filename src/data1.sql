create table financial_loss_risk
(
    id              uuid not null
        constraint financial_loss_risk_pkey
            primary key,
    interest        numeric(19, 2),
    loss            numeric(19, 2),
    proceeding_cost numeric(19, 2)
);

alter table financial_loss_risk
    owner to postgres;

create table initiation_type
(
    id   uuid not null
        constraint initiation_type_pkey
            primary key,
    name varchar(255)
);


alter table judgment_content
    owner to postgres;

create table cassation_appeal
(
    id                            uuid not null
        constraint cassation_appeal_pkey
            primary key,
    interest                      numeric(19, 2),
    judgment_date                 date,
    payment_due                   numeric(19, 2),
    proceeding_cost               numeric(19, 2),
    judgment_content_id           uuid
        constraint fktmyi4rw0ijoix1yr8jnsgtulv
            references judgment_content,
    judgment_evaluation_id        uuid
        constraint fkosahw20lnfejca66jaa43o8j7
            references cassation_appeal_judgment_evaluation,
    cassation_appeal_statement_id uuid
        constraint fkdnqnc6c6529vri1mem79qb140
            references cassation_appeal_statement
);