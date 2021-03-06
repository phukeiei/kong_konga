PGDMP     1                    x            kong    12.4    13.0 �               0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                        0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            !           1262    16384    kong    DATABASE     X   CREATE DATABASE kong WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.utf8';
    DROP DATABASE kong;
                kong    false            �            1255    16567    sync_tags()    FUNCTION     �  CREATE FUNCTION public.sync_tags() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
        BEGIN
          IF (TG_OP = 'TRUNCATE') THEN
            DELETE FROM tags WHERE entity_name = TG_TABLE_NAME;
            RETURN NULL;
          ELSIF (TG_OP = 'DELETE') THEN
            DELETE FROM tags WHERE entity_id = OLD.id;
            RETURN OLD;
          ELSE

          -- Triggered by INSERT/UPDATE
          -- Do an upsert on the tags table
          -- So we don't need to migrate pre 1.1 entities
          INSERT INTO tags VALUES (NEW.id, TG_TABLE_NAME, NEW.tags)
          ON CONFLICT (entity_id) DO UPDATE
                  SET tags=EXCLUDED.tags;
          END IF;
          RETURN NEW;
        END;
      $$;
 "   DROP FUNCTION public.sync_tags();
       public          kong    false            �            1259    17023    acls    TABLE     �   CREATE TABLE public.acls (
    id uuid NOT NULL,
    created_at timestamp with time zone DEFAULT timezone('UTC'::text, CURRENT_TIMESTAMP(0)),
    consumer_id uuid,
    "group" text,
    cache_key text,
    tags text[],
    ws_id uuid
);
    DROP TABLE public.acls;
       public         heap    kong    false            �            1259    17066    acme_storage    TABLE     �   CREATE TABLE public.acme_storage (
    id uuid NOT NULL,
    key text,
    value text,
    created_at timestamp with time zone,
    ttl timestamp with time zone
);
     DROP TABLE public.acme_storage;
       public         heap    kong    false            �            1259    16943    basicauth_credentials    TABLE     �   CREATE TABLE public.basicauth_credentials (
    id uuid NOT NULL,
    created_at timestamp with time zone DEFAULT timezone('UTC'::text, CURRENT_TIMESTAMP(0)),
    consumer_id uuid,
    username text,
    password text,
    tags text[],
    ws_id uuid
);
 )   DROP TABLE public.basicauth_credentials;
       public         heap    kong    false            �            1259    16585    ca_certificates    TABLE     �   CREATE TABLE public.ca_certificates (
    id uuid NOT NULL,
    created_at timestamp with time zone DEFAULT timezone('UTC'::text, CURRENT_TIMESTAMP(0)),
    cert text NOT NULL,
    tags text[],
    cert_digest text NOT NULL
);
 #   DROP TABLE public.ca_certificates;
       public         heap    kong    false            �            1259    16440    certificates    TABLE     �   CREATE TABLE public.certificates (
    id uuid NOT NULL,
    created_at timestamp with time zone DEFAULT timezone('UTC'::text, CURRENT_TIMESTAMP(0)),
    cert text,
    key text,
    tags text[],
    ws_id uuid
);
     DROP TABLE public.certificates;
       public         heap    kong    false            �            1259    16402    cluster_events    TABLE     �   CREATE TABLE public.cluster_events (
    id uuid NOT NULL,
    node_id uuid NOT NULL,
    at timestamp with time zone NOT NULL,
    nbf timestamp with time zone,
    expire_at timestamp with time zone NOT NULL,
    channel text,
    data text
);
 "   DROP TABLE public.cluster_events;
       public         heap    kong    false            �            1259    16466 	   consumers    TABLE     �   CREATE TABLE public.consumers (
    id uuid NOT NULL,
    created_at timestamp with time zone DEFAULT timezone('UTC'::text, CURRENT_TIMESTAMP(0)),
    username text,
    custom_id text,
    tags text[],
    ws_id uuid
);
    DROP TABLE public.consumers;
       public         heap    kong    false            �            1259    16745    hmacauth_credentials    TABLE     �   CREATE TABLE public.hmacauth_credentials (
    id uuid NOT NULL,
    created_at timestamp with time zone DEFAULT timezone('UTC'::text, CURRENT_TIMESTAMP(0)),
    consumer_id uuid,
    username text,
    secret text,
    tags text[],
    ws_id uuid
);
 (   DROP TABLE public.hmacauth_credentials;
       public         heap    kong    false            �            1259    16908    jwt_secrets    TABLE       CREATE TABLE public.jwt_secrets (
    id uuid NOT NULL,
    created_at timestamp with time zone DEFAULT timezone('UTC'::text, CURRENT_TIMESTAMP(0)),
    consumer_id uuid,
    key text,
    secret text,
    algorithm text,
    rsa_public_key text,
    tags text[],
    ws_id uuid
);
    DROP TABLE public.jwt_secrets;
       public         heap    kong    false            �            1259    16977    keyauth_credentials    TABLE       CREATE TABLE public.keyauth_credentials (
    id uuid NOT NULL,
    created_at timestamp with time zone DEFAULT timezone('UTC'::text, CURRENT_TIMESTAMP(0)),
    consumer_id uuid,
    key text,
    tags text[],
    ttl timestamp with time zone,
    ws_id uuid
);
 '   DROP TABLE public.keyauth_credentials;
       public         heap    kong    false            �            1259    16393    locks    TABLE     g   CREATE TABLE public.locks (
    key text NOT NULL,
    owner text,
    ttl timestamp with time zone
);
    DROP TABLE public.locks;
       public         heap    kong    false            �            1259    16797    oauth2_authorization_codes    TABLE     r  CREATE TABLE public.oauth2_authorization_codes (
    id uuid NOT NULL,
    created_at timestamp with time zone DEFAULT timezone('UTC'::text, CURRENT_TIMESTAMP(0)),
    credential_id uuid,
    service_id uuid,
    code text,
    authenticated_userid text,
    scope text,
    ttl timestamp with time zone,
    challenge text,
    challenge_method text,
    ws_id uuid
);
 .   DROP TABLE public.oauth2_authorization_codes;
       public         heap    kong    false            �            1259    16779    oauth2_credentials    TABLE     Y  CREATE TABLE public.oauth2_credentials (
    id uuid NOT NULL,
    created_at timestamp with time zone DEFAULT timezone('UTC'::text, CURRENT_TIMESTAMP(0)),
    name text,
    consumer_id uuid,
    client_id text,
    client_secret text,
    redirect_uris text[],
    tags text[],
    client_type text,
    hash_secret boolean,
    ws_id uuid
);
 &   DROP TABLE public.oauth2_credentials;
       public         heap    kong    false            �            1259    16821    oauth2_tokens    TABLE     �  CREATE TABLE public.oauth2_tokens (
    id uuid NOT NULL,
    created_at timestamp with time zone DEFAULT timezone('UTC'::text, CURRENT_TIMESTAMP(0)),
    credential_id uuid,
    service_id uuid,
    access_token text,
    refresh_token text,
    token_type text,
    expires_in integer,
    authenticated_userid text,
    scope text,
    ttl timestamp with time zone,
    ws_id uuid
);
 !   DROP TABLE public.oauth2_tokens;
       public         heap    kong    false            �            1259    16480    plugins    TABLE     m  CREATE TABLE public.plugins (
    id uuid NOT NULL,
    created_at timestamp with time zone DEFAULT timezone('UTC'::text, CURRENT_TIMESTAMP(0)),
    name text NOT NULL,
    consumer_id uuid,
    service_id uuid,
    route_id uuid,
    config jsonb NOT NULL,
    enabled boolean NOT NULL,
    cache_key text,
    protocols text[],
    tags text[],
    ws_id uuid
);
    DROP TABLE public.plugins;
       public         heap    kong    false            �            1259    16733    ratelimiting_metrics    TABLE     q  CREATE TABLE public.ratelimiting_metrics (
    identifier text NOT NULL,
    period text NOT NULL,
    period_date timestamp with time zone NOT NULL,
    service_id uuid DEFAULT '00000000-0000-0000-0000-000000000000'::uuid NOT NULL,
    route_id uuid DEFAULT '00000000-0000-0000-0000-000000000000'::uuid NOT NULL,
    value integer,
    ttl timestamp with time zone
);
 (   DROP TABLE public.ratelimiting_metrics;
       public         heap    kong    false            �            1259    17056    response_ratelimiting_metrics    TABLE     X  CREATE TABLE public.response_ratelimiting_metrics (
    identifier text NOT NULL,
    period text NOT NULL,
    period_date timestamp with time zone NOT NULL,
    service_id uuid DEFAULT '00000000-0000-0000-0000-000000000000'::uuid NOT NULL,
    route_id uuid DEFAULT '00000000-0000-0000-0000-000000000000'::uuid NOT NULL,
    value integer
);
 1   DROP TABLE public.response_ratelimiting_metrics;
       public         heap    kong    false            �            1259    16424    routes    TABLE       CREATE TABLE public.routes (
    id uuid NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    name text,
    service_id uuid,
    protocols text[],
    methods text[],
    hosts text[],
    paths text[],
    snis text[],
    sources jsonb[],
    destinations jsonb[],
    regex_priority bigint,
    strip_path boolean,
    preserve_host boolean,
    tags text[],
    https_redirect_status_code integer,
    headers jsonb,
    path_handling text DEFAULT 'v0'::text,
    ws_id uuid
);
    DROP TABLE public.routes;
       public         heap    kong    false            �            1259    16385    schema_meta    TABLE     �   CREATE TABLE public.schema_meta (
    key text NOT NULL,
    subsystem text NOT NULL,
    last_executed text,
    executed text[],
    pending text[]
);
    DROP TABLE public.schema_meta;
       public         heap    kong    false            �            1259    16414    services    TABLE     �  CREATE TABLE public.services (
    id uuid NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    name text,
    retries bigint,
    protocol text,
    host text,
    port bigint,
    path text,
    connect_timeout bigint,
    write_timeout bigint,
    read_timeout bigint,
    tags text[],
    client_certificate_id uuid,
    tls_verify boolean,
    tls_verify_depth smallint,
    ca_certificates uuid[],
    ws_id uuid
);
    DROP TABLE public.services;
       public         heap    kong    false            �            1259    17012    sessions    TABLE     �   CREATE TABLE public.sessions (
    id uuid NOT NULL,
    session_id text,
    expires integer,
    data text,
    created_at timestamp with time zone,
    ttl timestamp with time zone
);
    DROP TABLE public.sessions;
       public         heap    kong    false            �            1259    16449    snis    TABLE     �   CREATE TABLE public.snis (
    id uuid NOT NULL,
    created_at timestamp with time zone DEFAULT timezone('UTC'::text, CURRENT_TIMESTAMP(0)),
    name text NOT NULL,
    certificate_id uuid,
    tags text[],
    ws_id uuid
);
    DROP TABLE public.snis;
       public         heap    kong    false            �            1259    16557    tags    TABLE     a   CREATE TABLE public.tags (
    entity_id uuid NOT NULL,
    entity_name text,
    tags text[]
);
    DROP TABLE public.tags;
       public         heap    kong    false            �            1259    16522    targets    TABLE       CREATE TABLE public.targets (
    id uuid NOT NULL,
    created_at timestamp with time zone DEFAULT timezone('UTC'::text, CURRENT_TIMESTAMP(3)),
    upstream_id uuid,
    target text NOT NULL,
    weight integer NOT NULL,
    tags text[],
    ws_id uuid
);
    DROP TABLE public.targets;
       public         heap    kong    false            �            1259    16547    ttls    TABLE     �   CREATE TABLE public.ttls (
    primary_key_value text NOT NULL,
    primary_uuid_value uuid,
    table_name text NOT NULL,
    primary_key_name text NOT NULL,
    expire_at timestamp without time zone NOT NULL
);
    DROP TABLE public.ttls;
       public         heap    kong    false            �            1259    16511 	   upstreams    TABLE     �  CREATE TABLE public.upstreams (
    id uuid NOT NULL,
    created_at timestamp with time zone DEFAULT timezone('UTC'::text, CURRENT_TIMESTAMP(3)),
    name text,
    hash_on text,
    hash_fallback text,
    hash_on_header text,
    hash_fallback_header text,
    hash_on_cookie text,
    hash_on_cookie_path text,
    slots integer NOT NULL,
    healthchecks jsonb,
    tags text[],
    algorithm text,
    host_header text,
    client_certificate_id uuid,
    ws_id uuid
);
    DROP TABLE public.upstreams;
       public         heap    kong    false            �            1259    16613 
   workspaces    TABLE     �   CREATE TABLE public.workspaces (
    id uuid NOT NULL,
    name text,
    comment text,
    created_at timestamp with time zone DEFAULT timezone('UTC'::text, CURRENT_TIMESTAMP(0)),
    meta jsonb,
    config jsonb
);
    DROP TABLE public.workspaces;
       public         heap    kong    false                      0    17023    acls 
   TABLE DATA           \   COPY public.acls (id, created_at, consumer_id, "group", cache_key, tags, ws_id) FROM stdin;
    public          kong    false    226   X4                0    17066    acme_storage 
   TABLE DATA           G   COPY public.acme_storage (id, key, value, created_at, ttl) FROM stdin;
    public          kong    false    228   x6                0    16943    basicauth_credentials 
   TABLE DATA           m   COPY public.basicauth_credentials (id, created_at, consumer_id, username, password, tags, ws_id) FROM stdin;
    public          kong    false    223   �6                0    16585    ca_certificates 
   TABLE DATA           R   COPY public.ca_certificates (id, created_at, cert, tags, cert_digest) FROM stdin;
    public          kong    false    215   �:                0    16440    certificates 
   TABLE DATA           N   COPY public.certificates (id, created_at, cert, key, tags, ws_id) FROM stdin;
    public          kong    false    207   �:                0    16402    cluster_events 
   TABLE DATA           X   COPY public.cluster_events (id, node_id, at, nbf, expire_at, channel, data) FROM stdin;
    public          kong    false    204   �:                0    16466 	   consumers 
   TABLE DATA           U   COPY public.consumers (id, created_at, username, custom_id, tags, ws_id) FROM stdin;
    public          kong    false    209   �:                0    16745    hmacauth_credentials 
   TABLE DATA           j   COPY public.hmacauth_credentials (id, created_at, consumer_id, username, secret, tags, ws_id) FROM stdin;
    public          kong    false    218   �>                0    16908    jwt_secrets 
   TABLE DATA           w   COPY public.jwt_secrets (id, created_at, consumer_id, key, secret, algorithm, rsa_public_key, tags, ws_id) FROM stdin;
    public          kong    false    222   �>                0    16977    keyauth_credentials 
   TABLE DATA           a   COPY public.keyauth_credentials (id, created_at, consumer_id, key, tags, ttl, ws_id) FROM stdin;
    public          kong    false    224   �>                0    16393    locks 
   TABLE DATA           0   COPY public.locks (key, owner, ttl) FROM stdin;
    public          kong    false    203   {@                0    16797    oauth2_authorization_codes 
   TABLE DATA           �   COPY public.oauth2_authorization_codes (id, created_at, credential_id, service_id, code, authenticated_userid, scope, ttl, challenge, challenge_method, ws_id) FROM stdin;
    public          kong    false    220   �@                0    16779    oauth2_credentials 
   TABLE DATA           �   COPY public.oauth2_credentials (id, created_at, name, consumer_id, client_id, client_secret, redirect_uris, tags, client_type, hash_secret, ws_id) FROM stdin;
    public          kong    false    219   �@                0    16821    oauth2_tokens 
   TABLE DATA           �   COPY public.oauth2_tokens (id, created_at, credential_id, service_id, access_token, refresh_token, token_type, expires_in, authenticated_userid, scope, ttl, ws_id) FROM stdin;
    public          kong    false    221   �@      	          0    16480    plugins 
   TABLE DATA           �   COPY public.plugins (id, created_at, name, consumer_id, service_id, route_id, config, enabled, cache_key, protocols, tags, ws_id) FROM stdin;
    public          kong    false    210   �@                0    16733    ratelimiting_metrics 
   TABLE DATA           q   COPY public.ratelimiting_metrics (identifier, period, period_date, service_id, route_id, value, ttl) FROM stdin;
    public          kong    false    217   B                0    17056    response_ratelimiting_metrics 
   TABLE DATA           u   COPY public.response_ratelimiting_metrics (identifier, period, period_date, service_id, route_id, value) FROM stdin;
    public          kong    false    227   <B                0    16424    routes 
   TABLE DATA           �   COPY public.routes (id, created_at, updated_at, name, service_id, protocols, methods, hosts, paths, snis, sources, destinations, regex_priority, strip_path, preserve_host, tags, https_redirect_status_code, headers, path_handling, ws_id) FROM stdin;
    public          kong    false    206   YB                0    16385    schema_meta 
   TABLE DATA           W   COPY public.schema_meta (key, subsystem, last_executed, executed, pending) FROM stdin;
    public          kong    false    202   RC                0    16414    services 
   TABLE DATA           �   COPY public.services (id, created_at, updated_at, name, retries, protocol, host, port, path, connect_timeout, write_timeout, read_timeout, tags, client_certificate_id, tls_verify, tls_verify_depth, ca_certificates, ws_id) FROM stdin;
    public          kong    false    205   �D                0    17012    sessions 
   TABLE DATA           R   COPY public.sessions (id, session_id, expires, data, created_at, ttl) FROM stdin;
    public          kong    false    225   �E                0    16449    snis 
   TABLE DATA           Q   COPY public.snis (id, created_at, name, certificate_id, tags, ws_id) FROM stdin;
    public          kong    false    208   �E                0    16557    tags 
   TABLE DATA           <   COPY public.tags (entity_id, entity_name, tags) FROM stdin;
    public          kong    false    214   �E                0    16522    targets 
   TABLE DATA           [   COPY public.targets (id, created_at, upstream_id, target, weight, tags, ws_id) FROM stdin;
    public          kong    false    212   �K                0    16547    ttls 
   TABLE DATA           n   COPY public.ttls (primary_key_value, primary_uuid_value, table_name, primary_key_name, expire_at) FROM stdin;
    public          kong    false    213   �K      
          0    16511 	   upstreams 
   TABLE DATA           �   COPY public.upstreams (id, created_at, name, hash_on, hash_fallback, hash_on_header, hash_fallback_header, hash_on_cookie, hash_on_cookie_path, slots, healthchecks, tags, algorithm, host_header, client_certificate_id, ws_id) FROM stdin;
    public          kong    false    211   �K                0    16613 
   workspaces 
   TABLE DATA           Q   COPY public.workspaces (id, name, comment, created_at, meta, config) FROM stdin;
    public          kong    false    216   �K      D           2606    17033    acls acls_cache_key_key 
   CONSTRAINT     W   ALTER TABLE ONLY public.acls
    ADD CONSTRAINT acls_cache_key_key UNIQUE (cache_key);
 A   ALTER TABLE ONLY public.acls DROP CONSTRAINT acls_cache_key_key;
       public            kong    false    226            H           2606    17050    acls acls_id_ws_id_unique 
   CONSTRAINT     Y   ALTER TABLE ONLY public.acls
    ADD CONSTRAINT acls_id_ws_id_unique UNIQUE (id, ws_id);
 C   ALTER TABLE ONLY public.acls DROP CONSTRAINT acls_id_ws_id_unique;
       public            kong    false    226    226            J           2606    17031    acls acls_pkey 
   CONSTRAINT     L   ALTER TABLE ONLY public.acls
    ADD CONSTRAINT acls_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.acls DROP CONSTRAINT acls_pkey;
       public            kong    false    226            O           2606    17075 !   acme_storage acme_storage_key_key 
   CONSTRAINT     [   ALTER TABLE ONLY public.acme_storage
    ADD CONSTRAINT acme_storage_key_key UNIQUE (key);
 K   ALTER TABLE ONLY public.acme_storage DROP CONSTRAINT acme_storage_key_key;
       public            kong    false    228            Q           2606    17073    acme_storage acme_storage_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.acme_storage
    ADD CONSTRAINT acme_storage_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.acme_storage DROP CONSTRAINT acme_storage_pkey;
       public            kong    false    228            /           2606    16969 ;   basicauth_credentials basicauth_credentials_id_ws_id_unique 
   CONSTRAINT     {   ALTER TABLE ONLY public.basicauth_credentials
    ADD CONSTRAINT basicauth_credentials_id_ws_id_unique UNIQUE (id, ws_id);
 e   ALTER TABLE ONLY public.basicauth_credentials DROP CONSTRAINT basicauth_credentials_id_ws_id_unique;
       public            kong    false    223    223            1           2606    16951 0   basicauth_credentials basicauth_credentials_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY public.basicauth_credentials
    ADD CONSTRAINT basicauth_credentials_pkey PRIMARY KEY (id);
 Z   ALTER TABLE ONLY public.basicauth_credentials DROP CONSTRAINT basicauth_credentials_pkey;
       public            kong    false    223            3           2606    16976 A   basicauth_credentials basicauth_credentials_ws_id_username_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.basicauth_credentials
    ADD CONSTRAINT basicauth_credentials_ws_id_username_unique UNIQUE (ws_id, username);
 k   ALTER TABLE ONLY public.basicauth_credentials DROP CONSTRAINT basicauth_credentials_ws_id_username_unique;
       public            kong    false    223    223            �           2606    16606 /   ca_certificates ca_certificates_cert_digest_key 
   CONSTRAINT     q   ALTER TABLE ONLY public.ca_certificates
    ADD CONSTRAINT ca_certificates_cert_digest_key UNIQUE (cert_digest);
 Y   ALTER TABLE ONLY public.ca_certificates DROP CONSTRAINT ca_certificates_cert_digest_key;
       public            kong    false    215            �           2606    16593 $   ca_certificates ca_certificates_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.ca_certificates
    ADD CONSTRAINT ca_certificates_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.ca_certificates DROP CONSTRAINT ca_certificates_pkey;
       public            kong    false    215            �           2606    16666 )   certificates certificates_id_ws_id_unique 
   CONSTRAINT     i   ALTER TABLE ONLY public.certificates
    ADD CONSTRAINT certificates_id_ws_id_unique UNIQUE (id, ws_id);
 S   ALTER TABLE ONLY public.certificates DROP CONSTRAINT certificates_id_ws_id_unique;
       public            kong    false    207    207            �           2606    16448    certificates certificates_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.certificates
    ADD CONSTRAINT certificates_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.certificates DROP CONSTRAINT certificates_pkey;
       public            kong    false    207            �           2606    16409 "   cluster_events cluster_events_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.cluster_events
    ADD CONSTRAINT cluster_events_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.cluster_events DROP CONSTRAINT cluster_events_pkey;
       public            kong    false    204            �           2606    16654 #   consumers consumers_id_ws_id_unique 
   CONSTRAINT     c   ALTER TABLE ONLY public.consumers
    ADD CONSTRAINT consumers_id_ws_id_unique UNIQUE (id, ws_id);
 M   ALTER TABLE ONLY public.consumers DROP CONSTRAINT consumers_id_ws_id_unique;
       public            kong    false    209    209            �           2606    16474    consumers consumers_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.consumers
    ADD CONSTRAINT consumers_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.consumers DROP CONSTRAINT consumers_pkey;
       public            kong    false    209            �           2606    16658 *   consumers consumers_ws_id_custom_id_unique 
   CONSTRAINT     q   ALTER TABLE ONLY public.consumers
    ADD CONSTRAINT consumers_ws_id_custom_id_unique UNIQUE (ws_id, custom_id);
 T   ALTER TABLE ONLY public.consumers DROP CONSTRAINT consumers_ws_id_custom_id_unique;
       public            kong    false    209    209            �           2606    16656 )   consumers consumers_ws_id_username_unique 
   CONSTRAINT     o   ALTER TABLE ONLY public.consumers
    ADD CONSTRAINT consumers_ws_id_username_unique UNIQUE (ws_id, username);
 S   ALTER TABLE ONLY public.consumers DROP CONSTRAINT consumers_ws_id_username_unique;
       public            kong    false    209    209            �           2606    16771 9   hmacauth_credentials hmacauth_credentials_id_ws_id_unique 
   CONSTRAINT     y   ALTER TABLE ONLY public.hmacauth_credentials
    ADD CONSTRAINT hmacauth_credentials_id_ws_id_unique UNIQUE (id, ws_id);
 c   ALTER TABLE ONLY public.hmacauth_credentials DROP CONSTRAINT hmacauth_credentials_id_ws_id_unique;
       public            kong    false    218    218                       2606    16753 .   hmacauth_credentials hmacauth_credentials_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.hmacauth_credentials
    ADD CONSTRAINT hmacauth_credentials_pkey PRIMARY KEY (id);
 X   ALTER TABLE ONLY public.hmacauth_credentials DROP CONSTRAINT hmacauth_credentials_pkey;
       public            kong    false    218                       2606    16778 ?   hmacauth_credentials hmacauth_credentials_ws_id_username_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.hmacauth_credentials
    ADD CONSTRAINT hmacauth_credentials_ws_id_username_unique UNIQUE (ws_id, username);
 i   ALTER TABLE ONLY public.hmacauth_credentials DROP CONSTRAINT hmacauth_credentials_ws_id_username_unique;
       public            kong    false    218    218            &           2606    16935 '   jwt_secrets jwt_secrets_id_ws_id_unique 
   CONSTRAINT     g   ALTER TABLE ONLY public.jwt_secrets
    ADD CONSTRAINT jwt_secrets_id_ws_id_unique UNIQUE (id, ws_id);
 Q   ALTER TABLE ONLY public.jwt_secrets DROP CONSTRAINT jwt_secrets_id_ws_id_unique;
       public            kong    false    222    222            (           2606    16916    jwt_secrets jwt_secrets_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.jwt_secrets
    ADD CONSTRAINT jwt_secrets_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.jwt_secrets DROP CONSTRAINT jwt_secrets_pkey;
       public            kong    false    222            +           2606    16942 (   jwt_secrets jwt_secrets_ws_id_key_unique 
   CONSTRAINT     i   ALTER TABLE ONLY public.jwt_secrets
    ADD CONSTRAINT jwt_secrets_ws_id_key_unique UNIQUE (ws_id, key);
 R   ALTER TABLE ONLY public.jwt_secrets DROP CONSTRAINT jwt_secrets_ws_id_key_unique;
       public            kong    false    222    222            7           2606    17004 7   keyauth_credentials keyauth_credentials_id_ws_id_unique 
   CONSTRAINT     w   ALTER TABLE ONLY public.keyauth_credentials
    ADD CONSTRAINT keyauth_credentials_id_ws_id_unique UNIQUE (id, ws_id);
 a   ALTER TABLE ONLY public.keyauth_credentials DROP CONSTRAINT keyauth_credentials_id_ws_id_unique;
       public            kong    false    224    224            9           2606    16985 ,   keyauth_credentials keyauth_credentials_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.keyauth_credentials
    ADD CONSTRAINT keyauth_credentials_pkey PRIMARY KEY (id);
 V   ALTER TABLE ONLY public.keyauth_credentials DROP CONSTRAINT keyauth_credentials_pkey;
       public            kong    false    224            <           2606    17011 8   keyauth_credentials keyauth_credentials_ws_id_key_unique 
   CONSTRAINT     y   ALTER TABLE ONLY public.keyauth_credentials
    ADD CONSTRAINT keyauth_credentials_ws_id_key_unique UNIQUE (ws_id, key);
 b   ALTER TABLE ONLY public.keyauth_credentials DROP CONSTRAINT keyauth_credentials_ws_id_key_unique;
       public            kong    false    224    224            �           2606    16400    locks locks_pkey 
   CONSTRAINT     O   ALTER TABLE ONLY public.locks
    ADD CONSTRAINT locks_pkey PRIMARY KEY (key);
 :   ALTER TABLE ONLY public.locks DROP CONSTRAINT locks_pkey;
       public            kong    false    203                       2606    16873 E   oauth2_authorization_codes oauth2_authorization_codes_id_ws_id_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.oauth2_authorization_codes
    ADD CONSTRAINT oauth2_authorization_codes_id_ws_id_unique UNIQUE (id, ws_id);
 o   ALTER TABLE ONLY public.oauth2_authorization_codes DROP CONSTRAINT oauth2_authorization_codes_id_ws_id_unique;
       public            kong    false    220    220                       2606    16805 :   oauth2_authorization_codes oauth2_authorization_codes_pkey 
   CONSTRAINT     x   ALTER TABLE ONLY public.oauth2_authorization_codes
    ADD CONSTRAINT oauth2_authorization_codes_pkey PRIMARY KEY (id);
 d   ALTER TABLE ONLY public.oauth2_authorization_codes DROP CONSTRAINT oauth2_authorization_codes_pkey;
       public            kong    false    220                       2606    16885 G   oauth2_authorization_codes oauth2_authorization_codes_ws_id_code_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.oauth2_authorization_codes
    ADD CONSTRAINT oauth2_authorization_codes_ws_id_code_unique UNIQUE (ws_id, code);
 q   ALTER TABLE ONLY public.oauth2_authorization_codes DROP CONSTRAINT oauth2_authorization_codes_ws_id_code_unique;
       public            kong    false    220    220                       2606    16858 5   oauth2_credentials oauth2_credentials_id_ws_id_unique 
   CONSTRAINT     u   ALTER TABLE ONLY public.oauth2_credentials
    ADD CONSTRAINT oauth2_credentials_id_ws_id_unique UNIQUE (id, ws_id);
 _   ALTER TABLE ONLY public.oauth2_credentials DROP CONSTRAINT oauth2_credentials_id_ws_id_unique;
       public            kong    false    219    219            	           2606    16787 *   oauth2_credentials oauth2_credentials_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.oauth2_credentials
    ADD CONSTRAINT oauth2_credentials_pkey PRIMARY KEY (id);
 T   ALTER TABLE ONLY public.oauth2_credentials DROP CONSTRAINT oauth2_credentials_pkey;
       public            kong    false    219                       2606    16865 <   oauth2_credentials oauth2_credentials_ws_id_client_id_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.oauth2_credentials
    ADD CONSTRAINT oauth2_credentials_ws_id_client_id_unique UNIQUE (ws_id, client_id);
 f   ALTER TABLE ONLY public.oauth2_credentials DROP CONSTRAINT oauth2_credentials_ws_id_client_id_unique;
       public            kong    false    219    219                       2606    16893 +   oauth2_tokens oauth2_tokens_id_ws_id_unique 
   CONSTRAINT     k   ALTER TABLE ONLY public.oauth2_tokens
    ADD CONSTRAINT oauth2_tokens_id_ws_id_unique UNIQUE (id, ws_id);
 U   ALTER TABLE ONLY public.oauth2_tokens DROP CONSTRAINT oauth2_tokens_id_ws_id_unique;
       public            kong    false    221    221                       2606    16829     oauth2_tokens oauth2_tokens_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.oauth2_tokens
    ADD CONSTRAINT oauth2_tokens_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.oauth2_tokens DROP CONSTRAINT oauth2_tokens_pkey;
       public            kong    false    221            !           2606    16905 5   oauth2_tokens oauth2_tokens_ws_id_access_token_unique 
   CONSTRAINT        ALTER TABLE ONLY public.oauth2_tokens
    ADD CONSTRAINT oauth2_tokens_ws_id_access_token_unique UNIQUE (ws_id, access_token);
 _   ALTER TABLE ONLY public.oauth2_tokens DROP CONSTRAINT oauth2_tokens_ws_id_access_token_unique;
       public            kong    false    221    221            #           2606    16907 6   oauth2_tokens oauth2_tokens_ws_id_refresh_token_unique 
   CONSTRAINT     �   ALTER TABLE ONLY public.oauth2_tokens
    ADD CONSTRAINT oauth2_tokens_ws_id_refresh_token_unique UNIQUE (ws_id, refresh_token);
 `   ALTER TABLE ONLY public.oauth2_tokens DROP CONSTRAINT oauth2_tokens_ws_id_refresh_token_unique;
       public            kong    false    221    221            �           2606    16490    plugins plugins_cache_key_key 
   CONSTRAINT     ]   ALTER TABLE ONLY public.plugins
    ADD CONSTRAINT plugins_cache_key_key UNIQUE (cache_key);
 G   ALTER TABLE ONLY public.plugins DROP CONSTRAINT plugins_cache_key_key;
       public            kong    false    210            �           2606    16717    plugins plugins_id_ws_id_unique 
   CONSTRAINT     _   ALTER TABLE ONLY public.plugins
    ADD CONSTRAINT plugins_id_ws_id_unique UNIQUE (id, ws_id);
 I   ALTER TABLE ONLY public.plugins DROP CONSTRAINT plugins_id_ws_id_unique;
       public            kong    false    210    210            �           2606    16488    plugins plugins_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.plugins
    ADD CONSTRAINT plugins_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.plugins DROP CONSTRAINT plugins_pkey;
       public            kong    false    210            �           2606    16742 .   ratelimiting_metrics ratelimiting_metrics_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.ratelimiting_metrics
    ADD CONSTRAINT ratelimiting_metrics_pkey PRIMARY KEY (identifier, period, period_date, service_id, route_id);
 X   ALTER TABLE ONLY public.ratelimiting_metrics DROP CONSTRAINT ratelimiting_metrics_pkey;
       public            kong    false    217    217    217    217    217            M           2606    17065 @   response_ratelimiting_metrics response_ratelimiting_metrics_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.response_ratelimiting_metrics
    ADD CONSTRAINT response_ratelimiting_metrics_pkey PRIMARY KEY (identifier, period, period_date, service_id, route_id);
 j   ALTER TABLE ONLY public.response_ratelimiting_metrics DROP CONSTRAINT response_ratelimiting_metrics_pkey;
       public            kong    false    227    227    227    227    227            �           2606    16702    routes routes_id_ws_id_unique 
   CONSTRAINT     ]   ALTER TABLE ONLY public.routes
    ADD CONSTRAINT routes_id_ws_id_unique UNIQUE (id, ws_id);
 G   ALTER TABLE ONLY public.routes DROP CONSTRAINT routes_id_ws_id_unique;
       public            kong    false    206    206            �           2606    16431    routes routes_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.routes
    ADD CONSTRAINT routes_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.routes DROP CONSTRAINT routes_pkey;
       public            kong    false    206            �           2606    16709    routes routes_ws_id_name_unique 
   CONSTRAINT     a   ALTER TABLE ONLY public.routes
    ADD CONSTRAINT routes_ws_id_name_unique UNIQUE (ws_id, name);
 I   ALTER TABLE ONLY public.routes DROP CONSTRAINT routes_ws_id_name_unique;
       public            kong    false    206    206            �           2606    16392    schema_meta schema_meta_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.schema_meta
    ADD CONSTRAINT schema_meta_pkey PRIMARY KEY (key, subsystem);
 F   ALTER TABLE ONLY public.schema_meta DROP CONSTRAINT schema_meta_pkey;
       public            kong    false    202    202            �           2606    16687 !   services services_id_ws_id_unique 
   CONSTRAINT     a   ALTER TABLE ONLY public.services
    ADD CONSTRAINT services_id_ws_id_unique UNIQUE (id, ws_id);
 K   ALTER TABLE ONLY public.services DROP CONSTRAINT services_id_ws_id_unique;
       public            kong    false    205    205            �           2606    16421    services services_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.services
    ADD CONSTRAINT services_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.services DROP CONSTRAINT services_pkey;
       public            kong    false    205            �           2606    16694 #   services services_ws_id_name_unique 
   CONSTRAINT     e   ALTER TABLE ONLY public.services
    ADD CONSTRAINT services_ws_id_name_unique UNIQUE (ws_id, name);
 M   ALTER TABLE ONLY public.services DROP CONSTRAINT services_ws_id_name_unique;
       public            kong    false    205    205            @           2606    17019    sessions sessions_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.sessions DROP CONSTRAINT sessions_pkey;
       public            kong    false    225            B           2606    17021     sessions sessions_session_id_key 
   CONSTRAINT     a   ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_session_id_key UNIQUE (session_id);
 J   ALTER TABLE ONLY public.sessions DROP CONSTRAINT sessions_session_id_key;
       public            kong    false    225            �           2606    16674    snis snis_id_ws_id_unique 
   CONSTRAINT     Y   ALTER TABLE ONLY public.snis
    ADD CONSTRAINT snis_id_ws_id_unique UNIQUE (id, ws_id);
 C   ALTER TABLE ONLY public.snis DROP CONSTRAINT snis_id_ws_id_unique;
       public            kong    false    208    208            �           2606    16459    snis snis_name_key 
   CONSTRAINT     M   ALTER TABLE ONLY public.snis
    ADD CONSTRAINT snis_name_key UNIQUE (name);
 <   ALTER TABLE ONLY public.snis DROP CONSTRAINT snis_name_key;
       public            kong    false    208            �           2606    16457    snis snis_pkey 
   CONSTRAINT     L   ALTER TABLE ONLY public.snis
    ADD CONSTRAINT snis_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.snis DROP CONSTRAINT snis_pkey;
       public            kong    false    208            �           2606    16564    tags tags_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (entity_id);
 8   ALTER TABLE ONLY public.tags DROP CONSTRAINT tags_pkey;
       public            kong    false    214            �           2606    16641    targets targets_id_ws_id_unique 
   CONSTRAINT     _   ALTER TABLE ONLY public.targets
    ADD CONSTRAINT targets_id_ws_id_unique UNIQUE (id, ws_id);
 I   ALTER TABLE ONLY public.targets DROP CONSTRAINT targets_id_ws_id_unique;
       public            kong    false    212    212            �           2606    16530    targets targets_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.targets
    ADD CONSTRAINT targets_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.targets DROP CONSTRAINT targets_pkey;
       public            kong    false    212            �           2606    16554    ttls ttls_pkey 
   CONSTRAINT     g   ALTER TABLE ONLY public.ttls
    ADD CONSTRAINT ttls_pkey PRIMARY KEY (primary_key_value, table_name);
 8   ALTER TABLE ONLY public.ttls DROP CONSTRAINT ttls_pkey;
       public            kong    false    213    213            �           2606    16631 #   upstreams upstreams_id_ws_id_unique 
   CONSTRAINT     c   ALTER TABLE ONLY public.upstreams
    ADD CONSTRAINT upstreams_id_ws_id_unique UNIQUE (id, ws_id);
 M   ALTER TABLE ONLY public.upstreams DROP CONSTRAINT upstreams_id_ws_id_unique;
       public            kong    false    211    211            �           2606    16519    upstreams upstreams_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.upstreams
    ADD CONSTRAINT upstreams_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.upstreams DROP CONSTRAINT upstreams_pkey;
       public            kong    false    211            �           2606    16633 %   upstreams upstreams_ws_id_name_unique 
   CONSTRAINT     g   ALTER TABLE ONLY public.upstreams
    ADD CONSTRAINT upstreams_ws_id_name_unique UNIQUE (ws_id, name);
 O   ALTER TABLE ONLY public.upstreams DROP CONSTRAINT upstreams_ws_id_name_unique;
       public            kong    false    211    211            �           2606    16623    workspaces workspaces_name_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public.workspaces
    ADD CONSTRAINT workspaces_name_key UNIQUE (name);
 H   ALTER TABLE ONLY public.workspaces DROP CONSTRAINT workspaces_name_key;
       public            kong    false    216            �           2606    16621    workspaces workspaces_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.workspaces
    ADD CONSTRAINT workspaces_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.workspaces DROP CONSTRAINT workspaces_pkey;
       public            kong    false    216            E           1259    17039    acls_consumer_id_idx    INDEX     L   CREATE INDEX acls_consumer_id_idx ON public.acls USING btree (consumer_id);
 (   DROP INDEX public.acls_consumer_id_idx;
       public            kong    false    226            F           1259    17040    acls_group_idx    INDEX     B   CREATE INDEX acls_group_idx ON public.acls USING btree ("group");
 "   DROP INDEX public.acls_group_idx;
       public            kong    false    226            K           1259    17041    acls_tags_idex_tags_idx    INDEX     F   CREATE INDEX acls_tags_idex_tags_idx ON public.acls USING gin (tags);
 +   DROP INDEX public.acls_tags_idex_tags_idx;
       public            kong    false    226            -           1259    16959    basicauth_consumer_id_idx    INDEX     b   CREATE INDEX basicauth_consumer_id_idx ON public.basicauth_credentials USING btree (consumer_id);
 -   DROP INDEX public.basicauth_consumer_id_idx;
       public            kong    false    223            4           1259    16960    basicauth_tags_idex_tags_idx    INDEX     \   CREATE INDEX basicauth_tags_idex_tags_idx ON public.basicauth_credentials USING gin (tags);
 0   DROP INDEX public.basicauth_tags_idex_tags_idx;
       public            kong    false    223            �           1259    16572    certificates_tags_idx    INDEX     L   CREATE INDEX certificates_tags_idx ON public.certificates USING gin (tags);
 )   DROP INDEX public.certificates_tags_idx;
       public            kong    false    207            �           1259    16410    cluster_events_at_idx    INDEX     N   CREATE INDEX cluster_events_at_idx ON public.cluster_events USING btree (at);
 )   DROP INDEX public.cluster_events_at_idx;
       public            kong    false    204            �           1259    16411    cluster_events_channel_idx    INDEX     X   CREATE INDEX cluster_events_channel_idx ON public.cluster_events USING btree (channel);
 .   DROP INDEX public.cluster_events_channel_idx;
       public            kong    false    204            �           1259    16584    cluster_events_expire_at_idx    INDEX     \   CREATE INDEX cluster_events_expire_at_idx ON public.cluster_events USING btree (expire_at);
 0   DROP INDEX public.cluster_events_expire_at_idx;
       public            kong    false    204            �           1259    16576    consumers_tags_idx    INDEX     F   CREATE INDEX consumers_tags_idx ON public.consumers USING gin (tags);
 &   DROP INDEX public.consumers_tags_idx;
       public            kong    false    209            �           1259    16479    consumers_username_idx    INDEX     W   CREATE INDEX consumers_username_idx ON public.consumers USING btree (lower(username));
 *   DROP INDEX public.consumers_username_idx;
       public            kong    false    209    209            �           1259    16761 $   hmacauth_credentials_consumer_id_idx    INDEX     l   CREATE INDEX hmacauth_credentials_consumer_id_idx ON public.hmacauth_credentials USING btree (consumer_id);
 8   DROP INDEX public.hmacauth_credentials_consumer_id_idx;
       public            kong    false    218                       1259    16762    hmacauth_tags_idex_tags_idx    INDEX     Z   CREATE INDEX hmacauth_tags_idex_tags_idx ON public.hmacauth_credentials USING gin (tags);
 /   DROP INDEX public.hmacauth_tags_idex_tags_idx;
       public            kong    false    218            $           1259    16924    jwt_secrets_consumer_id_idx    INDEX     Z   CREATE INDEX jwt_secrets_consumer_id_idx ON public.jwt_secrets USING btree (consumer_id);
 /   DROP INDEX public.jwt_secrets_consumer_id_idx;
       public            kong    false    222            )           1259    16925    jwt_secrets_secret_idx    INDEX     P   CREATE INDEX jwt_secrets_secret_idx ON public.jwt_secrets USING btree (secret);
 *   DROP INDEX public.jwt_secrets_secret_idx;
       public            kong    false    222            ,           1259    16926    jwtsecrets_tags_idex_tags_idx    INDEX     S   CREATE INDEX jwtsecrets_tags_idex_tags_idx ON public.jwt_secrets USING gin (tags);
 1   DROP INDEX public.jwtsecrets_tags_idex_tags_idx;
       public            kong    false    222            5           1259    16993 #   keyauth_credentials_consumer_id_idx    INDEX     j   CREATE INDEX keyauth_credentials_consumer_id_idx ON public.keyauth_credentials USING btree (consumer_id);
 7   DROP INDEX public.keyauth_credentials_consumer_id_idx;
       public            kong    false    224            :           1259    16996    keyauth_credentials_ttl_idx    INDEX     Z   CREATE INDEX keyauth_credentials_ttl_idx ON public.keyauth_credentials USING btree (ttl);
 /   DROP INDEX public.keyauth_credentials_ttl_idx;
       public            kong    false    224            =           1259    16994    keyauth_tags_idex_tags_idx    INDEX     X   CREATE INDEX keyauth_tags_idex_tags_idx ON public.keyauth_credentials USING gin (tags);
 .   DROP INDEX public.keyauth_tags_idex_tags_idx;
       public            kong    false    224            �           1259    16401    locks_ttl_idx    INDEX     >   CREATE INDEX locks_ttl_idx ON public.locks USING btree (ttl);
 !   DROP INDEX public.locks_ttl_idx;
       public            kong    false    203                       1259    16818 3   oauth2_authorization_codes_authenticated_userid_idx    INDEX     �   CREATE INDEX oauth2_authorization_codes_authenticated_userid_idx ON public.oauth2_authorization_codes USING btree (authenticated_userid);
 G   DROP INDEX public.oauth2_authorization_codes_authenticated_userid_idx;
       public            kong    false    220                       1259    16849 "   oauth2_authorization_codes_ttl_idx    INDEX     h   CREATE INDEX oauth2_authorization_codes_ttl_idx ON public.oauth2_authorization_codes USING btree (ttl);
 6   DROP INDEX public.oauth2_authorization_codes_ttl_idx;
       public            kong    false    220                       1259    16819 &   oauth2_authorization_credential_id_idx    INDEX     v   CREATE INDEX oauth2_authorization_credential_id_idx ON public.oauth2_authorization_codes USING btree (credential_id);
 :   DROP INDEX public.oauth2_authorization_credential_id_idx;
       public            kong    false    220                       1259    16820 #   oauth2_authorization_service_id_idx    INDEX     p   CREATE INDEX oauth2_authorization_service_id_idx ON public.oauth2_authorization_codes USING btree (service_id);
 7   DROP INDEX public.oauth2_authorization_service_id_idx;
       public            kong    false    220                       1259    16795 "   oauth2_credentials_consumer_id_idx    INDEX     h   CREATE INDEX oauth2_credentials_consumer_id_idx ON public.oauth2_credentials USING btree (consumer_id);
 6   DROP INDEX public.oauth2_credentials_consumer_id_idx;
       public            kong    false    219            
           1259    16796    oauth2_credentials_secret_idx    INDEX     e   CREATE INDEX oauth2_credentials_secret_idx ON public.oauth2_credentials USING btree (client_secret);
 1   DROP INDEX public.oauth2_credentials_secret_idx;
       public            kong    false    219                       1259    16847 %   oauth2_credentials_tags_idex_tags_idx    INDEX     b   CREATE INDEX oauth2_credentials_tags_idex_tags_idx ON public.oauth2_credentials USING gin (tags);
 9   DROP INDEX public.oauth2_credentials_tags_idex_tags_idx;
       public            kong    false    219                       1259    16844 &   oauth2_tokens_authenticated_userid_idx    INDEX     p   CREATE INDEX oauth2_tokens_authenticated_userid_idx ON public.oauth2_tokens USING btree (authenticated_userid);
 :   DROP INDEX public.oauth2_tokens_authenticated_userid_idx;
       public            kong    false    221                       1259    16845    oauth2_tokens_credential_id_idx    INDEX     b   CREATE INDEX oauth2_tokens_credential_id_idx ON public.oauth2_tokens USING btree (credential_id);
 3   DROP INDEX public.oauth2_tokens_credential_id_idx;
       public            kong    false    221                       1259    16846    oauth2_tokens_service_id_idx    INDEX     \   CREATE INDEX oauth2_tokens_service_id_idx ON public.oauth2_tokens USING btree (service_id);
 0   DROP INDEX public.oauth2_tokens_service_id_idx;
       public            kong    false    221                       1259    16850    oauth2_tokens_ttl_idx    INDEX     N   CREATE INDEX oauth2_tokens_ttl_idx ON public.oauth2_tokens USING btree (ttl);
 )   DROP INDEX public.oauth2_tokens_ttl_idx;
       public            kong    false    221            �           1259    16507    plugins_consumer_id_idx    INDEX     R   CREATE INDEX plugins_consumer_id_idx ON public.plugins USING btree (consumer_id);
 +   DROP INDEX public.plugins_consumer_id_idx;
       public            kong    false    210            �           1259    16506    plugins_name_idx    INDEX     D   CREATE INDEX plugins_name_idx ON public.plugins USING btree (name);
 $   DROP INDEX public.plugins_name_idx;
       public            kong    false    210            �           1259    16509    plugins_route_id_idx    INDEX     L   CREATE INDEX plugins_route_id_idx ON public.plugins USING btree (route_id);
 (   DROP INDEX public.plugins_route_id_idx;
       public            kong    false    210            �           1259    16508    plugins_service_id_idx    INDEX     P   CREATE INDEX plugins_service_id_idx ON public.plugins USING btree (service_id);
 *   DROP INDEX public.plugins_service_id_idx;
       public            kong    false    210            �           1259    16578    plugins_tags_idx    INDEX     B   CREATE INDEX plugins_tags_idx ON public.plugins USING gin (tags);
 $   DROP INDEX public.plugins_tags_idx;
       public            kong    false    210            �           1259    16743    ratelimiting_metrics_idx    INDEX     ~   CREATE INDEX ratelimiting_metrics_idx ON public.ratelimiting_metrics USING btree (service_id, route_id, period_date, period);
 ,   DROP INDEX public.ratelimiting_metrics_idx;
       public            kong    false    217    217    217    217            �           1259    16744    ratelimiting_metrics_ttl_idx    INDEX     \   CREATE INDEX ratelimiting_metrics_ttl_idx ON public.ratelimiting_metrics USING btree (ttl);
 0   DROP INDEX public.ratelimiting_metrics_ttl_idx;
       public            kong    false    217            �           1259    16439    routes_service_id_idx    INDEX     N   CREATE INDEX routes_service_id_idx ON public.routes USING btree (service_id);
 )   DROP INDEX public.routes_service_id_idx;
       public            kong    false    206            �           1259    16570    routes_tags_idx    INDEX     @   CREATE INDEX routes_tags_idx ON public.routes USING gin (tags);
 #   DROP INDEX public.routes_tags_idx;
       public            kong    false    206            �           1259    16602     services_fkey_client_certificate    INDEX     f   CREATE INDEX services_fkey_client_certificate ON public.services USING btree (client_certificate_id);
 4   DROP INDEX public.services_fkey_client_certificate;
       public            kong    false    205            �           1259    16568    services_tags_idx    INDEX     D   CREATE INDEX services_tags_idx ON public.services USING gin (tags);
 %   DROP INDEX public.services_tags_idx;
       public            kong    false    205            >           1259    17022    session_sessions_expires_idx    INDEX     T   CREATE INDEX session_sessions_expires_idx ON public.sessions USING btree (expires);
 0   DROP INDEX public.session_sessions_expires_idx;
       public            kong    false    225            �           1259    16465    snis_certificate_id_idx    INDEX     R   CREATE INDEX snis_certificate_id_idx ON public.snis USING btree (certificate_id);
 +   DROP INDEX public.snis_certificate_id_idx;
       public            kong    false    208            �           1259    16574    snis_tags_idx    INDEX     <   CREATE INDEX snis_tags_idx ON public.snis USING gin (tags);
 !   DROP INDEX public.snis_tags_idx;
       public            kong    false    208            �           1259    16565    tags_entity_name_idx    INDEX     L   CREATE INDEX tags_entity_name_idx ON public.tags USING btree (entity_name);
 (   DROP INDEX public.tags_entity_name_idx;
       public            kong    false    214            �           1259    16566    tags_tags_idx    INDEX     <   CREATE INDEX tags_tags_idx ON public.tags USING gin (tags);
 !   DROP INDEX public.tags_tags_idx;
       public            kong    false    214            �           1259    16582    targets_tags_idx    INDEX     B   CREATE INDEX targets_tags_idx ON public.targets USING gin (tags);
 $   DROP INDEX public.targets_tags_idx;
       public            kong    false    212            �           1259    16536    targets_target_idx    INDEX     H   CREATE INDEX targets_target_idx ON public.targets USING btree (target);
 &   DROP INDEX public.targets_target_idx;
       public            kong    false    212            �           1259    16537    targets_upstream_id_idx    INDEX     R   CREATE INDEX targets_upstream_id_idx ON public.targets USING btree (upstream_id);
 +   DROP INDEX public.targets_upstream_id_idx;
       public            kong    false    212            �           1259    16555    ttls_primary_uuid_value_idx    INDEX     Z   CREATE INDEX ttls_primary_uuid_value_idx ON public.ttls USING btree (primary_uuid_value);
 /   DROP INDEX public.ttls_primary_uuid_value_idx;
       public            kong    false    213            �           1259    16612 !   upstreams_fkey_client_certificate    INDEX     h   CREATE INDEX upstreams_fkey_client_certificate ON public.upstreams USING btree (client_certificate_id);
 5   DROP INDEX public.upstreams_fkey_client_certificate;
       public            kong    false    211            �           1259    16580    upstreams_tags_idx    INDEX     F   CREATE INDEX upstreams_tags_idx ON public.upstreams USING gin (tags);
 &   DROP INDEX public.upstreams_tags_idx;
       public            kong    false    211            �           2620    17042    acls acls_sync_tags_trigger    TRIGGER     �   CREATE TRIGGER acls_sync_tags_trigger AFTER INSERT OR DELETE OR UPDATE OF tags ON public.acls FOR EACH ROW EXECUTE FUNCTION public.sync_tags();
 4   DROP TRIGGER acls_sync_tags_trigger ON public.acls;
       public          kong    false    229    226    226            �           2620    16961 1   basicauth_credentials basicauth_sync_tags_trigger    TRIGGER     �   CREATE TRIGGER basicauth_sync_tags_trigger AFTER INSERT OR DELETE OR UPDATE OF tags ON public.basicauth_credentials FOR EACH ROW EXECUTE FUNCTION public.sync_tags();
 J   DROP TRIGGER basicauth_sync_tags_trigger ON public.basicauth_credentials;
       public          kong    false    223    223    229            |           2620    16596 1   ca_certificates ca_certificates_sync_tags_trigger    TRIGGER     �   CREATE TRIGGER ca_certificates_sync_tags_trigger AFTER INSERT OR DELETE OR UPDATE OF tags ON public.ca_certificates FOR EACH ROW EXECUTE FUNCTION public.sync_tags();
 J   DROP TRIGGER ca_certificates_sync_tags_trigger ON public.ca_certificates;
       public          kong    false    229    215    215            v           2620    16573 +   certificates certificates_sync_tags_trigger    TRIGGER     �   CREATE TRIGGER certificates_sync_tags_trigger AFTER INSERT OR DELETE OR UPDATE OF tags ON public.certificates FOR EACH ROW EXECUTE FUNCTION public.sync_tags();
 D   DROP TRIGGER certificates_sync_tags_trigger ON public.certificates;
       public          kong    false    207    229    207            x           2620    16577 %   consumers consumers_sync_tags_trigger    TRIGGER     �   CREATE TRIGGER consumers_sync_tags_trigger AFTER INSERT OR DELETE OR UPDATE OF tags ON public.consumers FOR EACH ROW EXECUTE FUNCTION public.sync_tags();
 >   DROP TRIGGER consumers_sync_tags_trigger ON public.consumers;
       public          kong    false    229    209    209            }           2620    16763 /   hmacauth_credentials hmacauth_sync_tags_trigger    TRIGGER     �   CREATE TRIGGER hmacauth_sync_tags_trigger AFTER INSERT OR DELETE OR UPDATE OF tags ON public.hmacauth_credentials FOR EACH ROW EXECUTE FUNCTION public.sync_tags();
 H   DROP TRIGGER hmacauth_sync_tags_trigger ON public.hmacauth_credentials;
       public          kong    false    218    229    218                       2620    16927 (   jwt_secrets jwtsecrets_sync_tags_trigger    TRIGGER     �   CREATE TRIGGER jwtsecrets_sync_tags_trigger AFTER INSERT OR DELETE OR UPDATE OF tags ON public.jwt_secrets FOR EACH ROW EXECUTE FUNCTION public.sync_tags();
 A   DROP TRIGGER jwtsecrets_sync_tags_trigger ON public.jwt_secrets;
       public          kong    false    222    222    229            �           2620    16995 -   keyauth_credentials keyauth_sync_tags_trigger    TRIGGER     �   CREATE TRIGGER keyauth_sync_tags_trigger AFTER INSERT OR DELETE OR UPDATE OF tags ON public.keyauth_credentials FOR EACH ROW EXECUTE FUNCTION public.sync_tags();
 F   DROP TRIGGER keyauth_sync_tags_trigger ON public.keyauth_credentials;
       public          kong    false    229    224    224            ~           2620    16848 7   oauth2_credentials oauth2_credentials_sync_tags_trigger    TRIGGER     �   CREATE TRIGGER oauth2_credentials_sync_tags_trigger AFTER INSERT OR DELETE OR UPDATE OF tags ON public.oauth2_credentials FOR EACH ROW EXECUTE FUNCTION public.sync_tags();
 P   DROP TRIGGER oauth2_credentials_sync_tags_trigger ON public.oauth2_credentials;
       public          kong    false    219    219    229            y           2620    16579 !   plugins plugins_sync_tags_trigger    TRIGGER     �   CREATE TRIGGER plugins_sync_tags_trigger AFTER INSERT OR DELETE OR UPDATE OF tags ON public.plugins FOR EACH ROW EXECUTE FUNCTION public.sync_tags();
 :   DROP TRIGGER plugins_sync_tags_trigger ON public.plugins;
       public          kong    false    229    210    210            u           2620    16571    routes routes_sync_tags_trigger    TRIGGER     �   CREATE TRIGGER routes_sync_tags_trigger AFTER INSERT OR DELETE OR UPDATE OF tags ON public.routes FOR EACH ROW EXECUTE FUNCTION public.sync_tags();
 8   DROP TRIGGER routes_sync_tags_trigger ON public.routes;
       public          kong    false    206    229    206            t           2620    16569 #   services services_sync_tags_trigger    TRIGGER     �   CREATE TRIGGER services_sync_tags_trigger AFTER INSERT OR DELETE OR UPDATE OF tags ON public.services FOR EACH ROW EXECUTE FUNCTION public.sync_tags();
 <   DROP TRIGGER services_sync_tags_trigger ON public.services;
       public          kong    false    205    229    205            w           2620    16575    snis snis_sync_tags_trigger    TRIGGER     �   CREATE TRIGGER snis_sync_tags_trigger AFTER INSERT OR DELETE OR UPDATE OF tags ON public.snis FOR EACH ROW EXECUTE FUNCTION public.sync_tags();
 4   DROP TRIGGER snis_sync_tags_trigger ON public.snis;
       public          kong    false    208    229    208            {           2620    16583 !   targets targets_sync_tags_trigger    TRIGGER     �   CREATE TRIGGER targets_sync_tags_trigger AFTER INSERT OR DELETE OR UPDATE OF tags ON public.targets FOR EACH ROW EXECUTE FUNCTION public.sync_tags();
 :   DROP TRIGGER targets_sync_tags_trigger ON public.targets;
       public          kong    false    212    229    212            z           2620    16581 %   upstreams upstreams_sync_tags_trigger    TRIGGER     �   CREATE TRIGGER upstreams_sync_tags_trigger AFTER INSERT OR DELETE OR UPDATE OF tags ON public.upstreams FOR EACH ROW EXECUTE FUNCTION public.sync_tags();
 >   DROP TRIGGER upstreams_sync_tags_trigger ON public.upstreams;
       public          kong    false    211    229    211            s           2606    17051    acls acls_consumer_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.acls
    ADD CONSTRAINT acls_consumer_id_fkey FOREIGN KEY (consumer_id, ws_id) REFERENCES public.consumers(id, ws_id) ON DELETE CASCADE;
 D   ALTER TABLE ONLY public.acls DROP CONSTRAINT acls_consumer_id_fkey;
       public          kong    false    226    226    209    3015    209            r           2606    17044    acls acls_ws_id_fkey    FK CONSTRAINT     v   ALTER TABLE ONLY public.acls
    ADD CONSTRAINT acls_ws_id_fkey FOREIGN KEY (ws_id) REFERENCES public.workspaces(id);
 >   ALTER TABLE ONLY public.acls DROP CONSTRAINT acls_ws_id_fkey;
       public          kong    false    3064    226    216            o           2606    16970 <   basicauth_credentials basicauth_credentials_consumer_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.basicauth_credentials
    ADD CONSTRAINT basicauth_credentials_consumer_id_fkey FOREIGN KEY (consumer_id, ws_id) REFERENCES public.consumers(id, ws_id) ON DELETE CASCADE;
 f   ALTER TABLE ONLY public.basicauth_credentials DROP CONSTRAINT basicauth_credentials_consumer_id_fkey;
       public          kong    false    3015    209    223    223    209            n           2606    16963 6   basicauth_credentials basicauth_credentials_ws_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.basicauth_credentials
    ADD CONSTRAINT basicauth_credentials_ws_id_fkey FOREIGN KEY (ws_id) REFERENCES public.workspaces(id);
 `   ALTER TABLE ONLY public.basicauth_credentials DROP CONSTRAINT basicauth_credentials_ws_id_fkey;
       public          kong    false    216    3064    223            V           2606    16660 $   certificates certificates_ws_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.certificates
    ADD CONSTRAINT certificates_ws_id_fkey FOREIGN KEY (ws_id) REFERENCES public.workspaces(id);
 N   ALTER TABLE ONLY public.certificates DROP CONSTRAINT certificates_ws_id_fkey;
       public          kong    false    207    216    3064            Y           2606    16648    consumers consumers_ws_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.consumers
    ADD CONSTRAINT consumers_ws_id_fkey FOREIGN KEY (ws_id) REFERENCES public.workspaces(id);
 H   ALTER TABLE ONLY public.consumers DROP CONSTRAINT consumers_ws_id_fkey;
       public          kong    false    216    3064    209            c           2606    16772 :   hmacauth_credentials hmacauth_credentials_consumer_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.hmacauth_credentials
    ADD CONSTRAINT hmacauth_credentials_consumer_id_fkey FOREIGN KEY (consumer_id, ws_id) REFERENCES public.consumers(id, ws_id) ON DELETE CASCADE;
 d   ALTER TABLE ONLY public.hmacauth_credentials DROP CONSTRAINT hmacauth_credentials_consumer_id_fkey;
       public          kong    false    218    209    209    218    3015            b           2606    16765 4   hmacauth_credentials hmacauth_credentials_ws_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.hmacauth_credentials
    ADD CONSTRAINT hmacauth_credentials_ws_id_fkey FOREIGN KEY (ws_id) REFERENCES public.workspaces(id);
 ^   ALTER TABLE ONLY public.hmacauth_credentials DROP CONSTRAINT hmacauth_credentials_ws_id_fkey;
       public          kong    false    216    3064    218            m           2606    16936 (   jwt_secrets jwt_secrets_consumer_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.jwt_secrets
    ADD CONSTRAINT jwt_secrets_consumer_id_fkey FOREIGN KEY (consumer_id, ws_id) REFERENCES public.consumers(id, ws_id) ON DELETE CASCADE;
 R   ALTER TABLE ONLY public.jwt_secrets DROP CONSTRAINT jwt_secrets_consumer_id_fkey;
       public          kong    false    209    3015    222    209    222            l           2606    16929 "   jwt_secrets jwt_secrets_ws_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.jwt_secrets
    ADD CONSTRAINT jwt_secrets_ws_id_fkey FOREIGN KEY (ws_id) REFERENCES public.workspaces(id);
 L   ALTER TABLE ONLY public.jwt_secrets DROP CONSTRAINT jwt_secrets_ws_id_fkey;
       public          kong    false    216    3064    222            q           2606    17005 8   keyauth_credentials keyauth_credentials_consumer_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.keyauth_credentials
    ADD CONSTRAINT keyauth_credentials_consumer_id_fkey FOREIGN KEY (consumer_id, ws_id) REFERENCES public.consumers(id, ws_id) ON DELETE CASCADE;
 b   ALTER TABLE ONLY public.keyauth_credentials DROP CONSTRAINT keyauth_credentials_consumer_id_fkey;
       public          kong    false    224    224    209    209    3015            p           2606    16998 2   keyauth_credentials keyauth_credentials_ws_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.keyauth_credentials
    ADD CONSTRAINT keyauth_credentials_ws_id_fkey FOREIGN KEY (ws_id) REFERENCES public.workspaces(id);
 \   ALTER TABLE ONLY public.keyauth_credentials DROP CONSTRAINT keyauth_credentials_ws_id_fkey;
       public          kong    false    216    224    3064            h           2606    16879 H   oauth2_authorization_codes oauth2_authorization_codes_credential_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.oauth2_authorization_codes
    ADD CONSTRAINT oauth2_authorization_codes_credential_id_fkey FOREIGN KEY (credential_id, ws_id) REFERENCES public.oauth2_credentials(id, ws_id) ON DELETE CASCADE;
 r   ALTER TABLE ONLY public.oauth2_authorization_codes DROP CONSTRAINT oauth2_authorization_codes_credential_id_fkey;
       public          kong    false    3079    219    220    220    219            g           2606    16874 E   oauth2_authorization_codes oauth2_authorization_codes_service_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.oauth2_authorization_codes
    ADD CONSTRAINT oauth2_authorization_codes_service_id_fkey FOREIGN KEY (service_id, ws_id) REFERENCES public.services(id, ws_id) ON DELETE CASCADE;
 o   ALTER TABLE ONLY public.oauth2_authorization_codes DROP CONSTRAINT oauth2_authorization_codes_service_id_fkey;
       public          kong    false    2987    205    220    220    205            f           2606    16867 @   oauth2_authorization_codes oauth2_authorization_codes_ws_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.oauth2_authorization_codes
    ADD CONSTRAINT oauth2_authorization_codes_ws_id_fkey FOREIGN KEY (ws_id) REFERENCES public.workspaces(id);
 j   ALTER TABLE ONLY public.oauth2_authorization_codes DROP CONSTRAINT oauth2_authorization_codes_ws_id_fkey;
       public          kong    false    216    3064    220            e           2606    16859 6   oauth2_credentials oauth2_credentials_consumer_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.oauth2_credentials
    ADD CONSTRAINT oauth2_credentials_consumer_id_fkey FOREIGN KEY (consumer_id, ws_id) REFERENCES public.consumers(id, ws_id) ON DELETE CASCADE;
 `   ALTER TABLE ONLY public.oauth2_credentials DROP CONSTRAINT oauth2_credentials_consumer_id_fkey;
       public          kong    false    209    209    3015    219    219            d           2606    16852 0   oauth2_credentials oauth2_credentials_ws_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.oauth2_credentials
    ADD CONSTRAINT oauth2_credentials_ws_id_fkey FOREIGN KEY (ws_id) REFERENCES public.workspaces(id);
 Z   ALTER TABLE ONLY public.oauth2_credentials DROP CONSTRAINT oauth2_credentials_ws_id_fkey;
       public          kong    false    3064    216    219            k           2606    16899 .   oauth2_tokens oauth2_tokens_credential_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.oauth2_tokens
    ADD CONSTRAINT oauth2_tokens_credential_id_fkey FOREIGN KEY (credential_id, ws_id) REFERENCES public.oauth2_credentials(id, ws_id) ON DELETE CASCADE;
 X   ALTER TABLE ONLY public.oauth2_tokens DROP CONSTRAINT oauth2_tokens_credential_id_fkey;
       public          kong    false    219    221    221    219    3079            j           2606    16894 +   oauth2_tokens oauth2_tokens_service_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.oauth2_tokens
    ADD CONSTRAINT oauth2_tokens_service_id_fkey FOREIGN KEY (service_id, ws_id) REFERENCES public.services(id, ws_id) ON DELETE CASCADE;
 U   ALTER TABLE ONLY public.oauth2_tokens DROP CONSTRAINT oauth2_tokens_service_id_fkey;
       public          kong    false    221    2987    205    205    221            i           2606    16887 &   oauth2_tokens oauth2_tokens_ws_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.oauth2_tokens
    ADD CONSTRAINT oauth2_tokens_ws_id_fkey FOREIGN KEY (ws_id) REFERENCES public.workspaces(id);
 P   ALTER TABLE ONLY public.oauth2_tokens DROP CONSTRAINT oauth2_tokens_ws_id_fkey;
       public          kong    false    221    3064    216            ]           2606    16728     plugins plugins_consumer_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.plugins
    ADD CONSTRAINT plugins_consumer_id_fkey FOREIGN KEY (consumer_id, ws_id) REFERENCES public.consumers(id, ws_id) ON DELETE CASCADE;
 J   ALTER TABLE ONLY public.plugins DROP CONSTRAINT plugins_consumer_id_fkey;
       public          kong    false    209    3015    210    209    210            [           2606    16718    plugins plugins_route_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.plugins
    ADD CONSTRAINT plugins_route_id_fkey FOREIGN KEY (route_id, ws_id) REFERENCES public.routes(id, ws_id) ON DELETE CASCADE;
 G   ALTER TABLE ONLY public.plugins DROP CONSTRAINT plugins_route_id_fkey;
       public          kong    false    210    206    210    2994    206            \           2606    16723    plugins plugins_service_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.plugins
    ADD CONSTRAINT plugins_service_id_fkey FOREIGN KEY (service_id, ws_id) REFERENCES public.services(id, ws_id) ON DELETE CASCADE;
 I   ALTER TABLE ONLY public.plugins DROP CONSTRAINT plugins_service_id_fkey;
       public          kong    false    205    205    210    2987    210            Z           2606    16711    plugins plugins_ws_id_fkey    FK CONSTRAINT     |   ALTER TABLE ONLY public.plugins
    ADD CONSTRAINT plugins_ws_id_fkey FOREIGN KEY (ws_id) REFERENCES public.workspaces(id);
 D   ALTER TABLE ONLY public.plugins DROP CONSTRAINT plugins_ws_id_fkey;
       public          kong    false    210    3064    216            U           2606    16703    routes routes_service_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.routes
    ADD CONSTRAINT routes_service_id_fkey FOREIGN KEY (service_id, ws_id) REFERENCES public.services(id, ws_id);
 G   ALTER TABLE ONLY public.routes DROP CONSTRAINT routes_service_id_fkey;
       public          kong    false    206    205    205    2987    206            T           2606    16696    routes routes_ws_id_fkey    FK CONSTRAINT     z   ALTER TABLE ONLY public.routes
    ADD CONSTRAINT routes_ws_id_fkey FOREIGN KEY (ws_id) REFERENCES public.workspaces(id);
 B   ALTER TABLE ONLY public.routes DROP CONSTRAINT routes_ws_id_fkey;
       public          kong    false    216    3064    206            S           2606    16688 ,   services services_client_certificate_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.services
    ADD CONSTRAINT services_client_certificate_id_fkey FOREIGN KEY (client_certificate_id, ws_id) REFERENCES public.certificates(id, ws_id);
 V   ALTER TABLE ONLY public.services DROP CONSTRAINT services_client_certificate_id_fkey;
       public          kong    false    207    205    205    207    3002            R           2606    16681    services services_ws_id_fkey    FK CONSTRAINT     ~   ALTER TABLE ONLY public.services
    ADD CONSTRAINT services_ws_id_fkey FOREIGN KEY (ws_id) REFERENCES public.workspaces(id);
 F   ALTER TABLE ONLY public.services DROP CONSTRAINT services_ws_id_fkey;
       public          kong    false    216    205    3064            X           2606    16675    snis snis_certificate_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.snis
    ADD CONSTRAINT snis_certificate_id_fkey FOREIGN KEY (certificate_id, ws_id) REFERENCES public.certificates(id, ws_id);
 G   ALTER TABLE ONLY public.snis DROP CONSTRAINT snis_certificate_id_fkey;
       public          kong    false    207    208    208    207    3002            W           2606    16668    snis snis_ws_id_fkey    FK CONSTRAINT     v   ALTER TABLE ONLY public.snis
    ADD CONSTRAINT snis_ws_id_fkey FOREIGN KEY (ws_id) REFERENCES public.workspaces(id);
 >   ALTER TABLE ONLY public.snis DROP CONSTRAINT snis_ws_id_fkey;
       public          kong    false    216    208    3064            a           2606    16642     targets targets_upstream_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.targets
    ADD CONSTRAINT targets_upstream_id_fkey FOREIGN KEY (upstream_id, ws_id) REFERENCES public.upstreams(id, ws_id) ON DELETE CASCADE;
 J   ALTER TABLE ONLY public.targets DROP CONSTRAINT targets_upstream_id_fkey;
       public          kong    false    211    212    212    3037    211            `           2606    16635    targets targets_ws_id_fkey    FK CONSTRAINT     |   ALTER TABLE ONLY public.targets
    ADD CONSTRAINT targets_ws_id_fkey FOREIGN KEY (ws_id) REFERENCES public.workspaces(id);
 D   ALTER TABLE ONLY public.targets DROP CONSTRAINT targets_ws_id_fkey;
       public          kong    false    212    216    3064            ^           2606    16607 .   upstreams upstreams_client_certificate_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.upstreams
    ADD CONSTRAINT upstreams_client_certificate_id_fkey FOREIGN KEY (client_certificate_id) REFERENCES public.certificates(id);
 X   ALTER TABLE ONLY public.upstreams DROP CONSTRAINT upstreams_client_certificate_id_fkey;
       public          kong    false    211    3004    207            _           2606    16625    upstreams upstreams_ws_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.upstreams
    ADD CONSTRAINT upstreams_ws_id_fkey FOREIGN KEY (ws_id) REFERENCES public.workspaces(id);
 H   ALTER TABLE ONLY public.upstreams DROP CONSTRAINT upstreams_ws_id_fkey;
       public          kong    false    211    3064    216                 x���;��0D��S8w���:�O�	>d�r���m9�ȉ�Q)d����۴i�x�lV�E��RԆ����|A9hM�">Pq��1h��ԖC��Äw�����;��_����Wq��ذNXK�Zٸ`JD�ٛ�=޿?�{s�Z��k�yHV�*�7K��z���z�'����C�g��Q������ѭ=��Q��9��K��2U�A�P:-֗��Zۉ:�2�{R�|`�-����-ĭ�3���P�Ӳ����O��٣*W��/����'�n�\��<m�A�yS��c7{F��xj��^sv͋�H��\`�(�3㸢����a�(SҦ�J�l�+��s����e�[{4#WȲ-�A���6���h�D�kk��P%�i�aث3�e�"�Q�(^���lk�N<{��N�5G*-x���U�Dݤ1tT��h�J�$]�-ǹd�q��;�ץj�#��T���se�c�>w�Q�E%<8��|6�]s*�f٧��M��� �zi�����{{{�� x            x������ � �         �  x���=�#7�c�)���H� u�`� /`߿�zokUM2�!����]�D3�l2F�}�l;�G],�ѩScn}�A������65:qK��-ͽ{��Gz>�?��������^�\�ɓg���.ڜiz���������xIаV�/� Υj�3�ۚ����c=��\�~�E&�Cw�Tە�|�y�OZUzf˸Ѥj���5������8���h��\���!��8�c𖬏�W?�
(uH�5��җ(��c���9������N��/��T8*��-��"�F�^�����e�w.��&Mu�����u�>ZM��o�g�	b��wp}��C�8�J���m��������|<v�{���.1+�be�b��=j��'��y����foBJm�L�<���wp{��Uq��*RQv���M�D�y���Ǽfk��A�c�3�j�������P,��+��SNH�w��:Os��J�L��S~���U�<�����h�]_��-��>t0f_��q$6EF�}a�:z�Ԯa�W׏�{A$��5{�Tv��8�]nhH����K���r�Ո!���[;�h��2�/q�G���h�y�ss�d�3M��W|wܰ����4�6�	���o����^�~Ys��@�P��r[�ɯ���ׇ�3Dѕ������Q,T�REuf�SpX�S�A������0�~֌}���z
����6��F�(�w�*�%>��op{,�v� ̬W=�!�>��(���s�h��A
��GtV3)Aϱ�H�������ǂ�{��	q���l���V`-�7�~�Ԡ|�dB�CB5a�ǰ���İ�*0���|^��,ZDY[
�!�|?���'|8��(�ݘ:6!�m]�g|��Kg��y�옯N�狧Θ�&���8L��!ؙX��G#؇sc1���)�g�r�ӽ̼������5vs�\�º�7�|�D���P��%p�lQ�	Yݱ8>��׏?��c=�            x������ � �            x������ � �            x������ � �         �  x���A��6D�N�}���(��!r��%���z��xV��b6�ATU��:G���hqP��*���/FF �?P/֫�?���������g�Ǣ1H�
�1@m���� �������aP)���1b�h�^T��v�9�9��Dd�*3�:z��q�������eo�9{�H+�Rs�}U�Z��{�E/����Ьr5��lk�p�%��f�LR��������j���x� �4pфS�u����M�{���OhR�����@Z�D��:1���$��0���J�)�Zg$m���G�IX�M��~���o��	{۳�B�v��W��E@6��2���h?@xt�U�ݠN�4��C#�5D�����E�Ў�-Q��m�7��R�t��twjd�4�����,�ho��i&�E��'Đf�u��I�Ͻё�}�]n=_�c���v�!�h���UБ�E���Ɉ�I.��6t�^S>M���f�%ߓ�G��2�r�P��ݘ3��?��U�Vs��(K�"߹Y2"�'MG�%�:�;7uz���َ�d΍�|mN�L/�-C��-�.o�~��Q�tM�1��߭����cMa/��(����+��T,�9���	a�Z�l���}�2�M'��8z� ��<���"moMR�P	�۳�OJ��#)l`�����[���/�>ۑ�ssy���<��gC�PG�!7�r�ߴ4�����ݾft�#�Jn�Jr��ђ\u��vڑ������e]�~��oS4cs�����*��]���cS��9`b�P����M6Ujm��/���Ў�=�M��ⴻ�f�dKa���Y����v�7��)D�X2��T�ʚ���N�������O�5�Mc���.�y��l
n3w�fh�)����}��r�%>y�fG��d�R9Z�;,)HW.��I#�[=۴i��____���"�            x������ � �            x������ � �         �  x���MoA���WpGF�ᙱ�V
$�4U�Z��ޙѦ�����n8��"�Ͷ�����H�y�-�h�1@0)Efo1��g�Zp��p�b���1�8��I�Ā���
T2ڪ������g����������O���㧠�wWß��o���IA5��ɀ^��0�sΎb���)���]j�(��q�]���Klj���T�X+x�0'51C-1M�s��n�빹~H�a!��in�e*��p�A���s��]�:!�5	��ȶю��ڗXn�?l;�To͘l���A���
�K�\>�Gb�݂������Ag[�~}����9X��(
R�����"uT����ִȭ�'�vN
��WQ?���D� ��b)[!i����.?�<ۤe�M����]}K5gW�`��L&�g�u�2            x������ � �            x������ � �            x������ � �            x������ � �      	      x�͐Kj�0���)����lK:D/Д��(6���lJ�{�B	�.�]7�`f����	� �0 :��J�@u^v�����`���:P�)ל=RX�f[���R4�G����1y�Z�K�r��������>m�҇q��>T�����8����$䄷b-渝�1黜֏�i��Aa	��h��6�A��{�d�j��y�]��T��:�t۽>r_���.(H��^r�HӁ�R��D� L�#4.��]t�c31N�}�Һ�쪷o��e��t�q\~Ù����sY��T��X            x������ � �            x������ � �         �   x����J1��3O�w��m�6�>�^�&e���,��3��	?I�B�J�8��E�&ĭ �GrD�)bD"B\R]0�!���O�ưf���L�T�GmZM�J���u}�����~���x���b����pN�4��"��#L]��
�j@�e��U�,V�ڜ��6�q k5j���
i��~h�!�����o�3�'N�X���A;w�VexK^"�n�������<�
n�         F  x��S�n� ��Ϣ�׏��'��ptSiU.B�4�w/��j�Rmv��eתZ)Zp���+^��r�t�R&8���%C�G2��]��j�s�8K"�!�#9�2�g0��xT-����R��c��
c��c�%�G�V�0x@��1�A�,��ԫr6A���l��A��V;ݽ�*��d�Ĝ6y�Vx��Vm�[�
��j��MuL��xj���G9�`���>����~%���R�`]�wM����۶���aO���r�t���H��=�����t����jx�j�Pn�����v%yJ]?؋�,8ދ%��~�N���	���!˲�jj�         �   x���1n�0Eg��&�(ɔ�d�D�1؁�v)z��C�s��?<.�9�G�}߃>B*9��\2KJ��8tւ����O��oI�����w]ߧ�0� K}��sٶ��mњ���n�����H���j�T�8����-]���y���+�+�p����?V��ša'���m��w�B�2��e}1��4��I�|����eb            x������ � �            x������ � �         �  x�}VYn]G���R�b,rYA��d��'� z�}�ܐ��~�~,��ux�V%k���[�Q4�*\�dY+��O�����~���]e�)��*c.�%���V�O��ӟ��o��ʙ���E�E<�TS�~��?~��[~zi*V��X^5�Ŕ�P�}��Y���g�`/k�Z����Vl��sc˷���s�D,T��b}bȵ'��g�m*e�mj+U���������}*ڛ�r�=ʈ�Ň���>������O�I\'���܋ZC۹M��4s�������ծ��ou�^���'(Y�l*�Ѻ���z�>��𢊊jQ��S]3��������wq��0��X� ޽i�E��Xi�sJ0X�Y��(i���n��&� \q]�0+���}:�#�mŦD���L��"� ~�5	���#<�d�S�+���G<i�x[�6��A����V�Wcq���SY=
��� �V��$M3������*�X.�0�5p�v�杰��>t���IEE��h���󌎕<�}����/?ŧ�������zV��e����K�J�����㌣�7���1�fldȩ�7Th΅���_U�5�@ir�ބ
�A�禖r����es8	�P!�m<��}>�簔�����M�
���2�izש쵡�iP�T�����+	����&9v UC�O�)�L�1���Iz��h���`YPk-`�%�eY��~�]�+���E��t8�je0y�Y�,�Ǝ\c��p���u��L�=�F(�g��3+����t����,ٮs�~��N�ǹ/jj�b��s� �}^�N��$,�_�{��ӈ��͘��Ėtra?ɳ]��E��\��& 6���X-]�[�&��R®������#,�Cn��/*<Mb�g�I���<��
L�:�������x��>A��.0^l�
���F�X�}��t��q��xDc%���ȼ��Z�A��׋+n��)�# x�G��s�F=<c/�s�V��pf򱿯�" �҅	0��^�iֵX�4�ӿ����e{����s5�+��
���a�� $B��[�41j0X4 Q��X�?��B@2q�vY�)� ��all�!>_�dS״]r^+�g�t�P���j��a�l/��v��X:r�:�̫�*mݸ�t�2j�*Rp���.���a<e��1R/o�˕���[+�C��a�Ȅ@K���1x�ɼ)
�QB�6y�<��2pX��:' `���I��j���I��J�	$6�!T^̾ �f���B=0ˬ�=��rT�qծ-˧����ǯ_��� �8ZKR���#��uG��"��[����hKA��t�ߺ��+�)I6.�1�"�mbh�@��RA�
� ���,�x�T�� �� ��+��X�u1���d���`��%����b~�����j\t0            x������ � �            x������ � �      
      x������ � �         S   x�ɻ�  КLa��K��!��&�PY����}�z�+��a�3�ȱ�f&�d�̗��FBBȌR6�F�ż�3:� >�2     