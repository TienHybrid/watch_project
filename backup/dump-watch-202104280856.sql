PGDMP          8                y            watch    13.1 (Debian 13.1-1.pgdg100+1)    13.2 k    S           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            T           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            U           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            V           1262    16384    watch    DATABASE     Y   CREATE DATABASE watch WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.utf8';
    DROP DATABASE watch;
                postgres    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
                postgres    false            W           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                   postgres    false    3            �            1259    32854    Transaction    TABLE     �  CREATE TABLE public."Transaction" (
    id integer NOT NULL,
    user_id integer NOT NULL,
    user_name character varying(60) DEFAULT ''::character varying NOT NULL,
    email character varying(60) DEFAULT ''::character varying NOT NULL,
    phone_number character varying(11) DEFAULT ''::character varying NOT NULL,
    address text DEFAULT ''::text NOT NULL,
    content text DEFAULT ''::text NOT NULL,
    status integer DEFAULT 0 NOT NULL,
    shipping_method smallint DEFAULT 0 NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    totalprice integer DEFAULT 0 NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL
);
 !   DROP TABLE public."Transaction";
       public         heap    postgres    false    3            �            1259    32852    Transaction_id_seq    SEQUENCE     �   CREATE SEQUENCE public."Transaction_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public."Transaction_id_seq";
       public          postgres    false    221    3            X           0    0    Transaction_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public."Transaction_id_seq" OWNED BY public."Transaction".id;
          public          postgres    false    220            �            1259    16542    User    TABLE     F  CREATE TABLE public."User" (
    id integer NOT NULL,
    username character varying(60) NOT NULL,
    fullname character varying(60),
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    address character varying,
    phone_number character varying(11),
    avatar_url character varying(256),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    is_deleted boolean DEFAULT false NOT NULL,
    voucher integer[] DEFAULT ARRAY[]::integer[]
);
    DROP TABLE public."User";
       public         heap    postgres    false    3            �            1259    16540    User_id_seq    SEQUENCE     �   CREATE SEQUENCE public."User_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public."User_id_seq";
       public          postgres    false    3    201            Y           0    0    User_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public."User_id_seq" OWNED BY public."User".id;
          public          postgres    false    200            �            1259    32799    cart    TABLE     �  CREATE TABLE public.cart (
    id integer NOT NULL,
    user_id integer NOT NULL,
    user_name character varying(60) DEFAULT ''::character varying NOT NULL,
    email character varying(60) DEFAULT ''::character varying NOT NULL,
    phone_number character varying(11) DEFAULT ''::character varying NOT NULL,
    address text DEFAULT ''::text NOT NULL,
    content text DEFAULT ''::text NOT NULL,
    status integer DEFAULT 0 NOT NULL,
    shipping_method smallint DEFAULT 0 NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    totalprice integer DEFAULT 0 NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL
);
    DROP TABLE public.cart;
       public         heap    postgres    false    3            �            1259    32797    cart_id_seq    SEQUENCE     �   CREATE SEQUENCE public.cart_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE public.cart_id_seq;
       public          postgres    false    217    3            Z           0    0    cart_id_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE public.cart_id_seq OWNED BY public.cart.id;
          public          postgres    false    216            �            1259    32826    cartproduct    TABLE     �  CREATE TABLE public.cartproduct (
    id integer NOT NULL,
    stock_id integer NOT NULL,
    cart_id integer NOT NULL,
    product_id integer NOT NULL,
    quantity integer DEFAULT 0 NOT NULL,
    price integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL
);
    DROP TABLE public.cartproduct;
       public         heap    postgres    false    3            �            1259    32824    cartproduct_id_seq    SEQUENCE     �   CREATE SEQUENCE public.cartproduct_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.cartproduct_id_seq;
       public          postgres    false    3    219            [           0    0    cartproduct_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.cartproduct_id_seq OWNED BY public.cartproduct.id;
          public          postgres    false    218            �            1259    16570    category    TABLE     H  CREATE TABLE public.category (
    id integer NOT NULL,
    name character varying(60) NOT NULL,
    image_url character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    is_deleted boolean DEFAULT false NOT NULL
);
    DROP TABLE public.category;
       public         heap    postgres    false    3            �            1259    16568    category_id_seq    SEQUENCE     �   CREATE SEQUENCE public.category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.category_id_seq;
       public          postgres    false    3    205            \           0    0    category_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.category_id_seq OWNED BY public.category.id;
          public          postgres    false    204            �            1259    16629    place    TABLE     \  CREATE TABLE public.place (
    id integer NOT NULL,
    name character varying(60) NOT NULL,
    short_name character varying(60) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL
);
    DROP TABLE public.place;
       public         heap    postgres    false    3            �            1259    16627    place_id_seq    SEQUENCE     �   CREATE SEQUENCE public.place_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.place_id_seq;
       public          postgres    false    211    3            ]           0    0    place_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.place_id_seq OWNED BY public.place.id;
          public          postgres    false    210            �            1259    16584    product    TABLE       CREATE TABLE public.product (
    id integer NOT NULL,
    name character varying(60) NOT NULL,
    price integer DEFAULT 0 NOT NULL,
    quantity integer DEFAULT 0 NOT NULL,
    category_id integer,
    image_url character varying[] DEFAULT ARRAY[]::character varying[],
    slug character varying,
    description character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    is_deleted boolean DEFAULT false NOT NULL
);
    DROP TABLE public.product;
       public         heap    postgres    false    3            �            1259    16582    product_id_seq    SEQUENCE     �   CREATE SEQUENCE public.product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.product_id_seq;
       public          postgres    false    3    207            ^           0    0    product_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.product_id_seq OWNED BY public.product.id;
          public          postgres    false    206            �            1259    16556    staff    TABLE       CREATE TABLE public.staff (
    id integer NOT NULL,
    username character varying(60) NOT NULL,
    fullname character varying(60),
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    address character varying,
    phone_number character varying(11),
    avatar_url character varying(256),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    is_deleted boolean DEFAULT false NOT NULL
);
    DROP TABLE public.staff;
       public         heap    postgres    false    3            �            1259    16554    staff_id_seq    SEQUENCE     �   CREATE SEQUENCE public.staff_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.staff_id_seq;
       public          postgres    false    3    203            _           0    0    staff_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.staff_id_seq OWNED BY public.staff.id;
          public          postgres    false    202            �            1259    16640    stock    TABLE     C  CREATE TABLE public.stock (
    id integer NOT NULL,
    name character varying(60) NOT NULL,
    place_id integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL
);
    DROP TABLE public.stock;
       public         heap    postgres    false    3            �            1259    16638    stock_id_seq    SEQUENCE     �   CREATE SEQUENCE public.stock_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.stock_id_seq;
       public          postgres    false    213    3            `           0    0    stock_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.stock_id_seq OWNED BY public.stock.id;
          public          postgres    false    212            �            1259    24690    stockinproduct    TABLE     Z  CREATE TABLE public.stockinproduct (
    id integer NOT NULL,
    stock_id integer,
    product_id integer,
    quantity integer NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL
);
 "   DROP TABLE public.stockinproduct;
       public         heap    postgres    false    3            �            1259    24688    stockinproduct_id_seq    SEQUENCE     �   CREATE SEQUENCE public.stockinproduct_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.stockinproduct_id_seq;
       public          postgres    false    3    215            a           0    0    stockinproduct_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.stockinproduct_id_seq OWNED BY public.stockinproduct.id;
          public          postgres    false    214            �            1259    32881    transactionproduct    TABLE     �  CREATE TABLE public.transactionproduct (
    id integer NOT NULL,
    stock_id integer NOT NULL,
    transationc_id integer NOT NULL,
    product_id integer NOT NULL,
    quantity integer DEFAULT 0 NOT NULL,
    price integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL
);
 &   DROP TABLE public.transactionproduct;
       public         heap    postgres    false    3            �            1259    32879    transactionproduct_id_seq    SEQUENCE     �   CREATE SEQUENCE public.transactionproduct_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.transactionproduct_id_seq;
       public          postgres    false    3    223            b           0    0    transactionproduct_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.transactionproduct_id_seq OWNED BY public.transactionproduct.id;
          public          postgres    false    222            �            1259    16616    voucher    TABLE     p  CREATE TABLE public.voucher (
    id integer NOT NULL,
    name character varying(60) NOT NULL,
    type character varying(60) NOT NULL,
    begin_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    end_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL,
    discount integer DEFAULT 0,
    active boolean DEFAULT false,
    code character varying DEFAULT ''::character varying
);
    DROP TABLE public.voucher;
       public         heap    postgres    false    3            �            1259    16614    voucher_id_seq    SEQUENCE     �   CREATE SEQUENCE public.voucher_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.voucher_id_seq;
       public          postgres    false    209    3            c           0    0    voucher_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.voucher_id_seq OWNED BY public.voucher.id;
          public          postgres    false    208            w           2604    32857    Transaction id    DEFAULT     t   ALTER TABLE ONLY public."Transaction" ALTER COLUMN id SET DEFAULT nextval('public."Transaction_id_seq"'::regclass);
 ?   ALTER TABLE public."Transaction" ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    221    220    221            <           2604    16545    User id    DEFAULT     f   ALTER TABLE ONLY public."User" ALTER COLUMN id SET DEFAULT nextval('public."User_id_seq"'::regclass);
 8   ALTER TABLE public."User" ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    201    200    201            e           2604    32802    cart id    DEFAULT     b   ALTER TABLE ONLY public.cart ALTER COLUMN id SET DEFAULT nextval('public.cart_id_seq'::regclass);
 6   ALTER TABLE public.cart ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    216    217    217            q           2604    32829    cartproduct id    DEFAULT     p   ALTER TABLE ONLY public.cartproduct ALTER COLUMN id SET DEFAULT nextval('public.cartproduct_id_seq'::regclass);
 =   ALTER TABLE public.cartproduct ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    218    219    219            E           2604    16573    category id    DEFAULT     j   ALTER TABLE ONLY public.category ALTER COLUMN id SET DEFAULT nextval('public.category_id_seq'::regclass);
 :   ALTER TABLE public.category ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    205    204    205            Y           2604    16632    place id    DEFAULT     d   ALTER TABLE ONLY public.place ALTER COLUMN id SET DEFAULT nextval('public.place_id_seq'::regclass);
 7   ALTER TABLE public.place ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    211    210    211            I           2604    16587 
   product id    DEFAULT     h   ALTER TABLE ONLY public.product ALTER COLUMN id SET DEFAULT nextval('public.product_id_seq'::regclass);
 9   ALTER TABLE public.product ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    207    206    207            A           2604    16559    staff id    DEFAULT     d   ALTER TABLE ONLY public.staff ALTER COLUMN id SET DEFAULT nextval('public.staff_id_seq'::regclass);
 7   ALTER TABLE public.staff ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    203    202    203            ]           2604    16643    stock id    DEFAULT     d   ALTER TABLE ONLY public.stock ALTER COLUMN id SET DEFAULT nextval('public.stock_id_seq'::regclass);
 7   ALTER TABLE public.stock ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    213    212    213            a           2604    24693    stockinproduct id    DEFAULT     v   ALTER TABLE ONLY public.stockinproduct ALTER COLUMN id SET DEFAULT nextval('public.stockinproduct_id_seq'::regclass);
 @   ALTER TABLE public.stockinproduct ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    214    215    215            �           2604    32884    transactionproduct id    DEFAULT     ~   ALTER TABLE ONLY public.transactionproduct ALTER COLUMN id SET DEFAULT nextval('public.transactionproduct_id_seq'::regclass);
 D   ALTER TABLE public.transactionproduct ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    223    222    223            P           2604    16619 
   voucher id    DEFAULT     h   ALTER TABLE ONLY public.voucher ALTER COLUMN id SET DEFAULT nextval('public.voucher_id_seq'::regclass);
 9   ALTER TABLE public.voucher ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    209    208    209            N          0    32854    Transaction 
   TABLE DATA           �   COPY public."Transaction" (id, user_id, user_name, email, phone_number, address, content, status, shipping_method, created_at, updated_at, totalprice, is_deleted) FROM stdin;
    public          postgres    false    221            :          0    16542    User 
   TABLE DATA           �   COPY public."User" (id, username, fullname, email, password, address, phone_number, avatar_url, created_at, updated_at, is_deleted, voucher) FROM stdin;
    public          postgres    false    201            J          0    32799    cart 
   TABLE DATA           �   COPY public.cart (id, user_id, user_name, email, phone_number, address, content, status, shipping_method, created_at, updated_at, totalprice, is_deleted) FROM stdin;
    public          postgres    false    217            L          0    32826    cartproduct 
   TABLE DATA           }   COPY public.cartproduct (id, stock_id, cart_id, product_id, quantity, price, created_at, updated_at, is_deleted) FROM stdin;
    public          postgres    false    219            >          0    16570    category 
   TABLE DATA           [   COPY public.category (id, name, image_url, created_at, updated_at, is_deleted) FROM stdin;
    public          postgres    false    205            D          0    16629    place 
   TABLE DATA           Y   COPY public.place (id, name, short_name, created_at, updated_at, is_deleted) FROM stdin;
    public          postgres    false    211            @          0    16584    product 
   TABLE DATA           �   COPY public.product (id, name, price, quantity, category_id, image_url, slug, description, created_at, updated_at, is_deleted) FROM stdin;
    public          postgres    false    207            <          0    16556    staff 
   TABLE DATA           �   COPY public.staff (id, username, fullname, email, password, address, phone_number, avatar_url, created_at, updated_at, is_deleted) FROM stdin;
    public          postgres    false    203            F          0    16640    stock 
   TABLE DATA           W   COPY public.stock (id, name, place_id, created_at, updated_at, is_deleted) FROM stdin;
    public          postgres    false    213            H          0    24690    stockinproduct 
   TABLE DATA           p   COPY public.stockinproduct (id, stock_id, product_id, quantity, created_at, updated_at, is_deleted) FROM stdin;
    public          postgres    false    215            P          0    32881    transactionproduct 
   TABLE DATA           �   COPY public.transactionproduct (id, stock_id, transationc_id, product_id, quantity, price, created_at, updated_at, is_deleted) FROM stdin;
    public          postgres    false    223            B          0    16616    voucher 
   TABLE DATA           �   COPY public.voucher (id, name, type, begin_date, end_date, created_at, updated_at, is_deleted, discount, active, code) FROM stdin;
    public          postgres    false    209            d           0    0    Transaction_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public."Transaction_id_seq"', 1, false);
          public          postgres    false    220            e           0    0    User_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public."User_id_seq"', 34, true);
          public          postgres    false    200            f           0    0    cart_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('public.cart_id_seq', 1, true);
          public          postgres    false    216            g           0    0    cartproduct_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.cartproduct_id_seq', 3, true);
          public          postgres    false    218            h           0    0    category_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.category_id_seq', 35, true);
          public          postgres    false    204            i           0    0    place_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.place_id_seq', 3, true);
          public          postgres    false    210            j           0    0    product_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.product_id_seq', 36, true);
          public          postgres    false    206            k           0    0    staff_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.staff_id_seq', 1, true);
          public          postgres    false    202            l           0    0    stock_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.stock_id_seq', 4, true);
          public          postgres    false    212            m           0    0    stockinproduct_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.stockinproduct_id_seq', 43, true);
          public          postgres    false    214            n           0    0    transactionproduct_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.transactionproduct_id_seq', 1, false);
          public          postgres    false    222            o           0    0    voucher_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.voucher_id_seq', 4, true);
          public          postgres    false    208            �           2606    16609    User User_email_key 
   CONSTRAINT     S   ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_email_key" UNIQUE (email);
 A   ALTER TABLE ONLY public."User" DROP CONSTRAINT "User_email_key";
       public            postgres    false    201            �           2606    16611    User User_username_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_username_key" UNIQUE (username);
 D   ALTER TABLE ONLY public."User" DROP CONSTRAINT "User_username_key";
       public            postgres    false    201            �           2606    32818    cart cart_pk 
   CONSTRAINT     J   ALTER TABLE ONLY public.cart
    ADD CONSTRAINT cart_pk PRIMARY KEY (id);
 6   ALTER TABLE ONLY public.cart DROP CONSTRAINT cart_pk;
       public            postgres    false    217            �           2606    32836    cartproduct cart_product_pk 
   CONSTRAINT     Y   ALTER TABLE ONLY public.cartproduct
    ADD CONSTRAINT cart_product_pk PRIMARY KEY (id);
 E   ALTER TABLE ONLY public.cartproduct DROP CONSTRAINT cart_product_pk;
       public            postgres    false    219            �           2606    16581    category category_pk 
   CONSTRAINT     R   ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pk PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.category DROP CONSTRAINT category_pk;
       public            postgres    false    205            �           2606    16637    place place_pk 
   CONSTRAINT     L   ALTER TABLE ONLY public.place
    ADD CONSTRAINT place_pk PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.place DROP CONSTRAINT place_pk;
       public            postgres    false    211            �           2606    16597    product product_pk 
   CONSTRAINT     P   ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_pk PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.product DROP CONSTRAINT product_pk;
       public            postgres    false    207            �           2606    16613    product product_slug_key 
   CONSTRAINT     S   ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_slug_key UNIQUE (slug);
 B   ALTER TABLE ONLY public.product DROP CONSTRAINT product_slug_key;
       public            postgres    false    207            �           2606    16605    staff staff_email_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.staff
    ADD CONSTRAINT staff_email_key UNIQUE (email);
 ?   ALTER TABLE ONLY public.staff DROP CONSTRAINT staff_email_key;
       public            postgres    false    203            �           2606    16567    staff staff_pk 
   CONSTRAINT     L   ALTER TABLE ONLY public.staff
    ADD CONSTRAINT staff_pk PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.staff DROP CONSTRAINT staff_pk;
       public            postgres    false    203            �           2606    16607    staff staff_username_key 
   CONSTRAINT     W   ALTER TABLE ONLY public.staff
    ADD CONSTRAINT staff_username_key UNIQUE (username);
 B   ALTER TABLE ONLY public.staff DROP CONSTRAINT staff_username_key;
       public            postgres    false    203            �           2606    24698 "   stockinproduct stock_in_product_pk 
   CONSTRAINT     `   ALTER TABLE ONLY public.stockinproduct
    ADD CONSTRAINT stock_in_product_pk PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.stockinproduct DROP CONSTRAINT stock_in_product_pk;
       public            postgres    false    215            �           2606    16648    stock stock_pk 
   CONSTRAINT     L   ALTER TABLE ONLY public.stock
    ADD CONSTRAINT stock_pk PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.stock DROP CONSTRAINT stock_pk;
       public            postgres    false    213            �           2606    32873    Transaction transaction_pk 
   CONSTRAINT     Z   ALTER TABLE ONLY public."Transaction"
    ADD CONSTRAINT transaction_pk PRIMARY KEY (id);
 F   ALTER TABLE ONLY public."Transaction" DROP CONSTRAINT transaction_pk;
       public            postgres    false    221            �           2606    32891 )   transactionproduct transaction_product_pk 
   CONSTRAINT     g   ALTER TABLE ONLY public.transactionproduct
    ADD CONSTRAINT transaction_product_pk PRIMARY KEY (id);
 S   ALTER TABLE ONLY public.transactionproduct DROP CONSTRAINT transaction_product_pk;
       public            postgres    false    223            �           2606    16553    User user_pk 
   CONSTRAINT     L   ALTER TABLE ONLY public."User"
    ADD CONSTRAINT user_pk PRIMARY KEY (id);
 8   ALTER TABLE ONLY public."User" DROP CONSTRAINT user_pk;
       public            postgres    false    201            �           2606    16626    voucher voucher_pk 
   CONSTRAINT     P   ALTER TABLE ONLY public.voucher
    ADD CONSTRAINT voucher_pk PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.voucher DROP CONSTRAINT voucher_pk;
       public            postgres    false    209            �           2606    32842    cartproduct cart_in_product_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.cartproduct
    ADD CONSTRAINT cart_in_product_fk FOREIGN KEY (product_id) REFERENCES public.product(id);
 H   ALTER TABLE ONLY public.cartproduct DROP CONSTRAINT cart_in_product_fk;
       public          postgres    false    219    207    2968            �           2606    32847    cartproduct cart_product_fk    FK CONSTRAINT     y   ALTER TABLE ONLY public.cartproduct
    ADD CONSTRAINT cart_product_fk FOREIGN KEY (cart_id) REFERENCES public.cart(id);
 E   ALTER TABLE ONLY public.cartproduct DROP CONSTRAINT cart_product_fk;
       public          postgres    false    217    219    2980            �           2606    32837 !   cartproduct cart_product_stock_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.cartproduct
    ADD CONSTRAINT cart_product_stock_fk FOREIGN KEY (stock_id) REFERENCES public.stock(id);
 K   ALTER TABLE ONLY public.cartproduct DROP CONSTRAINT cart_product_stock_fk;
       public          postgres    false    213    2976    219            �           2606    32819    cart cart_user_fk    FK CONSTRAINT     q   ALTER TABLE ONLY public.cart
    ADD CONSTRAINT cart_user_fk FOREIGN KEY (user_id) REFERENCES public."User"(id);
 ;   ALTER TABLE ONLY public.cart DROP CONSTRAINT cart_user_fk;
       public          postgres    false    2958    217    201            �           2606    16598    product category_product_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.product
    ADD CONSTRAINT category_product_fk FOREIGN KEY (category_id) REFERENCES public.category(id);
 E   ALTER TABLE ONLY public.product DROP CONSTRAINT category_product_fk;
       public          postgres    false    2966    207    205            �           2606    24704    stockinproduct product_fk    FK CONSTRAINT     }   ALTER TABLE ONLY public.stockinproduct
    ADD CONSTRAINT product_fk FOREIGN KEY (product_id) REFERENCES public.product(id);
 C   ALTER TABLE ONLY public.stockinproduct DROP CONSTRAINT product_fk;
       public          postgres    false    207    2968    215            �           2606    24699    stockinproduct stock_fk    FK CONSTRAINT     w   ALTER TABLE ONLY public.stockinproduct
    ADD CONSTRAINT stock_fk FOREIGN KEY (stock_id) REFERENCES public.stock(id);
 A   ALTER TABLE ONLY public.stockinproduct DROP CONSTRAINT stock_fk;
       public          postgres    false    2976    213    215            �           2606    16649    stock stock_place_fk    FK CONSTRAINT     t   ALTER TABLE ONLY public.stock
    ADD CONSTRAINT stock_place_fk FOREIGN KEY (place_id) REFERENCES public.place(id);
 >   ALTER TABLE ONLY public.stock DROP CONSTRAINT stock_place_fk;
       public          postgres    false    2974    211    213            �           2606    32897 ,   transactionproduct transaction_in_product_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.transactionproduct
    ADD CONSTRAINT transaction_in_product_fk FOREIGN KEY (product_id) REFERENCES public.product(id);
 V   ALTER TABLE ONLY public.transactionproduct DROP CONSTRAINT transaction_in_product_fk;
       public          postgres    false    2968    223    207            �           2606    32902 )   transactionproduct transaction_product_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.transactionproduct
    ADD CONSTRAINT transaction_product_fk FOREIGN KEY (transationc_id) REFERENCES public."Transaction"(id);
 S   ALTER TABLE ONLY public.transactionproduct DROP CONSTRAINT transaction_product_fk;
       public          postgres    false    2984    223    221            �           2606    32892 /   transactionproduct transaction_product_stock_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.transactionproduct
    ADD CONSTRAINT transaction_product_stock_fk FOREIGN KEY (stock_id) REFERENCES public.stock(id);
 Y   ALTER TABLE ONLY public.transactionproduct DROP CONSTRAINT transaction_product_stock_fk;
       public          postgres    false    2976    223    213            �           2606    32874    Transaction transaction_user_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public."Transaction"
    ADD CONSTRAINT transaction_user_fk FOREIGN KEY (user_id) REFERENCES public."User"(id);
 K   ALTER TABLE ONLY public."Transaction" DROP CONSTRAINT transaction_user_fk;
       public          postgres    false    2958    221    201            N      x������ � �      :   >  x���1O�0F��Wt(c���ؑ�$�JH�%>������N�F�餷�{�%�S�z9�����u����p��gFc���F���i�6Z\CH���*��``lC4>h�V��y�ƨ*�! ��.̞S�,c?I��b4L�I�C���S�|UeS���c�i��ţ�q��!��Png�.�6HZ��� 9c�����}�<H�9C��Q�A����
����/�w<����[1��l����vX���EV4;B	���T�����������A��e�ƈR��k2M;�@Z��̬�j5R��d)vʟ�<�? #u�b      J   d   x�3�4�,�L�K-S鹉�9z�����F�&�f����
�(�=�=3��$���� ��uLt��-��L��,�LLL,�Ip�q��qqq $x�      L   ;   x�3�4�BN##C]]#3C+#3+3=SsC|Ri\F`��&�F���� ��      >   1  x���1N�0@��Y���qGBH���:"ENk�Ai%�[ 13q�20�#�{�&Dl��N����ޓ>������F����f�����86U�K��޻NY��s�֪�z�t����e�T�nV���Ƥ���[����/���u/g�j���������������ԌF�$�3�(˙����$IĎ��vJ{V�D
A{`9��$"2��C���a����r�(��p�Db!��bPr��X��mլ�LH
Ι��T &� MC� ~�i-~?��{c���EF�`'3Ɵ��J!d�F�Ħ9�      D   �   x�3��8�@�����~�FF��&�F�
�FV�V�zƖ&�f��Ҹ�9=��qx��of^�G�3�C+#3=SCKcC|Ri\F�G&�]�kk^:������,-�LML�I�q��qqq q5�      @   �  x����n�0���Sd�'>Ǘ8�j�RMG���y&��(7&)��q��E�&X�v`:��^xq�}���������M�m������m�{���M��H�}�x�p��,������� /w�J�Y?�;]d~ѶE����u[�i�
ֺʚT��*�%�u��];��6x�k����_�٠�*��F�mW������R?�R�G�Т C�(�(�S
~s��l�v�9�F�ɶ��9~Y97K)�� � c1�|&Bq�����h�X^zo����^��pq�-.�Ζ�h]>�N��B
{pE@���(8���TDn�*����_,6g�?Fx�d���5+u�6�7�fWL�o�B�i3��D�B��z.Lہ�Ȧb��"�G$ I8�U�7��]����y2XJ%�:Q14ɧi���&r��qcjZ�d"A��{�V���E�����2� ���z���xY�c��}3�1���ǥܽ�]�����      <   �   x�}��N�0Eg�+:�1��Ǒ,�	LH�s������b�LW�,G�¹���v(;m�U�����"�Lxj��_�b�y$�]��4�j�;o-B�d�';0��K480t�+s
�
��P�����{)ò��|m�;M�L1N+SZ�I~��r�����ڇ�BC)���2�\(�|�в���uZ[h>��Dky��@@U��Q��z�Ck��O�꽩���Y�      F   �   x�3����W82����
>�y�F�FF��&�F�
�FV&�V�&z�&F����Ҹ��fyg�*���P�i����D������L	�����&g(�&fb3��X�������T�!ب��ļ���Ë�9����P�������Ri\1z\\\ EfD�      H   �   x�}���0�Vi�Ȁj������ĊF��i�C���+8�N�/`X(9��ڡ��U���I��*�OE_N�BH��"��F�U0)�E��#�MVcX�b�Cw3������y�+c|�r`:��'ex����0?��$�DŒ����A��)��������Z� �o�      P      x������ � �      B     x���Mj�@���)fӥ2�Zgg�HK���D��b�3t[��� �B]Z��7ɤf���¬�o��x|<���f����#�/�r�V���Sb`nP�0����l0����#Tr[
ab*�eE��L���CWQ)����esh���0�����!�atљ1�Pŋ��L3�}�#=��[�FE[=n��`�_>�˥dT�rA�P�v�5q�jz1�`Z�)���%����C[�(�_7'�ɸ���.�%�c�²�2@�6N��� ���&���y�      k    S           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            T           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            U           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            V           1262    16384    watch    DATABASE     Y   CREATE DATABASE watch WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.utf8';
    DROP DATABASE watch;
                postgres    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
                postgres    false            W           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                   postgres    false    3            �            1259    32854    Transaction    TABLE     �  CREATE TABLE public."Transaction" (
    id integer NOT NULL,
    user_id integer NOT NULL,
    user_name character varying(60) DEFAULT ''::character varying NOT NULL,
    email character varying(60) DEFAULT ''::character varying NOT NULL,
    phone_number character varying(11) DEFAULT ''::character varying NOT NULL,
    address text DEFAULT ''::text NOT NULL,
    content text DEFAULT ''::text NOT NULL,
    status integer DEFAULT 0 NOT NULL,
    shipping_method smallint DEFAULT 0 NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    totalprice integer DEFAULT 0 NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL
);
 !   DROP TABLE public."Transaction";
       public         heap    postgres    false    3            �            1259    32852    Transaction_id_seq    SEQUENCE     �   CREATE SEQUENCE public."Transaction_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public."Transaction_id_seq";
       public          postgres    false    221    3            X           0    0    Transaction_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public."Transaction_id_seq" OWNED BY public."Transaction".id;
          public          postgres    false    220            �            1259    16542    User    TABLE     F  CREATE TABLE public."User" (
    id integer NOT NULL,
    username character varying(60) NOT NULL,
    fullname character varying(60),
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    address character varying,
    phone_number character varying(11),
    avatar_url character varying(256),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    is_deleted boolean DEFAULT false NOT NULL,
    voucher integer[] DEFAULT ARRAY[]::integer[]
);
    DROP TABLE public."User";
       public         heap    postgres    false    3            �            1259    16540    User_id_seq    SEQUENCE     �   CREATE SEQUENCE public."User_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public."User_id_seq";
       public          postgres    false    3    201            Y           0    0    User_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public."User_id_seq" OWNED BY public."User".id;
          public          postgres    false    200            �            1259    32799    cart    TABLE     �  CREATE TABLE public.cart (
    id integer NOT NULL,
    user_id integer NOT NULL,
    user_name character varying(60) DEFAULT ''::character varying NOT NULL,
    email character varying(60) DEFAULT ''::character varying NOT NULL,
    phone_number character varying(11) DEFAULT ''::character varying NOT NULL,
    address text DEFAULT ''::text NOT NULL,
    content text DEFAULT ''::text NOT NULL,
    status integer DEFAULT 0 NOT NULL,
    shipping_method smallint DEFAULT 0 NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    totalprice integer DEFAULT 0 NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL
);
    DROP TABLE public.cart;
       public         heap    postgres    false    3            �            1259    32797    cart_id_seq    SEQUENCE     �   CREATE SEQUENCE public.cart_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE public.cart_id_seq;
       public          postgres    false    217    3            Z           0    0    cart_id_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE public.cart_id_seq OWNED BY public.cart.id;
          public          postgres    false    216            �            1259    32826    cartproduct    TABLE     �  CREATE TABLE public.cartproduct (
    id integer NOT NULL,
    stock_id integer NOT NULL,
    cart_id integer NOT NULL,
    product_id integer NOT NULL,
    quantity integer DEFAULT 0 NOT NULL,
    price integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL
);
    DROP TABLE public.cartproduct;
       public         heap    postgres    false    3            �            1259    32824    cartproduct_id_seq    SEQUENCE     �   CREATE SEQUENCE public.cartproduct_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.cartproduct_id_seq;
       public          postgres    false    3    219            [           0    0    cartproduct_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.cartproduct_id_seq OWNED BY public.cartproduct.id;
          public          postgres    false    218            �            1259    16570    category    TABLE     H  CREATE TABLE public.category (
    id integer NOT NULL,
    name character varying(60) NOT NULL,
    image_url character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    is_deleted boolean DEFAULT false NOT NULL
);
    DROP TABLE public.category;
       public         heap    postgres    false    3            �            1259    16568    category_id_seq    SEQUENCE     �   CREATE SEQUENCE public.category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.category_id_seq;
       public          postgres    false    3    205            \           0    0    category_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.category_id_seq OWNED BY public.category.id;
          public          postgres    false    204            �            1259    16629    place    TABLE     \  CREATE TABLE public.place (
    id integer NOT NULL,
    name character varying(60) NOT NULL,
    short_name character varying(60) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL
);
    DROP TABLE public.place;
       public         heap    postgres    false    3            �            1259    16627    place_id_seq    SEQUENCE     �   CREATE SEQUENCE public.place_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.place_id_seq;
       public          postgres    false    211    3            ]           0    0    place_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.place_id_seq OWNED BY public.place.id;
          public          postgres    false    210            �            1259    16584    product    TABLE       CREATE TABLE public.product (
    id integer NOT NULL,
    name character varying(60) NOT NULL,
    price integer DEFAULT 0 NOT NULL,
    quantity integer DEFAULT 0 NOT NULL,
    category_id integer,
    image_url character varying[] DEFAULT ARRAY[]::character varying[],
    slug character varying,
    description character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    is_deleted boolean DEFAULT false NOT NULL
);
    DROP TABLE public.product;
       public         heap    postgres    false    3            �            1259    16582    product_id_seq    SEQUENCE     �   CREATE SEQUENCE public.product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.product_id_seq;
       public          postgres    false    3    207            ^           0    0    product_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.product_id_seq OWNED BY public.product.id;
          public          postgres    false    206            �            1259    16556    staff    TABLE       CREATE TABLE public.staff (
    id integer NOT NULL,
    username character varying(60) NOT NULL,
    fullname character varying(60),
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    address character varying,
    phone_number character varying(11),
    avatar_url character varying(256),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    is_deleted boolean DEFAULT false NOT NULL
);
    DROP TABLE public.staff;
       public         heap    postgres    false    3            �            1259    16554    staff_id_seq    SEQUENCE     �   CREATE SEQUENCE public.staff_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.staff_id_seq;
       public          postgres    false    3    203            _           0    0    staff_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.staff_id_seq OWNED BY public.staff.id;
          public          postgres    false    202            �            1259    16640    stock    TABLE     C  CREATE TABLE public.stock (
    id integer NOT NULL,
    name character varying(60) NOT NULL,
    place_id integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL
);
    DROP TABLE public.stock;
       public         heap    postgres    false    3            �            1259    16638    stock_id_seq    SEQUENCE     �   CREATE SEQUENCE public.stock_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.stock_id_seq;
       public          postgres    false    213    3            `           0    0    stock_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.stock_id_seq OWNED BY public.stock.id;
          public          postgres    false    212            �            1259    24690    stockinproduct    TABLE     Z  CREATE TABLE public.stockinproduct (
    id integer NOT NULL,
    stock_id integer,
    product_id integer,
    quantity integer NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL
);
 "   DROP TABLE public.stockinproduct;
       public         heap    postgres    false    3            �            1259    24688    stockinproduct_id_seq    SEQUENCE     �   CREATE SEQUENCE public.stockinproduct_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.stockinproduct_id_seq;
       public          postgres    false    3    215            a           0    0    stockinproduct_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.stockinproduct_id_seq OWNED BY public.stockinproduct.id;
          public          postgres    false    214            �            1259    32881    transactionproduct    TABLE     �  CREATE TABLE public.transactionproduct (
    id integer NOT NULL,
    stock_id integer NOT NULL,
    transationc_id integer NOT NULL,
    product_id integer NOT NULL,
    quantity integer DEFAULT 0 NOT NULL,
    price integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL
);
 &   DROP TABLE public.transactionproduct;
       public         heap    postgres    false    3            �            1259    32879    transactionproduct_id_seq    SEQUENCE     �   CREATE SEQUENCE public.transactionproduct_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.transactionproduct_id_seq;
       public          postgres    false    3    223            b           0    0    transactionproduct_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.transactionproduct_id_seq OWNED BY public.transactionproduct.id;
          public          postgres    false    222            �            1259    16616    voucher    TABLE     p  CREATE TABLE public.voucher (
    id integer NOT NULL,
    name character varying(60) NOT NULL,
    type character varying(60) NOT NULL,
    begin_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    end_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL,
    discount integer DEFAULT 0,
    active boolean DEFAULT false,
    code character varying DEFAULT ''::character varying
);
    DROP TABLE public.voucher;
       public         heap    postgres    false    3            �            1259    16614    voucher_id_seq    SEQUENCE     �   CREATE SEQUENCE public.voucher_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.voucher_id_seq;
       public          postgres    false    209    3            c           0    0    voucher_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.voucher_id_seq OWNED BY public.voucher.id;
          public          postgres    false    208            w           2604    32857    Transaction id    DEFAULT     t   ALTER TABLE ONLY public."Transaction" ALTER COLUMN id SET DEFAULT nextval('public."Transaction_id_seq"'::regclass);
 ?   ALTER TABLE public."Transaction" ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    221    220    221            <           2604    16545    User id    DEFAULT     f   ALTER TABLE ONLY public."User" ALTER COLUMN id SET DEFAULT nextval('public."User_id_seq"'::regclass);
 8   ALTER TABLE public."User" ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    201    200    201            e           2604    32802    cart id    DEFAULT     b   ALTER TABLE ONLY public.cart ALTER COLUMN id SET DEFAULT nextval('public.cart_id_seq'::regclass);
 6   ALTER TABLE public.cart ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    216    217    217            q           2604    32829    cartproduct id    DEFAULT     p   ALTER TABLE ONLY public.cartproduct ALTER COLUMN id SET DEFAULT nextval('public.cartproduct_id_seq'::regclass);
 =   ALTER TABLE public.cartproduct ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    218    219    219            E           2604    16573    category id    DEFAULT     j   ALTER TABLE ONLY public.category ALTER COLUMN id SET DEFAULT nextval('public.category_id_seq'::regclass);
 :   ALTER TABLE public.category ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    205    204    205            Y           2604    16632    place id    DEFAULT     d   ALTER TABLE ONLY public.place ALTER COLUMN id SET DEFAULT nextval('public.place_id_seq'::regclass);
 7   ALTER TABLE public.place ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    211    210    211            I           2604    16587 
   product id    DEFAULT     h   ALTER TABLE ONLY public.product ALTER COLUMN id SET DEFAULT nextval('public.product_id_seq'::regclass);
 9   ALTER TABLE public.product ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    207    206    207            A           2604    16559    staff id    DEFAULT     d   ALTER TABLE ONLY public.staff ALTER COLUMN id SET DEFAULT nextval('public.staff_id_seq'::regclass);
 7   ALTER TABLE public.staff ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    203    202    203            ]           2604    16643    stock id    DEFAULT     d   ALTER TABLE ONLY public.stock ALTER COLUMN id SET DEFAULT nextval('public.stock_id_seq'::regclass);
 7   ALTER TABLE public.stock ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    213    212    213            a           2604    24693    stockinproduct id    DEFAULT     v   ALTER TABLE ONLY public.stockinproduct ALTER COLUMN id SET DEFAULT nextval('public.stockinproduct_id_seq'::regclass);
 @   ALTER TABLE public.stockinproduct ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    214    215    215            �           2604    32884    transactionproduct id    DEFAULT     ~   ALTER TABLE ONLY public.transactionproduct ALTER COLUMN id SET DEFAULT nextval('public.transactionproduct_id_seq'::regclass);
 D   ALTER TABLE public.transactionproduct ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    223    222    223            P           2604    16619 
   voucher id    DEFAULT     h   ALTER TABLE ONLY public.voucher ALTER COLUMN id SET DEFAULT nextval('public.voucher_id_seq'::regclass);
 9   ALTER TABLE public.voucher ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    209    208    209            N          0    32854    Transaction 
   TABLE DATA           �   COPY public."Transaction" (id, user_id, user_name, email, phone_number, address, content, status, shipping_method, created_at, updated_at, totalprice, is_deleted) FROM stdin;
    public          postgres    false    221   \	       :          0    16542    User 
   TABLE DATA           �   COPY public."User" (id, username, fullname, email, password, address, phone_number, avatar_url, created_at, updated_at, is_deleted, voucher) FROM stdin;
    public          postgres    false    201           J          0    32799    cart 
   TABLE DATA           �   COPY public.cart (id, user_id, user_name, email, phone_number, address, content, status, shipping_method, created_at, updated_at, totalprice, is_deleted) FROM stdin;
    public          postgres    false    217   H       L          0    32826    cartproduct 
   TABLE DATA           }   COPY public.cartproduct (id, stock_id, cart_id, product_id, quantity, price, created_at, updated_at, is_deleted) FROM stdin;
    public          postgres    false    219   n        >          0    16570    category 
   TABLE DATA           [   COPY public.category (id, name, image_url, created_at, updated_at, is_deleted) FROM stdin;
    public          postgres    false    205   E        D          0    16629    place 
   TABLE DATA           Y   COPY public.place (id, name, short_name, created_at, updated_at, is_deleted) FROM stdin;
    public          postgres    false    211   ;       @          0    16584    product 
   TABLE DATA           �   COPY public.product (id, name, price, quantity, category_id, image_url, slug, description, created_at, updated_at, is_deleted) FROM stdin;
    public          postgres    false    207   �        <          0    16556    staff 
   TABLE DATA           �   COPY public.staff (id, username, fullname, email, password, address, phone_number, avatar_url, created_at, updated_at, is_deleted) FROM stdin;
    public          postgres    false    203   �       F          0    16640    stock 
   TABLE DATA           W   COPY public.stock (id, name, place_id, created_at, updated_at, is_deleted) FROM stdin;
    public          postgres    false    213   �        H          0    24690    stockinproduct 
   TABLE DATA           p   COPY public.stockinproduct (id, stock_id, product_id, quantity, created_at, updated_at, is_deleted) FROM stdin;
    public          postgres    false    215   �        P          0    32881    transactionproduct 
   TABLE DATA           �   COPY public.transactionproduct (id, stock_id, transationc_id, product_id, quantity, price, created_at, updated_at, is_deleted) FROM stdin;
    public          postgres    false    223   �        B          0    16616    voucher 
   TABLE DATA           �   COPY public.voucher (id, name, type, begin_date, end_date, created_at, updated_at, is_deleted, discount, active, code) FROM stdin;
    public          postgres    false    209           d           0    0    Transaction_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public."Transaction_id_seq"', 1, false);
          public          postgres    false    220            e           0    0    User_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public."User_id_seq"', 34, true);
          public          postgres    false    200            f           0    0    cart_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('public.cart_id_seq', 1, true);
          public          postgres    false    216            g           0    0    cartproduct_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.cartproduct_id_seq', 3, true);
          public          postgres    false    218            h           0    0    category_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.category_id_seq', 35, true);
          public          postgres    false    204            i           0    0    place_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.place_id_seq', 3, true);
          public          postgres    false    210            j           0    0    product_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.product_id_seq', 36, true);
          public          postgres    false    206            k           0    0    staff_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.staff_id_seq', 1, true);
          public          postgres    false    202            l           0    0    stock_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.stock_id_seq', 4, true);
          public          postgres    false    212            m           0    0    stockinproduct_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.stockinproduct_id_seq', 43, true);
          public          postgres    false    214            n           0    0    transactionproduct_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.transactionproduct_id_seq', 1, false);
          public          postgres    false    222            o           0    0    voucher_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.voucher_id_seq', 4, true);
          public          postgres    false    208            �           2606    16609    User User_email_key 
   CONSTRAINT     S   ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_email_key" UNIQUE (email);
 A   ALTER TABLE ONLY public."User" DROP CONSTRAINT "User_email_key";
       public            postgres    false    201            �           2606    16611    User User_username_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_username_key" UNIQUE (username);
 D   ALTER TABLE ONLY public."User" DROP CONSTRAINT "User_username_key";
       public            postgres    false    201            �           2606    32818    cart cart_pk 
   CONSTRAINT     J   ALTER TABLE ONLY public.cart
    ADD CONSTRAINT cart_pk PRIMARY KEY (id);
 6   ALTER TABLE ONLY public.cart DROP CONSTRAINT cart_pk;
       public            postgres    false    217            �           2606    32836    cartproduct cart_product_pk 
   CONSTRAINT     Y   ALTER TABLE ONLY public.cartproduct
    ADD CONSTRAINT cart_product_pk PRIMARY KEY (id);
 E   ALTER TABLE ONLY public.cartproduct DROP CONSTRAINT cart_product_pk;
       public            postgres    false    219            �           2606    16581    category category_pk 
   CONSTRAINT     R   ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pk PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.category DROP CONSTRAINT category_pk;
       public            postgres    false    205            �           2606    16637    place place_pk 
   CONSTRAINT     L   ALTER TABLE ONLY public.place
    ADD CONSTRAINT place_pk PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.place DROP CONSTRAINT place_pk;
       public            postgres    false    211            �           2606    16597    product product_pk 
   CONSTRAINT     P   ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_pk PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.product DROP CONSTRAINT product_pk;
       public            postgres    false    207            �           2606    16613    product product_slug_key 
   CONSTRAINT     S   ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_slug_key UNIQUE (slug);
 B   ALTER TABLE ONLY public.product DROP CONSTRAINT product_slug_key;
       public            postgres    false    207            �           2606    16605    staff staff_email_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.staff
    ADD CONSTRAINT staff_email_key UNIQUE (email);
 ?   ALTER TABLE ONLY public.staff DROP CONSTRAINT staff_email_key;
       public            postgres    false    203            �           2606    16567    staff staff_pk 
   CONSTRAINT     L   ALTER TABLE ONLY public.staff
    ADD CONSTRAINT staff_pk PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.staff DROP CONSTRAINT staff_pk;
       public            postgres    false    203            �           2606    16607    staff staff_username_key 
   CONSTRAINT     W   ALTER TABLE ONLY public.staff
    ADD CONSTRAINT staff_username_key UNIQUE (username);
 B   ALTER TABLE ONLY public.staff DROP CONSTRAINT staff_username_key;
       public            postgres    false    203            �           2606    24698 "   stockinproduct stock_in_product_pk 
   CONSTRAINT     `   ALTER TABLE ONLY public.stockinproduct
    ADD CONSTRAINT stock_in_product_pk PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.stockinproduct DROP CONSTRAINT stock_in_product_pk;
       public            postgres    false    215            �           2606    16648    stock stock_pk 
   CONSTRAINT     L   ALTER TABLE ONLY public.stock
    ADD CONSTRAINT stock_pk PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.stock DROP CONSTRAINT stock_pk;
       public            postgres    false    213            �           2606    32873    Transaction transaction_pk 
   CONSTRAINT     Z   ALTER TABLE ONLY public."Transaction"
    ADD CONSTRAINT transaction_pk PRIMARY KEY (id);
 F   ALTER TABLE ONLY public."Transaction" DROP CONSTRAINT transaction_pk;
       public            postgres    false    221            �           2606    32891 )   transactionproduct transaction_product_pk 
   CONSTRAINT     g   ALTER TABLE ONLY public.transactionproduct
    ADD CONSTRAINT transaction_product_pk PRIMARY KEY (id);
 S   ALTER TABLE ONLY public.transactionproduct DROP CONSTRAINT transaction_product_pk;
       public            postgres    false    223            �           2606    16553    User user_pk 
   CONSTRAINT     L   ALTER TABLE ONLY public."User"
    ADD CONSTRAINT user_pk PRIMARY KEY (id);
 8   ALTER TABLE ONLY public."User" DROP CONSTRAINT user_pk;
       public            postgres    false    201            �           2606    16626    voucher voucher_pk 
   CONSTRAINT     P   ALTER TABLE ONLY public.voucher
    ADD CONSTRAINT voucher_pk PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.voucher DROP CONSTRAINT voucher_pk;
       public            postgres    false    209            �           2606    32842    cartproduct cart_in_product_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.cartproduct
    ADD CONSTRAINT cart_in_product_fk FOREIGN KEY (product_id) REFERENCES public.product(id);
 H   ALTER TABLE ONLY public.cartproduct DROP CONSTRAINT cart_in_product_fk;
       public          postgres    false    219    207    2968            �           2606    32847    cartproduct cart_product_fk    FK CONSTRAINT     y   ALTER TABLE ONLY public.cartproduct
    ADD CONSTRAINT cart_product_fk FOREIGN KEY (cart_id) REFERENCES public.cart(id);
 E   ALTER TABLE ONLY public.cartproduct DROP CONSTRAINT cart_product_fk;
       public          postgres    false    217    219    2980            �           2606    32837 !   cartproduct cart_product_stock_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.cartproduct
    ADD CONSTRAINT cart_product_stock_fk FOREIGN KEY (stock_id) REFERENCES public.stock(id);
 K   ALTER TABLE ONLY public.cartproduct DROP CONSTRAINT cart_product_stock_fk;
       public          postgres    false    213    2976    219            �           2606    32819    cart cart_user_fk    FK CONSTRAINT     q   ALTER TABLE ONLY public.cart
    ADD CONSTRAINT cart_user_fk FOREIGN KEY (user_id) REFERENCES public."User"(id);
 ;   ALTER TABLE ONLY public.cart DROP CONSTRAINT cart_user_fk;
       public          postgres    false    2958    217    201            �           2606    16598    product category_product_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.product
    ADD CONSTRAINT category_product_fk FOREIGN KEY (category_id) REFERENCES public.category(id);
 E   ALTER TABLE ONLY public.product DROP CONSTRAINT category_product_fk;
       public          postgres    false    2966    207    205            �           2606    24704    stockinproduct product_fk    FK CONSTRAINT     }   ALTER TABLE ONLY public.stockinproduct
    ADD CONSTRAINT product_fk FOREIGN KEY (product_id) REFERENCES public.product(id);
 C   ALTER TABLE ONLY public.stockinproduct DROP CONSTRAINT product_fk;
       public          postgres    false    207    2968    215            �           2606    24699    stockinproduct stock_fk    FK CONSTRAINT     w   ALTER TABLE ONLY public.stockinproduct
    ADD CONSTRAINT stock_fk FOREIGN KEY (stock_id) REFERENCES public.stock(id);
 A   ALTER TABLE ONLY public.stockinproduct DROP CONSTRAINT stock_fk;
       public          postgres    false    2976    213    215            �           2606    16649    stock stock_place_fk    FK CONSTRAINT     t   ALTER TABLE ONLY public.stock
    ADD CONSTRAINT stock_place_fk FOREIGN KEY (place_id) REFERENCES public.place(id);
 >   ALTER TABLE ONLY public.stock DROP CONSTRAINT stock_place_fk;
       public          postgres    false    2974    211    213            �           2606    32897 ,   transactionproduct transaction_in_product_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.transactionproduct
    ADD CONSTRAINT transaction_in_product_fk FOREIGN KEY (product_id) REFERENCES public.product(id);
 V   ALTER TABLE ONLY public.transactionproduct DROP CONSTRAINT transaction_in_product_fk;
       public          postgres    false    2968    223    207            �           2606    32902 )   transactionproduct transaction_product_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.transactionproduct
    ADD CONSTRAINT transaction_product_fk FOREIGN KEY (transationc_id) REFERENCES public."Transaction"(id);
 S   ALTER TABLE ONLY public.transactionproduct DROP CONSTRAINT transaction_product_fk;
       public          postgres    false    2984    223    221            �           2606    32892 /   transactionproduct transaction_product_stock_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.transactionproduct
    ADD CONSTRAINT transaction_product_stock_fk FOREIGN KEY (stock_id) REFERENCES public.stock(id);
 Y   ALTER TABLE ONLY public.transactionproduct DROP CONSTRAINT transaction_product_stock_fk;
       public          postgres    false    2976    223    213            �           2606    32874    Transaction transaction_user_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public."Transaction"
    ADD CONSTRAINT transaction_user_fk FOREIGN KEY (user_id) REFERENCES public."User"(id);
 K   ALTER TABLE ONLY public."Transaction" DROP CONSTRAINT transaction_user_fk;
       public          postgres    false    2958    221    201           