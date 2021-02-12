create table financial_loss_risk
(
    id              uuid    not null
        constraint financial_loss_risk_pkey
            primary key,
    judgment_date   date,
    interest        numeric(19, 2),
    loss            numeric(19, 2),
    proceeding_cost numeric(19, 2),
    isActive        boolean,
    isActive2       boolean not null
);

create table initiation_type
(
    id   uuid not null
        constraint initiation_type_pkey
            primary key,
    name varchar(255)
);

create table cassation_appeal
(
    id                     uuid not null
        constraint cassation_appeal_pkey
            primary key,
    interest               numeric(19, 2),
    judgment_date          date,
    payment_due            numeric(19, 2),
    proceeding_cost        numeric(19, 2)
        constraint fktmyi4rw0ijoix1yr8jnsgtulv
            references financial_loss_risk (loss),
    judgment_content_id    uuid
        constraint fktmyi4rw0ijoix1yr8jnsgtulv
            references financial_loss_risk,
    judgment_evaluation_id uuid
        constraint fkosahw20lnfejca66jaa43o8j7
            references initiation_type
);

create table rev_entity
(
    id        bigint not null
        constraint rev_entity_pkey
            primary key,
    timestamp timestamp,
    revtype   smallint,
    constraint cassation_appeal_audit_pkey
        primary key (id)
);