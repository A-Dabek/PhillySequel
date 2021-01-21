create table case_category
(
	id uuid not null
		constraint case_category_pkey
			primary key,
	name varchar(255),
	proceeding_type varchar(255)
);

alter table case_category owner to postgres;

create table cassation_appeal_judgment_evaluation
(
	id uuid not null
		constraint cassation_appeal_judgment_evaluation_pkey
			primary key,
	name varchar(255)
);

alter table cassation_appeal_judgment_evaluation owner to postgres;

create table cassation_appeal_statement
(
	id uuid not null
		constraint cassation_appeal_statement_pkey
			primary key,
	name varchar(255)
);

alter table cassation_appeal_statement owner to postgres;

create table civil_proceeding_type
(
	id uuid not null
		constraint civil_proceeding_type_pkey
			primary key,
	name varchar(255)
);

alter table civil_proceeding_type owner to postgres;

create table claims_limitation_start_event
(
	id uuid not null
		constraint claims_limitation_start_event_pkey
			primary key,
	name varchar(255)
);

alter table claims_limitation_start_event owner to postgres;

create table client_details
(
	type varchar(31) not null,
	id uuid not null
		constraint client_details_pkey
			primary key,
	cif varchar(255),
	krs varchar(255),
	name varchar(255),
	nip varchar(255),
	pesel varchar(255),
	regon varchar(255),
	surname varchar(255),
	attorney varchar(255)
);

alter table client_details owner to postgres;

create table company_image
(
	id uuid not null
		constraint company_image_pkey
			primary key,
	name varchar(255)
);

alter table company_image owner to postgres;

create table court
(
	id uuid not null
		constraint court_pkey
			primary key,
	name varchar(255),
	type varchar(255)
);

alter table court owner to postgres;

create table court_instance_judgment_evaluation
(
	id uuid not null
		constraint court_instance_judgment_evaluation_pkey
			primary key,
	name varchar(255)
);

alter table court_instance_judgment_evaluation owner to postgres;

create table cudo_blockade_comment
(
	id uuid not null
		constraint cudo_blockade_comment_pkey
			primary key,
	comment varchar(255)
);

alter table cudo_blockade_comment owner to postgres;

create table current_proceeding_status
(
	id uuid not null
		constraint current_proceeding_status_pkey
			primary key,
	proceeding_type varchar(255),
	status varchar(255),
	status_type varchar(255)
);

alter table current_proceeding_status owner to postgres;

create table debt_recoverybgk
(
	id uuid not null
		constraint debt_recoverybgk_pkey
			primary key,
	name varchar(255)
);

alter table debt_recoverybgk owner to postgres;

create table disputed_bank_unit
(
	id uuid not null
		constraint disputed_bank_unit_pkey
			primary key,
	name varchar(255)
);

alter table disputed_bank_unit owner to postgres;

create table dispute_product
(
	id uuid not null
		constraint dispute_product_pkey
			primary key,
	name varchar(255)
);

alter table dispute_product owner to postgres;

create table distributor_bank
(
	id uuid not null
		constraint distributor_bank_pkey
			primary key,
	name varchar(255)
);

alter table distributor_bank owner to postgres;

create table financial_loss_risk
(
	id uuid not null
		constraint financial_loss_risk_pkey
			primary key,
	interest numeric(19,2),
	loss numeric(19,2),
	proceeding_cost numeric(19,2)
);

alter table financial_loss_risk owner to postgres;

create table initiation_type
(
	id uuid not null
		constraint initiation_type_pkey
			primary key,
	name varchar(255)
);

alter table initiation_type owner to postgres;

create table instance_judgment_content
(
	id uuid not null
		constraint instance_judgment_content_pkey
			primary key,
	name varchar(255)
);

alter table instance_judgment_content owner to postgres;

create table instance_statement
(
	id uuid not null
		constraint instance_statement_pkey
			primary key,
	statement_name varchar(255)
);

alter table instance_statement owner to postgres;

create table judgment_content
(
	id uuid not null
		constraint judgment_content_pkey
			primary key,
	name varchar(255)
);

alter table judgment_content owner to postgres;

create table cassation_appeal
(
	id uuid not null
		constraint cassation_appeal_pkey
			primary key,
	interest numeric(19,2),
	judgment_date date,
	payment_due numeric(19,2),
	proceeding_cost numeric(19,2),
	judgment_content_id uuid
		constraint fktmyi4rw0ijoix1yr8jnsgtulv
			references judgment_content,
	judgment_evaluation_id uuid
		constraint fkosahw20lnfejca66jaa43o8j7
			references cassation_appeal_judgment_evaluation,
	cassation_appeal_statement_id uuid
		constraint fkdnqnc6c6529vri1mem79qb140
			references cassation_appeal_statement
);

alter table cassation_appeal owner to postgres;

create table law_office
(
	id uuid not null
		constraint law_office_pkey
			primary key,
	email varchar(255),
	name varchar(255),
	street varchar(255)
);

alter table law_office owner to postgres;

create table proceeding_supervisor
(
	id uuid not null
		constraint proceeding_supervisor_pkey
			primary key,
	name varchar(255),
	surname varchar(255)
);

alter table proceeding_supervisor owner to postgres;

create table product_currency
(
	id uuid not null
		constraint product_currency_pkey
			primary key,
	name varchar(255)
);

alter table product_currency owner to postgres;

create table prosecute_subject
(
	id uuid not null
		constraint prosecute_subject_pkey
			primary key,
	name varchar(255)
);

alter table prosecute_subject owner to postgres;

create table reserve
(
	id uuid not null
		constraint reserve_pkey
			primary key,
	edcc_number varchar(255),
	remaining_specific_reserve numeric(19,2),
	reserve_comment varchar(255),
	reserve_creation_date date,
	reserve_legal_risk numeric(19,2),
	reserve_termination_or_use_date date,
	reserve_total numeric(19,2)
);

alter table reserve owner to postgres;

create index idxeoeont41beoluu26toojtqke2
	on reserve (edcc_number);

create table restructuring_proceeding_type
(
	id uuid not null
		constraint restructuring_proceeding_type_pkey
			primary key,
	type varchar(255)
);

alter table restructuring_proceeding_type owner to postgres;

create table rev_entity
(
	id bigint not null
		constraint rev_entity_pkey
			primary key,
	timestamp timestamp
);

alter table rev_entity owner to postgres;

create table administrative_proceeding_proceeding_suspension_audit
(
	rev bigint not null
		constraint fkak880w7x62fuu89b1hkja8t1d
			references rev_entity,
	proceeding_suspension_id uuid not null,
	id uuid not null,
	revtype smallint,
	constraint administrative_proceeding_proceeding_suspension_audit_pkey
		primary key (rev, proceeding_suspension_id, id)
);

alter table administrative_proceeding_proceeding_suspension_audit owner to postgres;

create table ams_numbers_audit
(
	rev bigint not null
		constraint fkctyjomefhpqf4govjpx1d7wpk
			references rev_entity,
	proceeding_id uuid not null,
	ams_numbers varchar(255) not null,
	revtype smallint,
	number varchar(255) not null,
	constraint ams_numbers_audit_pkey
		primary key (rev, proceeding_id, ams_numbers)
);

alter table ams_numbers_audit owner to postgres;

create table bank_account_numbers_audit
(
	rev bigint not null
		constraint fktqbcn6gdmdkhrxe1lxvai0sf4
			references rev_entity,
	proceeding_id uuid not null,
	bank_account_numbers varchar(255) not null,
	revtype smallint,
	constraint bank_account_numbers_audit_pkey
		primary key (rev, proceeding_id, bank_account_numbers)
);

alter table bank_account_numbers_audit owner to postgres;

create table case_category_audit
(
	id uuid not null,
	rev bigint not null
		constraint fk30dspadvsn6makgm9ytcxmbln
			references rev_entity,
	revtype smallint,
	name varchar(255),
	proceeding_type varchar(255),
	constraint case_category_audit_pkey
		primary key (id, rev)
);

alter table case_category_audit owner to postgres;

create table cassation_appeal_audit
(
	id uuid not null,
	rev bigint not null
		constraint fkndke09oddky16cc0mj92d9078
			references rev_entity,
	revtype smallint,
	interest numeric(19,2),
	judgment_date date,
	payment_due numeric(19,2),
	proceeding_cost numeric(19,2),
	judgment_content_id uuid,
	judgment_evaluation_id uuid,
	cassation_appeal_statement_id uuid,
	constraint cassation_appeal_audit_pkey
		primary key (id, rev)
);

alter table cassation_appeal_audit owner to postgres;

create table cassation_appeal_judgment_evaluation_audit
(
	id uuid not null,
	rev bigint not null
		constraint fkpjttxjw6lgdqn8u1ve298331j
			references rev_entity,
	revtype smallint,
	name varchar(255),
	constraint cassation_appeal_judgment_evaluation_audit_pkey
		primary key (id, rev)
);

alter table cassation_appeal_judgment_evaluation_audit owner to postgres;

create table cassation_appeal_statement_audit
(
	id uuid not null,
	rev bigint not null
		constraint fk9mhuec95qtc2ysk7xtla9sbqp
			references rev_entity,
	revtype smallint,
	name varchar(255),
	constraint cassation_appeal_statement_audit_pkey
		primary key (id, rev)
);

alter table cassation_appeal_statement_audit owner to postgres;

create table civil_proceeding_type_audit
(
	id uuid not null,
	rev bigint not null
		constraint fk8kruog75jdvabt51qdhpvy90m
			references rev_entity,
	revtype smallint,
	name varchar(255),
	constraint civil_proceeding_type_audit_pkey
		primary key (id, rev)
);

alter table civil_proceeding_type_audit owner to postgres;

create table claims_limitation_start_event_audit
(
	id uuid not null,
	rev bigint not null
		constraint fk57nu3w9ra5nmy0l7q2aenqmb2
			references rev_entity,
	revtype smallint,
	name varchar(255),
	constraint claims_limitation_start_event_audit_pkey
		primary key (id, rev)
);

alter table claims_limitation_start_event_audit owner to postgres;

create table client_details_audit
(
	id uuid not null,
	rev bigint not null
		constraint fkax1h2x1xv9q3gliig8tbwt692
			references rev_entity,
	type varchar(31) not null,
	revtype smallint,
	cif varchar(255),
	krs varchar(255),
	name varchar(255),
	nip varchar(255),
	pesel varchar(255),
	regon varchar(255),
	surname varchar(255),
	attorney varchar(255),
	constraint client_details_audit_pkey
		primary key (id, rev)
);

alter table client_details_audit owner to postgres;

create table company_image_audit
(
	id uuid not null,
	rev bigint not null
		constraint fks47pbt1e9s04voyvi1oqebndh
			references rev_entity,
	revtype smallint,
	name varchar(255),
	constraint company_image_audit_pkey
		primary key (id, rev)
);

alter table company_image_audit owner to postgres;

create table court_audit
(
	id uuid not null,
	rev bigint not null
		constraint fk1dg6hhmpmcu0xppy9s9im2k12
			references rev_entity,
	revtype smallint,
	name varchar(255),
	type varchar(255),
	constraint court_audit_pkey
		primary key (id, rev)
);

alter table court_audit owner to postgres;

create table court_instance_judgment_evaluation_audit
(
	id uuid not null,
	rev bigint not null
		constraint fkdae5pvoln35so5dqg26vc66ho
			references rev_entity,
	revtype smallint,
	name varchar(255),
	constraint court_instance_judgment_evaluation_audit_pkey
		primary key (id, rev)
);

alter table court_instance_judgment_evaluation_audit owner to postgres;

create table court_instance_result_audit
(
	id uuid not null,
	rev bigint not null
		constraint fk2u1sca89jt75i2cqt2tdurgrg
			references rev_entity,
	revtype smallint,
	instance_interest numeric(19,2),
	instance_judgment_date date,
	instance_payment_due numeric(19,2),
	instance_proceeding_cost numeric(19,2),
	instance_type integer,
	court_instance_judgment_evaluation_id uuid,
	instance_judgment_content_id uuid,
	instance_statement_id uuid,
	instance_judgment_evaluation_id uuid,
	constraint court_instance_result_audit_pkey
		primary key (id, rev)
);

alter table court_instance_result_audit owner to postgres;

create table cudo_blockade_comment_audit
(
	id uuid not null,
	rev bigint not null
		constraint fkpcgi2oyclccnec9la253sl9hg
			references rev_entity,
	revtype smallint,
	comment varchar(255),
	constraint cudo_blockade_comment_audit_pkey
		primary key (id, rev)
);

alter table cudo_blockade_comment_audit owner to postgres;

create table current_proceeding_status_audit
(
	id uuid not null,
	rev bigint not null
		constraint fk15ns825iewgo6sjvlasmg208i
			references rev_entity,
	revtype smallint,
	proceeding_type varchar(255),
	status varchar(255),
	status_type varchar(255),
	constraint current_proceeding_status_audit_pkey
		primary key (id, rev)
);

alter table current_proceeding_status_audit owner to postgres;

create table debt_recoverybgk_audit
(
	id uuid not null,
	rev bigint not null
		constraint fkhuvc6bnv15r3245ik5et627ki
			references rev_entity,
	revtype smallint,
	name varchar(255),
	constraint debt_recoverybgk_audit_pkey
		primary key (id, rev)
);

alter table debt_recoverybgk_audit owner to postgres;

create table defendant_bank_proceeding_proceeding_suspension_audit
(
	rev bigint not null
		constraint fkf34ig57kr3ixyn9tdvde5dn8j
			references rev_entity,
	proceeding_suspension_id uuid not null,
	id uuid not null,
	revtype smallint,
	constraint defendant_bank_proceeding_proceeding_suspension_audit_pkey
		primary key (rev, proceeding_suspension_id, id)
);

alter table defendant_bank_proceeding_proceeding_suspension_audit owner to postgres;

create table dispute_product_audit
(
	id uuid not null,
	rev bigint not null
		constraint fkaaexwvg4fj7l5u0ufuigiote6
			references rev_entity,
	revtype smallint,
	name varchar(255),
	constraint dispute_product_audit_pkey
		primary key (id, rev)
);

alter table dispute_product_audit owner to postgres;

create table disputed_bank_unit_audit
(
	id uuid not null,
	rev bigint not null
		constraint fk1nolti7w18pyl02he18glh7vm
			references rev_entity,
	revtype smallint,
	name varchar(255),
	constraint disputed_bank_unit_audit_pkey
		primary key (id, rev)
);

alter table disputed_bank_unit_audit owner to postgres;

create table distributor_bank_audit
(
	id uuid not null,
	rev bigint not null
		constraint fki6b0gmb9yghba25a7efyqdatk
			references rev_entity,
	revtype smallint,
	name varchar(255),
	constraint distributor_bank_audit_pkey
		primary key (id, rev)
);

alter table distributor_bank_audit owner to postgres;

create table file_info_audit
(
	id uuid not null,
	rev bigint not null
		constraint fk66cgx87hvsne3f6t6d8wpusdv
			references rev_entity,
	revtype smallint,
	alfresco_id varchar(255),
	create_date timestamp,
	name varchar(255),
	proceeding_id uuid,
	constraint file_info_audit_pkey
		primary key (id, rev)
);

alter table file_info_audit owner to postgres;

create table financial_loss_risk_audit
(
	id uuid not null,
	rev bigint not null
		constraint fk2im37gyxcbahaf8hqnvi4fo0h
			references rev_entity,
	revtype smallint,
	interest numeric(19,2),
	loss numeric(19,2),
	proceeding_cost numeric(19,2),
	constraint financial_loss_risk_audit_pkey
		primary key (id, rev)
);

alter table financial_loss_risk_audit owner to postgres;

create table initiation_type_audit
(
	id uuid not null,
	rev bigint not null
		constraint fk3enf5d65lhh38dhnsuilfm98h
			references rev_entity,
	revtype smallint,
	name varchar(255),
	constraint initiation_type_audit_pkey
		primary key (id, rev)
);

alter table initiation_type_audit owner to postgres;

create table instance_judgment_content_audit
(
	id uuid not null,
	rev bigint not null
		constraint fkbs4v6trm5bs199t257h1bdbf0
			references rev_entity,
	revtype smallint,
	name varchar(255),
	constraint instance_judgment_content_audit_pkey
		primary key (id, rev)
);

alter table instance_judgment_content_audit owner to postgres;

create table instance_statement_audit
(
	id uuid not null,
	rev bigint not null
		constraint fkgipiel8lxt31tc2jqowaaw7jl
			references rev_entity,
	revtype smallint,
	statement_name varchar(255),
	constraint instance_statement_audit_pkey
		primary key (id, rev)
);

alter table instance_statement_audit owner to postgres;

create table judgment_content_audit
(
	id uuid not null,
	rev bigint not null
		constraint fkhn7hidl0fdk2pkaqeoq1x21hq
			references rev_entity,
	revtype smallint,
	name varchar(255),
	constraint judgment_content_audit_pkey
		primary key (id, rev)
);

alter table judgment_content_audit owner to postgres;

create table law_office_audit
(
	id uuid not null,
	rev bigint not null
		constraint fk1i6hj538vxmds4mp4u8nac986
			references rev_entity,
	revtype smallint,
	email varchar(255),
	name varchar(255),
	street varchar(255),
	constraint law_office_audit_pkey
		primary key (id, rev)
);

alter table law_office_audit owner to postgres;

create table plaintiff_bank_proceeding_proceeding_suspension_audit
(
	rev bigint not null
		constraint fk47cm20li9yakq2b7qoubacpqs
			references rev_entity,
	proceeding_suspension_id uuid not null,
	id uuid not null,
	revtype smallint,
	constraint plaintiff_bank_proceeding_proceeding_suspension_audit_pkey
		primary key (rev, proceeding_suspension_id, id)
);

alter table plaintiff_bank_proceeding_proceeding_suspension_audit owner to postgres;

create table proceeding_audit
(
	id uuid not null,
	rev bigint not null
		constraint fk3th3mtvh5pq8bn8i61m4jgjer
			references rev_entity,
	type varchar(31) not null,
	revtype smallint,
	contact_person varchar(255),
	coordinator_id uuid,
	creation_date timestamp,
	cudo_blockade_end_date date,
	is_active boolean default true,
	is_bank_client boolean,
	last_update_date timestamp,
	proceeding_id varchar(255),
	proceeding_initiation_date date,
	proceeding_status_change_date date,
	proceeding_status_description varchar(255),
	signature varchar(255),
	supervisor_id uuid,
	trial_attorney_id uuid,
	company_image_id uuid,
	court_id uuid,
	cudo_blockade_comment_id uuid,
	law_office_id uuid,
	current_proceeding_status_id uuid,
	dispute_reason varchar(255),
	dispute_subject_amount numeric(19,2),
	estimated_funds_effluence_risk varchar(255),
	expected_final_completion_date date,
	immediate_enforceability_rigor boolean,
	payment_order_date date,
	payment_order_repeal_date date,
	plaintiff_bank varchar(255),
	win_proceeding_rate double precision,
	civil_proceeding_type_id uuid,
	distributor_bank_id uuid,
	segment_id uuid,
	risk_assessment_method_id uuid,
	client_status varchar(255),
	opponent varchar(255),
	proceeding_end_date date,
	proceeding_result varchar(255),
	claims_limitation_start_date date,
	defendant_bank bigint,
	heracles_id varchar(255),
	is_class_action boolean,
	loss_amount numeric(19,2),
	proceeding_path_type varchar(255),
	witness_call_date date,
	claims_limitation_start_event_id uuid,
	financial_loss_risk_id uuid,
	reserve_id uuid,
	bank_status varchar(255),
	cassation_judgment_content varchar(255),
	cassation_judgment_date date,
	criminal_qualification_act varchar(255),
	preparatory_proceeding_signature varchar(255),
	prescriptive_judgment_date date,
	prescriptive_judgment_repeal_date date,
	administrative_authority varchar(255),
	amount_concerned_proceeding numeric(19,2),
	prosecute_subject_date date,
	prosecute_subject_signature varchar(255),
	initiation_type_id uuid,
	prosecute_subject_id uuid,
	active_flag boolean,
	ams_number varchar(255),
	capital_amount numeric(19,2),
	consumer_bankruptcy varchar(255),
	isbgkwarranty_active boolean,
	debt_recovery_bgk_id uuid,
	restructuring_proceeding_type_id uuid,
	estimated_funds_effluence_risk_id uuid,
	client_status_id uuid,
	proceeding_result_id uuid,
	bank_status_id uuid,
	last_update_username varchar(255),
	constraint proceeding_audit_pkey
		primary key (id, rev)
);

alter table proceeding_audit owner to postgres;

create table proceeding_case_category_audit
(
	rev bigint not null
		constraint fk4pxnmu2c8uiuul1rmrwi6bemb
			references rev_entity,
	proceeding_id uuid not null,
	case_category_id uuid not null,
	revtype smallint,
	constraint proceeding_case_category_audit_pkey
		primary key (rev, proceeding_id, case_category_id)
);

alter table proceeding_case_category_audit owner to postgres;

create table proceeding_client_audit
(
	rev bigint not null
		constraint fkgbertr3n3jxn8w810dqg95cv4
			references rev_entity,
	proceeding_id uuid not null,
	client_id uuid not null,
	revtype smallint,
	constraint proceeding_client_audit_pkey
		primary key (rev, proceeding_id, client_id)
);

alter table proceeding_client_audit owner to postgres;

create table proceeding_court_instance_result_audit
(
	rev bigint not null
		constraint fkjjey72wcc4uy72p69s6497cw3
			references rev_entity,
	court_instance_result_id uuid not null,
	id uuid not null,
	revtype smallint,
	proceeding_id uuid not null,
	constraint proceeding_court_instance_result_audit_pkey
		primary key (rev, court_instance_result_id, id)
);

alter table proceeding_court_instance_result_audit owner to postgres;

create table proceeding_dispute_product_audit
(
	rev bigint not null
		constraint fk9ecpa3do0710k6uw97n3crq6j
			references rev_entity,
	proceeding_id uuid not null,
	dispute_product_id uuid not null,
	revtype smallint,
	constraint proceeding_dispute_product_audit_pkey
		primary key (rev, proceeding_id, dispute_product_id)
);

alter table proceeding_dispute_product_audit owner to postgres;

create table proceeding_disputed_bank_unit_audit
(
	rev bigint not null
		constraint fkah4pq0n425lcn68uwj03rql6g
			references rev_entity,
	proceeding_id uuid not null,
	disputed_bank_unit_id uuid not null,
	revtype smallint,
	constraint proceeding_disputed_bank_unit_audit_pkey
		primary key (rev, proceeding_id, disputed_bank_unit_id)
);

alter table proceeding_disputed_bank_unit_audit owner to postgres;

create table proceeding_product_currency_audit
(
	rev bigint not null
		constraint fkm95w4f29v543oefgl1pdkkjb3
			references rev_entity,
	proceeding_id uuid not null,
	product_currency_id uuid not null,
	revtype smallint,
	constraint proceeding_product_currency_audit_pkey
		primary key (rev, proceeding_id, product_currency_id)
);

alter table proceeding_product_currency_audit owner to postgres;

create table proceeding_reserve_audit
(
	rev bigint not null
		constraint fkqe5lvqbwh4oss0j0p47gv82cq
			references rev_entity,
	proceeding_id uuid not null,
	reserve_id uuid not null,
	revtype smallint,
	constraint proceeding_reserve_audit_pkey
		primary key (rev, proceeding_id, reserve_id)
);

alter table proceeding_reserve_audit owner to postgres;

create table proceeding_supervisor_audit
(
	id uuid not null,
	rev bigint not null
		constraint fk1ps6vhyy26ndgnfc6ff5hnvhq
			references rev_entity,
	revtype smallint,
	name varchar(255),
	surname varchar(255),
	constraint proceeding_supervisor_audit_pkey
		primary key (id, rev)
);

alter table proceeding_supervisor_audit owner to postgres;

create table proceeding_suspension_audit
(
	id uuid not null,
	rev bigint not null
		constraint fkh65de0tos6sissp3fn4jgdty7
			references rev_entity,
	revtype smallint,
	proceeding_resumption_date date,
	proceeding_suspension_date date,
	constraint proceeding_suspension_audit_pkey
		primary key (id, rev)
);

alter table proceeding_suspension_audit owner to postgres;

create table product_currency_audit
(
	id uuid not null,
	rev bigint not null
		constraint fkbo2rlrhept1qlx8ojjhbvgccw
			references rev_entity,
	revtype smallint,
	name varchar(255),
	constraint product_currency_audit_pkey
		primary key (id, rev)
);

alter table product_currency_audit owner to postgres;

create table prosecute_subject_audit
(
	id uuid not null,
	rev bigint not null
		constraint fko2tvpdxu2k6i9uaxqpu1spu68
			references rev_entity,
	revtype smallint,
	name varchar(255),
	constraint prosecute_subject_audit_pkey
		primary key (id, rev)
);

alter table prosecute_subject_audit owner to postgres;

create table reserve_audit
(
	id uuid not null,
	rev bigint not null
		constraint fk6v75sqnm1ouqgebfrql9scf60
			references rev_entity,
	revtype smallint,
	edcc_number varchar(255),
	remaining_specific_reserve numeric(19,2),
	reserve_comment varchar(255),
	reserve_creation_date date,
	reserve_legal_risk numeric(19,2),
	reserve_termination_or_use_date date,
	reserve_total numeric(19,2),
	constraint reserve_audit_pkey
		primary key (id, rev)
);

alter table reserve_audit owner to postgres;

create table restructuring_proceeding_type_audit
(
	id uuid not null,
	rev bigint not null
		constraint fk7yjgmjbcmxl81eii60l7ca1pp
			references rev_entity,
	revtype smallint,
	type varchar(255),
	constraint restructuring_proceeding_type_audit_pkey
		primary key (id, rev)
);

alter table restructuring_proceeding_type_audit owner to postgres;

create table risk_assessment_method_audit
(
	id uuid not null,
	rev bigint not null
		constraint fkk400ui20xgcauaber8hn5eqni
			references rev_entity,
	revtype smallint,
	name varchar(255),
	constraint risk_assessment_method_audit_pkey
		primary key (id, rev)
);

alter table risk_assessment_method_audit owner to postgres;

create table risk_assessment_method
(
	id uuid not null
		constraint risk_assessment_method_pkey
			primary key,
	name varchar(255)
);

alter table risk_assessment_method owner to postgres;

create table segment
(
	id uuid not null
		constraint segment_pkey
			primary key,
	name varchar(255)
);

alter table segment owner to postgres;

create table segment_audit
(
	id uuid not null,
	rev bigint not null
		constraint fk5jsip18hnotxuhnv9lhf3quw6
			references rev_entity,
	revtype smallint,
	name varchar(255),
	constraint segment_audit_pkey
		primary key (id, rev)
);

alter table segment_audit owner to postgres;

create table witnesses_audit
(
	rev bigint not null
		constraint fkgybtt0kj0l3fmirk3tojfa22w
			references rev_entity,
	proceeding_id uuid not null,
	witness_id uuid not null,
	revtype smallint,
	constraint witnesses_audit_pkey
		primary key (rev, proceeding_id, witness_id)
);

alter table witnesses_audit owner to postgres;

create table proceeding_civil_proceeding_type_audit
(
	rev bigint not null
		constraint fkqo31m3lb48hhhxnjdpwseyx3c
			references rev_entity,
	proceeding_id uuid not null,
	civil_proceeding_type_id uuid not null,
	revtype smallint,
	constraint proceeding_civil_proceeding_type_audit_pkey
		primary key (rev, proceeding_id, civil_proceeding_type_id)
);

alter table proceeding_civil_proceeding_type_audit owner to postgres;

create table bank_status_audit
(
	id uuid not null,
	rev bigint not null
		constraint fk59cakg41pqpm3euakaqdssg0n
			references rev_entity,
	revtype smallint,
	name varchar(255),
	constraint bank_status_audit_pkey
		primary key (id, rev)
);

alter table bank_status_audit owner to postgres;

create table bank_status
(
	id uuid not null
		constraint bank_status_pkey
			primary key,
	name varchar(255)
);

alter table bank_status owner to postgres;

create table client_status_audit
(
	id uuid not null,
	rev bigint not null
		constraint fkbg4te2008f6cbv4p1fsevrsad
			references rev_entity,
	revtype smallint,
	name varchar(255),
	constraint client_status_audit_pkey
		primary key (id, rev)
);

alter table client_status_audit owner to postgres;

create table client_status
(
	id uuid not null
		constraint client_status_pkey
			primary key,
	name varchar(255)
);

alter table client_status owner to postgres;

create table estimated_funds_effluence_risk_audit
(
	id uuid not null,
	rev bigint not null
		constraint fk193mkux929157yf110n53jf57
			references rev_entity,
	revtype smallint,
	name varchar(255),
	constraint estimated_funds_effluence_risk_audit_pkey
		primary key (id, rev)
);

alter table estimated_funds_effluence_risk_audit owner to postgres;

create table estimated_funds_effluence_risk
(
	id uuid not null
		constraint estimated_funds_effluence_risk_pkey
			primary key,
	name varchar(255)
);

alter table estimated_funds_effluence_risk owner to postgres;

create table proceeding_result_audit
(
	id uuid not null,
	rev bigint not null
		constraint fkdu9jim6o7fcjjv50uuok500x
			references rev_entity,
	revtype smallint,
	name varchar(255),
	constraint proceeding_result_audit_pkey
		primary key (id, rev)
);

alter table proceeding_result_audit owner to postgres;

create table proceeding_result
(
	id uuid not null
		constraint proceeding_result_pkey
			primary key,
	name varchar(255)
);

alter table proceeding_result owner to postgres;

create table proceeding
(
	type varchar(31) not null,
	id uuid not null
		constraint proceeding_pkey
			primary key,
	contact_person varchar(255),
	coordinator_id uuid,
	creation_date timestamp,
	cudo_blockade_end_date date,
	is_active boolean default true,
	is_bank_client boolean,
	last_update_date timestamp,
	proceeding_id varchar(255),
	proceeding_initiation_date date,
	proceeding_status_change_date date,
	proceeding_status_description varchar(255),
	signature varchar(255),
	supervisor_id uuid,
	trial_attorney_id uuid,
	administrative_authority varchar(255),
	amount_concerned_proceeding numeric(19,2),
	dispute_reason varchar(255),
	estimated_funds_effluence_risk varchar(255),
	expected_final_completion_date date,
	loss_amount numeric(19,2),
	prosecute_subject_date date,
	prosecute_subject_signature varchar(255),
	active_flag boolean,
	ams_number varchar(255),
	capital_amount numeric(19,2),
	consumer_bankruptcy varchar(255),
	isbgkwarranty_active boolean,
	proceeding_end_date date,
	bank_status varchar(255),
	cassation_judgment_content varchar(255),
	cassation_judgment_date date,
	criminal_qualification_act varchar(255),
	preparatory_proceeding_signature varchar(255),
	prescriptive_judgment_date date,
	prescriptive_judgment_repeal_date date,
	dispute_subject_amount numeric(19,2),
	claims_limitation_start_date date,
	client_status varchar(255),
	defendant_bank bigint,
	heracles_id varchar(255),
	immediate_enforceability_rigor boolean,
	is_class_action boolean,
	payment_order_date date,
	payment_order_repeal_date date,
	proceeding_path_type varchar(255),
	witness_call_date date,
	opponent varchar(255),
	proceeding_result varchar(255),
	plaintiff_bank varchar(255),
	win_proceeding_rate double precision,
	company_image_id uuid
		constraint fke7m20xgpc70og2b3r8dcw7fxx
			references company_image,
	court_id uuid
		constraint fkb2vas4r9mqbf3kla066n3cd46
			references court,
	cudo_blockade_comment_id uuid
		constraint fkmv2w8p4yif84ube60p88s7jis
			references cudo_blockade_comment,
	law_office_id uuid
		constraint fk3h3rf6co0834ajsikbd1dsnae
			references law_office,
	current_proceeding_status_id uuid
		constraint fkqag4cdjr7smgtmxy8dqrttjm2
			references current_proceeding_status,
	distributor_bank_id uuid
		constraint fk5wdovcwfd1fio6f629vyofpr7
			references distributor_bank,
	financial_loss_risk_id uuid
		constraint fkcffjqrjsggs4ybxo2q5xmo4ny
			references financial_loss_risk,
	initiation_type_id uuid
		constraint fke1xwl1eonw03746d2w2tl9j7
			references initiation_type,
	prosecute_subject_id uuid
		constraint fkpnrt3sq8h4r9utx9025hm7phq
			references prosecute_subject,
	reserve_id uuid
		constraint fk1sihpol3rjxxhwp33raxcqbwn
			references reserve,
	risk_assessment_method_id uuid
		constraint fk2suy3275yg6vl76osqqpv3lka
			references risk_assessment_method,
	debt_recovery_bgk_id uuid
		constraint fkj7m0mjv3o9g7t89mgivb9tflu
			references debt_recoverybgk,
	segment_id uuid
		constraint fkfo71xqidltbixjqe8x8rjhql2
			references segment,
	civil_proceeding_type_id uuid
		constraint fkb92nhxf5g1fwvviyjbec5bwan
			references civil_proceeding_type,
	claims_limitation_start_event_id uuid
		constraint fklhid2r08f41w9hnt4j5dep9t6
			references claims_limitation_start_event,
	restructuring_proceeding_type_id uuid
		constraint fkonsgf9dq6j88fsbnaix81q4ui
			references restructuring_proceeding_type,
	estimated_funds_effluence_risk_id uuid
		constraint fknvspgrthxg6evj9yaa880e444
			references estimated_funds_effluence_risk,
	bank_status_id uuid
		constraint fk156btrdm5668q2vpfaieh52ic
			references bank_status,
	client_status_id uuid
		constraint fkp6qf8ewj4ghh8nwlbho8xyeg
			references client_status,
	proceeding_result_id uuid
		constraint fksokfau3cd1h47njmtykjkfs7
			references proceeding_result,
	last_update_username varchar(255)
);

alter table proceeding owner to postgres;

create table ams_numbers
(
	proceeding_id uuid not null
		constraint fklf0vhpbkief85acq3wmuug4n0
			references proceeding,
	ams_numbers varchar(255),
	number varchar(255)
);

alter table ams_numbers owner to postgres;

create table bank_account_numbers
(
	proceeding_id uuid not null
		constraint fktn482ag1vf3s6jmq0x4vl1c45
			references proceeding,
	bank_account_numbers varchar(255)
);

alter table bank_account_numbers owner to postgres;

create table court_instance_result
(
	id uuid not null
		constraint court_instance_result_pkey
			primary key,
	instance_interest numeric(19,2),
	instance_judgment_date date,
	instance_payment_due numeric(19,2),
	instance_proceeding_cost numeric(19,2),
	instance_type integer,
	court_instance_judgment_evaluation_id uuid
		constraint fkh96oylojmnqoyscdy4yrwwacr
			references court_instance_judgment_evaluation,
	instance_judgment_content_id uuid
		constraint fk5xpabo01clauvt7ntw0jds7fm
			references instance_judgment_content,
	instance_statement_id uuid
		constraint fkmvurk7ad7uh4yvb2gfsh5c3qv
			references instance_statement,
	court_instance_result_id uuid
		constraint fk6p7ln9wyme3qtw05ke4b5esge
			references proceeding,
	instance_judgment_evaluation_id uuid
		constraint fkkox13768utg38lssrjffia5dh
			references court_instance_judgment_evaluation,
	proceeding_id uuid
		constraint fk957s11qc2u2aceecn268cvgk7
			references proceeding
);

alter table court_instance_result owner to postgres;

create table file_info
(
	id uuid not null
		constraint file_info_pkey
			primary key,
	alfresco_id varchar(255),
	create_date timestamp,
	name varchar(255),
	proceeding_id uuid
		constraint fkahi8x5kxkhnyb0tls53hhxqal
			references proceeding
);

alter table file_info owner to postgres;

create table proceeding_case_category
(
	proceeding_id uuid not null
		constraint fkheclthjw81tuynje60y3pk2ml
			references proceeding,
	case_category_id uuid not null
		constraint fktdjtey6q7ew4f63khu104mati
			references case_category
);

alter table proceeding_case_category owner to postgres;

create table proceeding_client
(
	proceeding_id uuid not null
		constraint fkkwb8nloek2h21ti57d9rp4tuw
			references proceeding,
	client_id uuid not null
		constraint fkh801c6d15op9r50a2f2qs9pbi
			references client_details
);

alter table proceeding_client owner to postgres;

create table proceeding_dispute_product
(
	proceeding_id uuid not null
		constraint fkn90quhl7b3oh3wtwqokbcdfgg
			references proceeding,
	dispute_product_id uuid not null
		constraint fk4tdxht9mw91kejp7tqghpw6so
			references dispute_product
);

alter table proceeding_dispute_product owner to postgres;

create table proceeding_disputed_bank_unit
(
	proceeding_id uuid not null
		constraint fkp43p4i4tl2tkogs18cnrusd1x
			references proceeding,
	disputed_bank_unit_id uuid not null
		constraint fk3ugw5vliwehgv46qbwbi4qiyd
			references disputed_bank_unit
);

alter table proceeding_disputed_bank_unit owner to postgres;

create table proceeding_product_currency
(
	proceeding_id uuid not null
		constraint fk1d46ckmjdnl245dyiuwipo88c
			references proceeding,
	product_currency_id uuid not null
		constraint fk41hu4mn3q8jqcgncrqgrrd2vc
			references product_currency
);

alter table proceeding_product_currency owner to postgres;

create table proceeding_reserve
(
	proceeding_id uuid not null
		constraint fk2cefjhv0yy257gsl5kc83ublg
			references proceeding,
	reserve_id uuid not null
		constraint fksytglu7i490vvqagwdtx06b26
			references reserve
);

alter table proceeding_reserve owner to postgres;

create table proceeding_suspension
(
	id uuid not null
		constraint proceeding_suspension_pkey
			primary key,
	proceeding_resumption_date date,
	proceeding_suspension_date date,
	proceeding_suspension_id uuid
		constraint fkm1r6tsxel62xu9xsn07n4fiqh
			references proceeding
);

alter table proceeding_suspension owner to postgres;

create table witnesses
(
	proceeding_id uuid not null
		constraint fkhouy18cssu5ba9f2ec0wcri0o
			references proceeding,
	witness_id uuid
);

alter table witnesses owner to postgres;

create table proceeding_civil_proceeding_type
(
	proceeding_id uuid not null
		constraint fknvwemqdle29t5vd774t1mj093
			references proceeding,
	civil_proceeding_type_id uuid not null
		constraint fkt036yulj86qyqg66jlvrf5rwn
			references civil_proceeding_type
);

alter table proceeding_civil_proceeding_type owner to postgres;

create table cudoreport
(
	id uuid not null
		constraint cudoreport_pkey
			primary key,
	content varchar(255),
	creation_date timestamp,
	response varchar(255)
);

alter table cudoreport owner to postgres;

create table shedlock
(
	name varchar(64) not null
		constraint shedlock_pkey
			primary key,
	lock_until timestamp not null,
	locked_at timestamp not null,
	locked_by varchar(255) not null
);

alter table shedlock owner to postgres;

