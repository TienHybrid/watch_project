PGDMP     )                    y            watch    13.1 (Debian 13.1-1.pgdg100+1)    13.2 �    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16384    watch    DATABASE     Y   CREATE DATABASE watch WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.utf8';
    DROP DATABASE watch;
                postgres    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
                postgres    false            �           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                   postgres    false    3            �            1259    32854    Transaction    TABLE     V  CREATE TABLE public."Transaction" (
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
    is_deleted boolean DEFAULT false NOT NULL,
    voucher_id integer,
    discount integer DEFAULT 0,
    shipping_fee integer DEFAULT 0,
    subtotal integer DEFAULT 0,
    total integer DEFAULT 0
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
       public          postgres    false    217    3            �           0    0    Transaction_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public."Transaction_id_seq" OWNED BY public."Transaction".id;
          public          postgres    false    216            �            1259    16542    User    TABLE     *  CREATE TABLE public."User" (
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
    place_id integer
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
       public          postgres    false    201    3            �           0    0    User_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public."User_id_seq" OWNED BY public."User".id;
          public          postgres    false    200            �            1259    49197    brand    TABLE     E  CREATE TABLE public.brand (
    id integer NOT NULL,
    name character varying(60) NOT NULL,
    image_url character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    is_deleted boolean DEFAULT false NOT NULL
);
    DROP TABLE public.brand;
       public         heap    postgres    false    3            �            1259    49195    brand_id_seq    SEQUENCE     �   CREATE SEQUENCE public.brand_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.brand_id_seq;
       public          postgres    false    3    225            �           0    0    brand_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.brand_id_seq OWNED BY public.brand.id;
          public          postgres    false    224            �            1259    40991    cart    TABLE     !  CREATE TABLE public.cart (
    id integer NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL
);
    DROP TABLE public.cart;
       public         heap    postgres    false    3            �            1259    40989    cart_id_seq    SEQUENCE     �   CREATE SEQUENCE public.cart_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE public.cart_id_seq;
       public          postgres    false    221    3            �           0    0    cart_id_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE public.cart_id_seq OWNED BY public.cart.id;
          public          postgres    false    220            �            1259    41007    cartproduct    TABLE     �  CREATE TABLE public.cartproduct (
    id integer NOT NULL,
    stock_id integer NOT NULL,
    cart_id integer NOT NULL,
    product_id integer NOT NULL,
    quantity integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL
);
    DROP TABLE public.cartproduct;
       public         heap    postgres    false    3            �            1259    41005    cartproduct_id_seq    SEQUENCE     �   CREATE SEQUENCE public.cartproduct_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.cartproduct_id_seq;
       public          postgres    false    3    223            �           0    0    cartproduct_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.cartproduct_id_seq OWNED BY public.cartproduct.id;
          public          postgres    false    222            �            1259    16570    category    TABLE     H  CREATE TABLE public.category (
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
       public          postgres    false    205    3            �           0    0    category_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.category_id_seq OWNED BY public.category.id;
          public          postgres    false    204            �            1259    65611    commentproduct    TABLE     �  CREATE TABLE public.commentproduct (
    id integer NOT NULL,
    content character varying NOT NULL,
    stock_id integer NOT NULL,
    user_id integer NOT NULL,
    product_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL
);
 "   DROP TABLE public.commentproduct;
       public         heap    postgres    false    3            �            1259    65609    commentproduct_id_seq    SEQUENCE     �   CREATE SEQUENCE public.commentproduct_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.commentproduct_id_seq;
       public          postgres    false    231    3            �           0    0    commentproduct_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.commentproduct_id_seq OWNED BY public.commentproduct.id;
          public          postgres    false    230            �            1259    65656    guaranteeinfo    TABLE     `  CREATE TABLE public.guaranteeinfo (
    id integer NOT NULL,
    transactionproduct_id integer NOT NULL,
    content character varying NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL
);
 !   DROP TABLE public.guaranteeinfo;
       public         heap    postgres    false    3            �            1259    65654    guaranteeinfo_id_seq    SEQUENCE     �   CREATE SEQUENCE public.guaranteeinfo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.guaranteeinfo_id_seq;
       public          postgres    false    3    233            �           0    0    guaranteeinfo_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.guaranteeinfo_id_seq OWNED BY public.guaranteeinfo.id;
          public          postgres    false    232            �            1259    16629    place    TABLE     \  CREATE TABLE public.place (
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
       public          postgres    false    211    3            �           0    0    place_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.place_id_seq OWNED BY public.place.id;
          public          postgres    false    210            �            1259    57429    placemaster    TABLE     b  CREATE TABLE public.placemaster (
    id integer NOT NULL,
    name character varying(60) NOT NULL,
    short_name character varying(60) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL
);
    DROP TABLE public.placemaster;
       public         heap    postgres    false    3            �            1259    57427    placemaster_id_seq    SEQUENCE     �   CREATE SEQUENCE public.placemaster_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.placemaster_id_seq;
       public          postgres    false    229    3            �           0    0    placemaster_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.placemaster_id_seq OWNED BY public.placemaster.id;
          public          postgres    false    228            �            1259    16584    product    TABLE     -  CREATE TABLE public.product (
    id integer NOT NULL,
    name character varying(60) NOT NULL,
    price integer DEFAULT 0 NOT NULL,
    category_id integer,
    image_url character varying[] DEFAULT ARRAY[]::character varying[],
    slug character varying,
    description character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    is_deleted boolean DEFAULT false NOT NULL,
    brand_id integer DEFAULT 1,
    old_price integer DEFAULT 0
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
       public          postgres    false    3    207            �           0    0    product_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.product_id_seq OWNED BY public.product.id;
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
       public          postgres    false    203    3            �           0    0    staff_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.staff_id_seq OWNED BY public.staff.id;
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
       public          postgres    false    213    3            �           0    0    stock_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.stock_id_seq OWNED BY public.stock.id;
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
       public          postgres    false    3    215            �           0    0    stockinproduct_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.stockinproduct_id_seq OWNED BY public.stockinproduct.id;
          public          postgres    false    214            �            1259    32881    transactionproduct    TABLE     �  CREATE TABLE public.transactionproduct (
    id integer NOT NULL,
    stock_id integer NOT NULL,
    transaction_id integer NOT NULL,
    product_id integer NOT NULL,
    quantity integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL,
    guarantee_time timestamp without time zone
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
       public          postgres    false    3    219            �           0    0    transactionproduct_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.transactionproduct_id_seq OWNED BY public.transactionproduct.id;
          public          postgres    false    218            �            1259    16616    voucher    TABLE     p  CREATE TABLE public.voucher (
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
       public          postgres    false    209    3            �           0    0    voucher_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.voucher_id_seq OWNED BY public.voucher.id;
          public          postgres    false    208            �            1259    49226    voucherinuser    TABLE     9  CREATE TABLE public.voucherinuser (
    id integer NOT NULL,
    user_id integer,
    voucher_id integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL
);
 !   DROP TABLE public.voucherinuser;
       public         heap    postgres    false    3            �            1259    49224    voucherinuser_id_seq    SEQUENCE     �   CREATE SEQUENCE public.voucherinuser_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.voucherinuser_id_seq;
       public          postgres    false    3    227            �           0    0    voucherinuser_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.voucherinuser_id_seq OWNED BY public.voucherinuser.id;
          public          postgres    false    226            �           2604    32857    Transaction id    DEFAULT     t   ALTER TABLE ONLY public."Transaction" ALTER COLUMN id SET DEFAULT nextval('public."Transaction_id_seq"'::regclass);
 ?   ALTER TABLE public."Transaction" ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    216    217    217            \           2604    16545    User id    DEFAULT     f   ALTER TABLE ONLY public."User" ALTER COLUMN id SET DEFAULT nextval('public."User_id_seq"'::regclass);
 8   ALTER TABLE public."User" ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    201    200    201            �           2604    49200    brand id    DEFAULT     d   ALTER TABLE ONLY public.brand ALTER COLUMN id SET DEFAULT nextval('public.brand_id_seq'::regclass);
 7   ALTER TABLE public.brand ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    225    224    225            �           2604    40994    cart id    DEFAULT     b   ALTER TABLE ONLY public.cart ALTER COLUMN id SET DEFAULT nextval('public.cart_id_seq'::regclass);
 6   ALTER TABLE public.cart ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    220    221    221            �           2604    41010    cartproduct id    DEFAULT     p   ALTER TABLE ONLY public.cartproduct ALTER COLUMN id SET DEFAULT nextval('public.cartproduct_id_seq'::regclass);
 =   ALTER TABLE public.cartproduct ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    222    223    223            d           2604    16573    category id    DEFAULT     j   ALTER TABLE ONLY public.category ALTER COLUMN id SET DEFAULT nextval('public.category_id_seq'::regclass);
 :   ALTER TABLE public.category ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    205    204    205            �           2604    65614    commentproduct id    DEFAULT     v   ALTER TABLE ONLY public.commentproduct ALTER COLUMN id SET DEFAULT nextval('public.commentproduct_id_seq'::regclass);
 @   ALTER TABLE public.commentproduct ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    230    231    231            �           2604    65659    guaranteeinfo id    DEFAULT     t   ALTER TABLE ONLY public.guaranteeinfo ALTER COLUMN id SET DEFAULT nextval('public.guaranteeinfo_id_seq'::regclass);
 ?   ALTER TABLE public.guaranteeinfo ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    233    232    233            y           2604    16632    place id    DEFAULT     d   ALTER TABLE ONLY public.place ALTER COLUMN id SET DEFAULT nextval('public.place_id_seq'::regclass);
 7   ALTER TABLE public.place ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    210    211    211            �           2604    57432    placemaster id    DEFAULT     p   ALTER TABLE ONLY public.placemaster ALTER COLUMN id SET DEFAULT nextval('public.placemaster_id_seq'::regclass);
 =   ALTER TABLE public.placemaster ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    229    228    229            h           2604    16587 
   product id    DEFAULT     h   ALTER TABLE ONLY public.product ALTER COLUMN id SET DEFAULT nextval('public.product_id_seq'::regclass);
 9   ALTER TABLE public.product ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    206    207    207            `           2604    16559    staff id    DEFAULT     d   ALTER TABLE ONLY public.staff ALTER COLUMN id SET DEFAULT nextval('public.staff_id_seq'::regclass);
 7   ALTER TABLE public.staff ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    202    203    203            }           2604    16643    stock id    DEFAULT     d   ALTER TABLE ONLY public.stock ALTER COLUMN id SET DEFAULT nextval('public.stock_id_seq'::regclass);
 7   ALTER TABLE public.stock ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    212    213    213            �           2604    24693    stockinproduct id    DEFAULT     v   ALTER TABLE ONLY public.stockinproduct ALTER COLUMN id SET DEFAULT nextval('public.stockinproduct_id_seq'::regclass);
 @   ALTER TABLE public.stockinproduct ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    214    215    215            �           2604    32884    transactionproduct id    DEFAULT     ~   ALTER TABLE ONLY public.transactionproduct ALTER COLUMN id SET DEFAULT nextval('public.transactionproduct_id_seq'::regclass);
 D   ALTER TABLE public.transactionproduct ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    219    218    219            p           2604    16619 
   voucher id    DEFAULT     h   ALTER TABLE ONLY public.voucher ALTER COLUMN id SET DEFAULT nextval('public.voucher_id_seq'::regclass);
 9   ALTER TABLE public.voucher ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    208    209    209            �           2604    49229    voucherinuser id    DEFAULT     t   ALTER TABLE ONLY public.voucherinuser ALTER COLUMN id SET DEFAULT nextval('public.voucherinuser_id_seq'::regclass);
 ?   ALTER TABLE public.voucherinuser ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    227    226    227            �          0    32854    Transaction 
   TABLE DATA                 public          postgres    false    217            z          0    16542    User 
   TABLE DATA                 public          postgres    false    201            �          0    49197    brand 
   TABLE DATA                 public          postgres    false    225            �          0    40991    cart 
   TABLE DATA                 public          postgres    false    221            �          0    41007    cartproduct 
   TABLE DATA                 public          postgres    false    223            ~          0    16570    category 
   TABLE DATA                 public          postgres    false    205            �          0    65611    commentproduct 
   TABLE DATA                 public          postgres    false    231            �          0    65656    guaranteeinfo 
   TABLE DATA                 public          postgres    false    233            �          0    16629    place 
   TABLE DATA                 public          postgres    false    211            �          0    57429    placemaster 
   TABLE DATA                 public          postgres    false    229            �          0    16584    product 
   TABLE DATA                 public          postgres    false    207            |          0    16556    staff 
   TABLE DATA                 public          postgres    false    203            �          0    16640    stock 
   TABLE DATA                 public          postgres    false    213            �          0    24690    stockinproduct 
   TABLE DATA                 public          postgres    false    215            �          0    32881    transactionproduct 
   TABLE DATA                 public          postgres    false    219            �          0    16616    voucher 
   TABLE DATA                 public          postgres    false    209            �          0    49226    voucherinuser 
   TABLE DATA                 public          postgres    false    227            �           0    0    Transaction_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public."Transaction_id_seq"', 12, true);
          public          postgres    false    216            �           0    0    User_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public."User_id_seq"', 103, true);
          public          postgres    false    200            �           0    0    brand_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.brand_id_seq', 38, true);
          public          postgres    false    224            �           0    0    cart_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('public.cart_id_seq', 5, true);
          public          postgres    false    220            �           0    0    cartproduct_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.cartproduct_id_seq', 13, true);
          public          postgres    false    222            �           0    0    category_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.category_id_seq', 36, true);
          public          postgres    false    204            �           0    0    commentproduct_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.commentproduct_id_seq', 9, true);
          public          postgres    false    230            �           0    0    guaranteeinfo_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.guaranteeinfo_id_seq', 5, true);
          public          postgres    false    232            �           0    0    place_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.place_id_seq', 3, true);
          public          postgres    false    210            �           0    0    placemaster_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.placemaster_id_seq', 64, true);
          public          postgres    false    228            �           0    0    product_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.product_id_seq', 48, true);
          public          postgres    false    206            �           0    0    staff_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.staff_id_seq', 1, true);
          public          postgres    false    202            �           0    0    stock_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.stock_id_seq', 4, true);
          public          postgres    false    212            �           0    0    stockinproduct_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.stockinproduct_id_seq', 53, true);
          public          postgres    false    214            �           0    0    transactionproduct_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.transactionproduct_id_seq', 11, true);
          public          postgres    false    218            �           0    0    voucher_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.voucher_id_seq', 8, true);
          public          postgres    false    208            �           0    0    voucherinuser_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.voucherinuser_id_seq', 11, true);
          public          postgres    false    226            �           2606    16609    User User_email_key 
   CONSTRAINT     S   ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_email_key" UNIQUE (email);
 A   ALTER TABLE ONLY public."User" DROP CONSTRAINT "User_email_key";
       public            postgres    false    201            �           2606    16611    User User_username_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_username_key" UNIQUE (username);
 D   ALTER TABLE ONLY public."User" DROP CONSTRAINT "User_username_key";
       public            postgres    false    201            �           2606    49208    brand brand_pk 
   CONSTRAINT     L   ALTER TABLE ONLY public.brand
    ADD CONSTRAINT brand_pk PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.brand DROP CONSTRAINT brand_pk;
       public            postgres    false    225            �           2606    40999    cart cart_pk 
   CONSTRAINT     J   ALTER TABLE ONLY public.cart
    ADD CONSTRAINT cart_pk PRIMARY KEY (id);
 6   ALTER TABLE ONLY public.cart DROP CONSTRAINT cart_pk;
       public            postgres    false    221            �           2606    41016    cartproduct cart_product_pk 
   CONSTRAINT     Y   ALTER TABLE ONLY public.cartproduct
    ADD CONSTRAINT cart_product_pk PRIMARY KEY (id);
 E   ALTER TABLE ONLY public.cartproduct DROP CONSTRAINT cart_product_pk;
       public            postgres    false    223            �           2606    16581    category category_pk 
   CONSTRAINT     R   ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pk PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.category DROP CONSTRAINT category_pk;
       public            postgres    false    205            �           2606    65622 !   commentproduct comment_product_pk 
   CONSTRAINT     _   ALTER TABLE ONLY public.commentproduct
    ADD CONSTRAINT comment_product_pk PRIMARY KEY (id);
 K   ALTER TABLE ONLY public.commentproduct DROP CONSTRAINT comment_product_pk;
       public            postgres    false    231            �           2606    65667    guaranteeinfo guarantee_pk 
   CONSTRAINT     X   ALTER TABLE ONLY public.guaranteeinfo
    ADD CONSTRAINT guarantee_pk PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.guaranteeinfo DROP CONSTRAINT guarantee_pk;
       public            postgres    false    233            �           2606    57437    placemaster place_master_pk 
   CONSTRAINT     Y   ALTER TABLE ONLY public.placemaster
    ADD CONSTRAINT place_master_pk PRIMARY KEY (id);
 E   ALTER TABLE ONLY public.placemaster DROP CONSTRAINT place_master_pk;
       public            postgres    false    229            �           2606    16637    place place_pk 
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
       public            postgres    false    217            �           2606    32891 )   transactionproduct transaction_product_pk 
   CONSTRAINT     g   ALTER TABLE ONLY public.transactionproduct
    ADD CONSTRAINT transaction_product_pk PRIMARY KEY (id);
 S   ALTER TABLE ONLY public.transactionproduct DROP CONSTRAINT transaction_product_pk;
       public            postgres    false    219            �           2606    16553    User user_pk 
   CONSTRAINT     L   ALTER TABLE ONLY public."User"
    ADD CONSTRAINT user_pk PRIMARY KEY (id);
 8   ALTER TABLE ONLY public."User" DROP CONSTRAINT user_pk;
       public            postgres    false    201            �           2606    49234     voucherinuser voucher_in_user_pk 
   CONSTRAINT     ^   ALTER TABLE ONLY public.voucherinuser
    ADD CONSTRAINT voucher_in_user_pk PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.voucherinuser DROP CONSTRAINT voucher_in_user_pk;
       public            postgres    false    227            �           2606    16626    voucher voucher_pk 
   CONSTRAINT     P   ALTER TABLE ONLY public.voucher
    ADD CONSTRAINT voucher_pk PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.voucher DROP CONSTRAINT voucher_pk;
       public            postgres    false    209            �           2606    41022    cartproduct cart_in_product_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.cartproduct
    ADD CONSTRAINT cart_in_product_fk FOREIGN KEY (product_id) REFERENCES public.product(id);
 H   ALTER TABLE ONLY public.cartproduct DROP CONSTRAINT cart_in_product_fk;
       public          postgres    false    223    3013    207            �           2606    41027    cartproduct cart_product_fk    FK CONSTRAINT     y   ALTER TABLE ONLY public.cartproduct
    ADD CONSTRAINT cart_product_fk FOREIGN KEY (cart_id) REFERENCES public.cart(id);
 E   ALTER TABLE ONLY public.cartproduct DROP CONSTRAINT cart_product_fk;
       public          postgres    false    223    3029    221            �           2606    41017 !   cartproduct cart_product_stock_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.cartproduct
    ADD CONSTRAINT cart_product_stock_fk FOREIGN KEY (stock_id) REFERENCES public.stock(id);
 K   ALTER TABLE ONLY public.cartproduct DROP CONSTRAINT cart_product_stock_fk;
       public          postgres    false    223    3021    213            �           2606    41000    cart cart_user_fk    FK CONSTRAINT     q   ALTER TABLE ONLY public.cart
    ADD CONSTRAINT cart_user_fk FOREIGN KEY (user_id) REFERENCES public."User"(id);
 ;   ALTER TABLE ONLY public.cart DROP CONSTRAINT cart_user_fk;
       public          postgres    false    221    3003    201            �           2606    16598    product category_product_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.product
    ADD CONSTRAINT category_product_fk FOREIGN KEY (category_id) REFERENCES public.category(id);
 E   ALTER TABLE ONLY public.product DROP CONSTRAINT category_product_fk;
       public          postgres    false    3011    205    207            �           2606    49219    product fk_branch_product    FK CONSTRAINT     y   ALTER TABLE ONLY public.product
    ADD CONSTRAINT fk_branch_product FOREIGN KEY (brand_id) REFERENCES public.brand(id);
 C   ALTER TABLE ONLY public.product DROP CONSTRAINT fk_branch_product;
       public          postgres    false    3033    225    207            �           2606    57448 "   Transaction fk_transaction_voucher    FK CONSTRAINT     �   ALTER TABLE ONLY public."Transaction"
    ADD CONSTRAINT fk_transaction_voucher FOREIGN KEY (voucher_id) REFERENCES public.voucher(id);
 N   ALTER TABLE ONLY public."Transaction" DROP CONSTRAINT fk_transaction_voucher;
       public          postgres    false    209    217    3017            �           2606    57438    User fk_user_place    FK CONSTRAINT     z   ALTER TABLE ONLY public."User"
    ADD CONSTRAINT fk_user_place FOREIGN KEY (place_id) REFERENCES public.placemaster(id);
 >   ALTER TABLE ONLY public."User" DROP CONSTRAINT fk_user_place;
       public          postgres    false    229    201    3037            �           2606    65668 .   guaranteeinfo guarantee_transaction_product_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.guaranteeinfo
    ADD CONSTRAINT guarantee_transaction_product_fk FOREIGN KEY (transactionproduct_id) REFERENCES public.transactionproduct(id);
 X   ALTER TABLE ONLY public.guaranteeinfo DROP CONSTRAINT guarantee_transaction_product_fk;
       public          postgres    false    233    219    3027            �           2606    65633 )   commentproduct product_comment_product_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.commentproduct
    ADD CONSTRAINT product_comment_product_fk FOREIGN KEY (product_id) REFERENCES public.product(id);
 S   ALTER TABLE ONLY public.commentproduct DROP CONSTRAINT product_comment_product_fk;
       public          postgres    false    231    207    3013            �           2606    24704    stockinproduct product_fk    FK CONSTRAINT     }   ALTER TABLE ONLY public.stockinproduct
    ADD CONSTRAINT product_fk FOREIGN KEY (product_id) REFERENCES public.product(id);
 C   ALTER TABLE ONLY public.stockinproduct DROP CONSTRAINT product_fk;
       public          postgres    false    207    215    3013            �           2606    65623 '   commentproduct stock_comment_product_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.commentproduct
    ADD CONSTRAINT stock_comment_product_fk FOREIGN KEY (stock_id) REFERENCES public.stock(id);
 Q   ALTER TABLE ONLY public.commentproduct DROP CONSTRAINT stock_comment_product_fk;
       public          postgres    false    231    3021    213            �           2606    24699    stockinproduct stock_fk    FK CONSTRAINT     w   ALTER TABLE ONLY public.stockinproduct
    ADD CONSTRAINT stock_fk FOREIGN KEY (stock_id) REFERENCES public.stock(id);
 A   ALTER TABLE ONLY public.stockinproduct DROP CONSTRAINT stock_fk;
       public          postgres    false    213    215    3021            �           2606    16649    stock stock_place_fk    FK CONSTRAINT     t   ALTER TABLE ONLY public.stock
    ADD CONSTRAINT stock_place_fk FOREIGN KEY (place_id) REFERENCES public.place(id);
 >   ALTER TABLE ONLY public.stock DROP CONSTRAINT stock_place_fk;
       public          postgres    false    211    3019    213            �           2606    32897 ,   transactionproduct transaction_in_product_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.transactionproduct
    ADD CONSTRAINT transaction_in_product_fk FOREIGN KEY (product_id) REFERENCES public.product(id);
 V   ALTER TABLE ONLY public.transactionproduct DROP CONSTRAINT transaction_in_product_fk;
       public          postgres    false    219    207    3013            �           2606    32902 )   transactionproduct transaction_product_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.transactionproduct
    ADD CONSTRAINT transaction_product_fk FOREIGN KEY (transaction_id) REFERENCES public."Transaction"(id);
 S   ALTER TABLE ONLY public.transactionproduct DROP CONSTRAINT transaction_product_fk;
       public          postgres    false    3025    217    219            �           2606    32892 /   transactionproduct transaction_product_stock_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.transactionproduct
    ADD CONSTRAINT transaction_product_stock_fk FOREIGN KEY (stock_id) REFERENCES public.stock(id);
 Y   ALTER TABLE ONLY public.transactionproduct DROP CONSTRAINT transaction_product_stock_fk;
       public          postgres    false    3021    213    219            �           2606    32874    Transaction transaction_user_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public."Transaction"
    ADD CONSTRAINT transaction_user_fk FOREIGN KEY (user_id) REFERENCES public."User"(id);
 K   ALTER TABLE ONLY public."Transaction" DROP CONSTRAINT transaction_user_fk;
       public          postgres    false    201    217    3003            �           2606    65628 &   commentproduct user_comment_product_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.commentproduct
    ADD CONSTRAINT user_comment_product_fk FOREIGN KEY (user_id) REFERENCES public."User"(id);
 P   ALTER TABLE ONLY public.commentproduct DROP CONSTRAINT user_comment_product_fk;
       public          postgres    false    231    3003    201            �           2606    49235    voucherinuser user_fk    FK CONSTRAINT     u   ALTER TABLE ONLY public.voucherinuser
    ADD CONSTRAINT user_fk FOREIGN KEY (user_id) REFERENCES public."User"(id);
 ?   ALTER TABLE ONLY public.voucherinuser DROP CONSTRAINT user_fk;
       public          postgres    false    201    3003    227            �           2606    49240    voucherinuser voucher_fk    FK CONSTRAINT     |   ALTER TABLE ONLY public.voucherinuser
    ADD CONSTRAINT voucher_fk FOREIGN KEY (voucher_id) REFERENCES public.voucher(id);
 B   ALTER TABLE ONLY public.voucherinuser DROP CONSTRAINT voucher_fk;
       public          postgres    false    209    227    3017            �   V  x���Mk1�����e[�03�|lzi�P���ز�G���߬ne�M�[lH�$oyx'3��FOs1������:_���#��e��}��0Y�f��DR䫭(�Zܿm�|-��M���t��Z����H��=�, ��%�5[�W��P�IAha"8��2�����Љ��\��tV1�(W]������pW�|�:]���'��a�B�ըY',��t�2W��� xP^��Z��9�R�Xd��"Ԋ�f!��V��/d� c��#K�ƀK.��d���隃�
fa�,�l<;�p)7�j�͏�,�T�AW0�Iv�C�'���l��P#%�FU����`�      z   +  x�Ŕmk�0���S���Gw�ɒ��C�F����@߅�%�.Ilbw�}�ɡ��}Qv����whzzv��<�����[���|������㷋��5<����t0L���5��.��0_r�ȫf9�u׌�Gq������r$�u��i4#
��9���>AQ����p��Ǥ��΄�6�u߷]9��zw)�f��ϛf���ݐ�䧘�Iŋ����ȹm���7z3l���>�)�Y�9��R��M;ϋ��2���+Q ����@��K���d��T#/�p����{ӝ���#�[I�V�M}����hFJ^�d4H6
���V�E(�M��[�&Jށ�̚(�zl@㿱���/�]�jPR<��2P%A�*�)p��,� d:·e[��V�ӯG�'Sߍ�
�*����3XA��hdP�s(uّ�h�Dv�kt>�>^���
B����Bf���m�&7;������?Xleb>��/W42R�N�q
UT
e�E��a`�|��9P�R�Uƚ�򈂭����4=�R�͓O�*� ǂ�4;����� ���      �   �  x�ŕ�N�0��}
oFe$���A�B)岴��M3J�����7��"�6��7�/}֧s|<���o��dvw�&-�����a<�?����o�Ҿ��~:[�!6��`�p
�J�aWꛍ�{4�t݊�j�}�r�m_��.��W޻6��e��Դ��ucr��Kk\�¬^G�(J�̔�Z�f�.�1�ƹ���#���r������b���Ĕ�xm����>]����-	��¬�*���I�$�JfsB9�2�ߘҥɞ6�S�6Uۧ5�1�)���.����q"՞z��ع҂G�U��L#����b7����^[Vh��B�+I>B ���$�P�:ӟKʀ����*)��⛱48�2�(�1�L?����e��Y      �   �   x���=�P���O�l��y�}QoS��Y�&�C���ӡ��p�?�_U7�nOU����uꯝ������͡lh!	����M���=
oD� [�C�����rU		i39��q�Ru.50��}��2�F�8T�Zv���ͦ�I���UΎ�,ՏEo(�c�      �   ;  x����j�0�{�·n�ɒ"�;��Cat�v�����J־��lq��B.?�,���r��2����쏛���n��a_���r��<[���׾�g���x�q	#�EO:����w_o�w���d>�$hQ�Ap�4�����am�@5�*d�4=���;gj��\m&�>8����e�?���i���"{�Uړ/�e�v=��ɠ��*:��ħ;�K���i[H�q�`�8_K�d���,-Q�r�TI�N�B�K��5�Zr�8�yZHw��~@����E����I>,�����nkKsS�Rb>��=}�A[      ~   �  x����J�0���"��K�i*"C&Ήnz-i�u�n-m'��gO>�<xڎ���7��N���SB�!?>|Io0�܎@o0���z*�~�<��v��3��4�������b5kg�,�S�0&A�]��4��k�G�j)������T��c�����DP�qG�_盉�b�3�v6-��C쟩0;��q�~�Dp�� �H��$-*+M'*L��I�W�Lv��zY3�8�Qa�24%6�1a	Y���E�z�|��j�SG`.�Uj�6�PH)pY���m�G�Ϗb̧5˙�9�U�S
�@���^���k��a�WwǦ�X�G�-D6c6�cD�(M�dQU�wZNtF����u�׬玅� Uz.�/�XRQ�n����zΜ      �     x�œ�J�@@����E�]fwv����C�b�w��ք&��h &M� �� ��7�nw���mvU���E^�GS��6o�i}�����ZB�u�T��}:�L��+�(tl'B�ц�K��y_�7���2�ˬ��yr�2���6kLh�F�)�9F�$�f�
�h� ��З�����UP�u�R�X�'�i����a���"��1&4ܡ������ͅ`ОX���9�ar�v��&v�P��@��i@�!
˱�����,���0      �   �   x����j�PF�y���B�ܙd���?BV��}*�l,m-�]v��[�2�{�Mj�.j�k�s��L���C���.���D̖�[�~�q�N0����"|�b���g���%�I�#I¦�tQ��	�CJ�4����-+���9z���
�p����0���5JA��4��X�8����+��3��H_�g���+0��=#�-����DJKUF𑽓G���-�jQƩ����r$���iX�/��g      �   �   x���v
Q���W((M��L�+�ILNUs�	uV�0�QP�8�@���� ���2202�50�52V04�26�20�3�41�0#(���S��i��I�nc�uwOVp�8�V�73/�g,VZ��Z[�%�F@��L �~�ּt��.X�ohe`�giafjbBPf; �^aO      �   N  x�ř�O�@���W�F+��?�qB�$ @	.7R�ʍ��*8(�cաCU	����P��B������O�ޅ��(R��B�,��{��}޻������}"���A����u�{����@��ͧ�-�P/���d(�4�,�?U�З4kI3��-K}Y�EݰmӸ��Ko������ƿ90`�ɑ�0��p��[=˚]4+�,�w~��'��Ǣ�'�b3}
�~��!��nV��vO�������pX�1��[苕��t4[	Z2���Q:>�-X��-z�Ɵ:�J0\bӋ��m�����=PV8�<x%����A�'��CS�4~�Z�|��C�!>{��zF΀�'�}zHĵ�M��˛�8��5��=z�ҍ�;9c�������i�V	����yĵ����PŐ\�D�O/ ��q��D�5 ;�`� ��~�`"��P�=L�_39�7%�ށ�� )-�G��B�l�a_�
��l�a�U��#�������?��sz>���?<�2�_"���d�_��7���:�J$�6h�B0-������R�@/9�����8�ed9�� ��- [�U�'oJ��4�G1zqd���򬿅(�p����8�萣����f��aXJ?��zPTS�yMo��i���X`!���,ـ4t�.�K �m��؝�뗴L$�������}E.e�!zx@��8����p2��#z}u1�n� 
�;Ts���f_�g�b� O,���3l���z)��<o��KQ���e������xK��t����#�Pg�o����L��p�U�K���;a69�� 4BO�      �   �  x��KO�V��|����J\���

e@!m���ԍ�8&	r$N�ZU�hV�U����|�VjW̒Ѭ�|���$`g��J�d�>vΏ���c��G�����ꓯPoXKZ���w��(E�nU������D�7�^����@M8��V��v�h�*N���ÏK��r�}l"��c3M{�\>n��Z8�i�6b���6�8�^�m��'�Z9
��S��v|���z�^7Ż������a+	�	��J3���<L���q�n�5����2�%�r�2#�V;��'(l���M\��g{T�V�!Z}Z���0�(&�����	��%ʖ�<�A<���@�|����v!���o���SI�L��4Liw��Rk�2�����Ȉ��,EeV�3\+�R��z��L���wX�emY,��ߪ{�����d����V�T0�TI��� ��̍j
�S*I��NTRb�ˌRK�ˌL��*��<	��a<�I�;|�L��~h��T`�e��>���ZVz_t�)�DrL�M�<_'���s���YJ׬�4 V2�R�9;����q�����z1�����A�I%�\j�C�|t�P������N���N?Ӂ��@Q�o����0&�u���=�.=B�RQ��s���U����̃?-�M���{_���K��v ��Tu�N�`�WF�s6Ȩ@7���2
�a�q�1�n�r�k�p��EQ7)�ϴ��0��MވNp��qdI��4�+f��ʝ���߀&��	-%ġ��@3j�C�0�Q��28*��>h�2��I�\�J��/�L!2�gS]\�T�-(�g`(ˬ�2R��TK�1)@� �d�Q2 ����!��Cf�1y���;:$e��vk�M�q�o��z��t:�:����?#]��:ͫ�ztȤB��.��$D�W3�B�fRaȥ�q�U���DK���D���@F��"��D�N���!N"�N3��6p�a�q�P5�/�'�5D��|t:���ق�8 �@Ύ�$�}9z�t^���7/.�G��Ć������u��1&�Arݕ�LF�ˌVPjܙ=d�e���Ì�N|��B��/���������13�ϳ�����������XL��[�%�~x��a=ca��1��R�M�[�^�ga5�Q�oŃ�p��k�C(��v����j�]�����H�4��I��ì��,+8�
�`uh|�j"�:G�
���|
�iM?P��PX<�ߍB��*�B>�����Oaq�x7
�5���W�      |     x���AK1���9T�`7�Iv���z�P[{-��d���.�ԃ�ަ����2��`���u�|߰���'۵U"y϶O/�5��l]��t[wdq�㯉���eUHQ������r��)	,�YF:�����Z#H� ZҕU����*��<�\�ʽ��'�U�@�Ty�K��>�!,8���,�3N?R㲦���І�ǿ�[^Q�5�s�}C�>��e�>�.R���ΔRj�>�恺xpuK$@15G�.�,d�����S���d2��j�      �   �   x���A�P��}O1����f�{I[+��Pb[ڠ��X�$��&����'l��̗q�a{����}�d�U��>�0nvG�!Td�N����C��¬�S�u.�$ ɑ�(��d���΃�nVm�/]z'^��x^�|Y��l��ҥ��f�T����F��o2	�W�������X�~$L��9�f~ u"㖴$i�r����]�~t      �   �  x���MK$1���+rfB}%���<xX\P׻;�������t1=V�H���Poުޝ���]����ww����z����7���~=����'������q��& ܂l)8�AR93QH���?W����|]�>��)��m�<@�4�`��j+=,�Q=jR�ުt*�r9��y�T�g �������߅=3P�ު��O�O����W�h&�U;�iO���s�)i��Io�z��q�L8f�	0e��F�xt���&.l��p ���S;��1�H&��S�٤�j���{�.�K���}A���J/��E�)�E�_Ԏ�i�\�95������{�vt^'}�?4��4e�b�`�ު������r�T�GMd�z�~���ˇ��֧�a��U�>W;�u��c7.���a ��L��\�����X��=
ED�ުt���:��ثf���W�t�HD      �     x���_k�0�w?E����{�\�gO{� �v��mP(mi��_�m��RF��p��f�|]��Y���u��u�?��K�����t>�_���=כ�=��a�ʂI��\���Cp Yn�JK�����_>
�l���)���_�pn5)���t��)�.
�'Mq��4Z�Q��0c���҉ҁ�MJ
Q��c;�4��vH���Y��42�?����p��V$H���$	N��d�"��`�Q&�i�D��f~���C��b��F�c�$�K��e��d      �   �  x���Mj�@�O�6�-Xb>�Օ�8�H��%��׸�����z�n]u�����t��i���@b�͏�
�d0J!������|j~]�l��O��� �����۪����a�YAo�rm2���z���	"�@� �v��2FE�姷1��qn"ek�_&��YO�7�B>uO�h(��/�{�	� &w��f3H��
�����CU��l�<��U��8�ĖRs� 3[vM�[&����3�l4�$?�$R��<۬�5���{
'5��	)H�h��x���3����'�};�~ N��8	iKٹ&9����v-Y�� ��W�B�Rv<��j3�R�t4�alI�/�*�7 *ʑƨ��)�����ad2�bB��C��� �%Ē{��=DU�#o��m���n`ܤ�&��V��|�aK��U���*�:Bd���q=�ܶ�ڪrT�j�g�ZB�M�����Z��������psj9����^Zb�~���	��t:J�-      �   �   x���MK1���+�v��$�d��CR�V�ZV,�m���-iݭ������I=���gPOfW���/s�y��M�x�VM��7�)��� ) gd*QJ$@$AHk���3�p�\5����W���̻n�$��Z�vؔ�|������c��v��EA�V�؁��45�N�͠��@!�N�a�S�rOJ�fS�{J�q�L����U�^����h�������ݬ����Qy�Dǳ��CQ�~G�e[�?�      �    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16384    watch    DATABASE     Y   CREATE DATABASE watch WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.utf8';
    DROP DATABASE watch;
                postgres    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
                postgres    false            �           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                   postgres    false    3            �            1259    32854    Transaction    TABLE     V  CREATE TABLE public."Transaction" (
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
    is_deleted boolean DEFAULT false NOT NULL,
    voucher_id integer,
    discount integer DEFAULT 0,
    shipping_fee integer DEFAULT 0,
    subtotal integer DEFAULT 0,
    total integer DEFAULT 0
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
       public          postgres    false    217    3            �           0    0    Transaction_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public."Transaction_id_seq" OWNED BY public."Transaction".id;
          public          postgres    false    216            �            1259    16542    User    TABLE     *  CREATE TABLE public."User" (
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
    place_id integer
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
       public          postgres    false    201    3            �           0    0    User_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public."User_id_seq" OWNED BY public."User".id;
          public          postgres    false    200            �            1259    49197    brand    TABLE     E  CREATE TABLE public.brand (
    id integer NOT NULL,
    name character varying(60) NOT NULL,
    image_url character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    is_deleted boolean DEFAULT false NOT NULL
);
    DROP TABLE public.brand;
       public         heap    postgres    false    3            �            1259    49195    brand_id_seq    SEQUENCE     �   CREATE SEQUENCE public.brand_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.brand_id_seq;
       public          postgres    false    3    225            �           0    0    brand_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.brand_id_seq OWNED BY public.brand.id;
          public          postgres    false    224            �            1259    40991    cart    TABLE     !  CREATE TABLE public.cart (
    id integer NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL
);
    DROP TABLE public.cart;
       public         heap    postgres    false    3            �            1259    40989    cart_id_seq    SEQUENCE     �   CREATE SEQUENCE public.cart_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE public.cart_id_seq;
       public          postgres    false    221    3            �           0    0    cart_id_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE public.cart_id_seq OWNED BY public.cart.id;
          public          postgres    false    220            �            1259    41007    cartproduct    TABLE     �  CREATE TABLE public.cartproduct (
    id integer NOT NULL,
    stock_id integer NOT NULL,
    cart_id integer NOT NULL,
    product_id integer NOT NULL,
    quantity integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL
);
    DROP TABLE public.cartproduct;
       public         heap    postgres    false    3            �            1259    41005    cartproduct_id_seq    SEQUENCE     �   CREATE SEQUENCE public.cartproduct_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.cartproduct_id_seq;
       public          postgres    false    3    223            �           0    0    cartproduct_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.cartproduct_id_seq OWNED BY public.cartproduct.id;
          public          postgres    false    222            �            1259    16570    category    TABLE     H  CREATE TABLE public.category (
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
       public          postgres    false    205    3            �           0    0    category_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.category_id_seq OWNED BY public.category.id;
          public          postgres    false    204            �            1259    65611    commentproduct    TABLE     �  CREATE TABLE public.commentproduct (
    id integer NOT NULL,
    content character varying NOT NULL,
    stock_id integer NOT NULL,
    user_id integer NOT NULL,
    product_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL
);
 "   DROP TABLE public.commentproduct;
       public         heap    postgres    false    3            �            1259    65609    commentproduct_id_seq    SEQUENCE     �   CREATE SEQUENCE public.commentproduct_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.commentproduct_id_seq;
       public          postgres    false    231    3            �           0    0    commentproduct_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.commentproduct_id_seq OWNED BY public.commentproduct.id;
          public          postgres    false    230            �            1259    65656    guaranteeinfo    TABLE     `  CREATE TABLE public.guaranteeinfo (
    id integer NOT NULL,
    transactionproduct_id integer NOT NULL,
    content character varying NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL
);
 !   DROP TABLE public.guaranteeinfo;
       public         heap    postgres    false    3            �            1259    65654    guaranteeinfo_id_seq    SEQUENCE     �   CREATE SEQUENCE public.guaranteeinfo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.guaranteeinfo_id_seq;
       public          postgres    false    3    233            �           0    0    guaranteeinfo_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.guaranteeinfo_id_seq OWNED BY public.guaranteeinfo.id;
          public          postgres    false    232            �            1259    16629    place    TABLE     \  CREATE TABLE public.place (
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
       public          postgres    false    211    3            �           0    0    place_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.place_id_seq OWNED BY public.place.id;
          public          postgres    false    210            �            1259    57429    placemaster    TABLE     b  CREATE TABLE public.placemaster (
    id integer NOT NULL,
    name character varying(60) NOT NULL,
    short_name character varying(60) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL
);
    DROP TABLE public.placemaster;
       public         heap    postgres    false    3            �            1259    57427    placemaster_id_seq    SEQUENCE     �   CREATE SEQUENCE public.placemaster_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.placemaster_id_seq;
       public          postgres    false    229    3            �           0    0    placemaster_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.placemaster_id_seq OWNED BY public.placemaster.id;
          public          postgres    false    228            �            1259    16584    product    TABLE     -  CREATE TABLE public.product (
    id integer NOT NULL,
    name character varying(60) NOT NULL,
    price integer DEFAULT 0 NOT NULL,
    category_id integer,
    image_url character varying[] DEFAULT ARRAY[]::character varying[],
    slug character varying,
    description character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    is_deleted boolean DEFAULT false NOT NULL,
    brand_id integer DEFAULT 1,
    old_price integer DEFAULT 0
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
       public          postgres    false    3    207            �           0    0    product_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.product_id_seq OWNED BY public.product.id;
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
       public          postgres    false    203    3            �           0    0    staff_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.staff_id_seq OWNED BY public.staff.id;
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
       public          postgres    false    213    3            �           0    0    stock_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.stock_id_seq OWNED BY public.stock.id;
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
       public          postgres    false    3    215            �           0    0    stockinproduct_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.stockinproduct_id_seq OWNED BY public.stockinproduct.id;
          public          postgres    false    214            �            1259    32881    transactionproduct    TABLE     �  CREATE TABLE public.transactionproduct (
    id integer NOT NULL,
    stock_id integer NOT NULL,
    transaction_id integer NOT NULL,
    product_id integer NOT NULL,
    quantity integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL,
    guarantee_time timestamp without time zone
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
       public          postgres    false    3    219            �           0    0    transactionproduct_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.transactionproduct_id_seq OWNED BY public.transactionproduct.id;
          public          postgres    false    218            �            1259    16616    voucher    TABLE     p  CREATE TABLE public.voucher (
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
       public          postgres    false    209    3            �           0    0    voucher_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.voucher_id_seq OWNED BY public.voucher.id;
          public          postgres    false    208            �            1259    49226    voucherinuser    TABLE     9  CREATE TABLE public.voucherinuser (
    id integer NOT NULL,
    user_id integer,
    voucher_id integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL
);
 !   DROP TABLE public.voucherinuser;
       public         heap    postgres    false    3            �            1259    49224    voucherinuser_id_seq    SEQUENCE     �   CREATE SEQUENCE public.voucherinuser_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.voucherinuser_id_seq;
       public          postgres    false    3    227            �           0    0    voucherinuser_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.voucherinuser_id_seq OWNED BY public.voucherinuser.id;
          public          postgres    false    226            �           2604    32857    Transaction id    DEFAULT     t   ALTER TABLE ONLY public."Transaction" ALTER COLUMN id SET DEFAULT nextval('public."Transaction_id_seq"'::regclass);
 ?   ALTER TABLE public."Transaction" ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    216    217    217            \           2604    16545    User id    DEFAULT     f   ALTER TABLE ONLY public."User" ALTER COLUMN id SET DEFAULT nextval('public."User_id_seq"'::regclass);
 8   ALTER TABLE public."User" ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    201    200    201            �           2604    49200    brand id    DEFAULT     d   ALTER TABLE ONLY public.brand ALTER COLUMN id SET DEFAULT nextval('public.brand_id_seq'::regclass);
 7   ALTER TABLE public.brand ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    225    224    225            �           2604    40994    cart id    DEFAULT     b   ALTER TABLE ONLY public.cart ALTER COLUMN id SET DEFAULT nextval('public.cart_id_seq'::regclass);
 6   ALTER TABLE public.cart ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    220    221    221            �           2604    41010    cartproduct id    DEFAULT     p   ALTER TABLE ONLY public.cartproduct ALTER COLUMN id SET DEFAULT nextval('public.cartproduct_id_seq'::regclass);
 =   ALTER TABLE public.cartproduct ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    222    223    223            d           2604    16573    category id    DEFAULT     j   ALTER TABLE ONLY public.category ALTER COLUMN id SET DEFAULT nextval('public.category_id_seq'::regclass);
 :   ALTER TABLE public.category ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    205    204    205            �           2604    65614    commentproduct id    DEFAULT     v   ALTER TABLE ONLY public.commentproduct ALTER COLUMN id SET DEFAULT nextval('public.commentproduct_id_seq'::regclass);
 @   ALTER TABLE public.commentproduct ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    230    231    231            �           2604    65659    guaranteeinfo id    DEFAULT     t   ALTER TABLE ONLY public.guaranteeinfo ALTER COLUMN id SET DEFAULT nextval('public.guaranteeinfo_id_seq'::regclass);
 ?   ALTER TABLE public.guaranteeinfo ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    233    232    233            y           2604    16632    place id    DEFAULT     d   ALTER TABLE ONLY public.place ALTER COLUMN id SET DEFAULT nextval('public.place_id_seq'::regclass);
 7   ALTER TABLE public.place ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    210    211    211            �           2604    57432    placemaster id    DEFAULT     p   ALTER TABLE ONLY public.placemaster ALTER COLUMN id SET DEFAULT nextval('public.placemaster_id_seq'::regclass);
 =   ALTER TABLE public.placemaster ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    229    228    229            h           2604    16587 
   product id    DEFAULT     h   ALTER TABLE ONLY public.product ALTER COLUMN id SET DEFAULT nextval('public.product_id_seq'::regclass);
 9   ALTER TABLE public.product ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    206    207    207            `           2604    16559    staff id    DEFAULT     d   ALTER TABLE ONLY public.staff ALTER COLUMN id SET DEFAULT nextval('public.staff_id_seq'::regclass);
 7   ALTER TABLE public.staff ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    202    203    203            }           2604    16643    stock id    DEFAULT     d   ALTER TABLE ONLY public.stock ALTER COLUMN id SET DEFAULT nextval('public.stock_id_seq'::regclass);
 7   ALTER TABLE public.stock ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    212    213    213            �           2604    24693    stockinproduct id    DEFAULT     v   ALTER TABLE ONLY public.stockinproduct ALTER COLUMN id SET DEFAULT nextval('public.stockinproduct_id_seq'::regclass);
 @   ALTER TABLE public.stockinproduct ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    214    215    215            �           2604    32884    transactionproduct id    DEFAULT     ~   ALTER TABLE ONLY public.transactionproduct ALTER COLUMN id SET DEFAULT nextval('public.transactionproduct_id_seq'::regclass);
 D   ALTER TABLE public.transactionproduct ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    219    218    219            p           2604    16619 
   voucher id    DEFAULT     h   ALTER TABLE ONLY public.voucher ALTER COLUMN id SET DEFAULT nextval('public.voucher_id_seq'::regclass);
 9   ALTER TABLE public.voucher ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    208    209    209            �           2604    49229    voucherinuser id    DEFAULT     t   ALTER TABLE ONLY public.voucherinuser ALTER COLUMN id SET DEFAULT nextval('public.voucherinuser_id_seq'::regclass);
 ?   ALTER TABLE public.voucherinuser ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    227    226    227            �          0    32854    Transaction 
   TABLE DATA                 public          postgres    false    217   �       z          0    16542    User 
   TABLE DATA                 public          postgres    false    201   
       �          0    49197    brand 
   TABLE DATA                 public          postgres    false    225   R       �          0    40991    cart 
   TABLE DATA                 public          postgres    false    221   �       �          0    41007    cartproduct 
   TABLE DATA                 public          postgres    false    223   �       ~          0    16570    category 
   TABLE DATA                 public          postgres    false    205   �       �          0    65611    commentproduct 
   TABLE DATA                 public          postgres    false    231   y       �          0    65656    guaranteeinfo 
   TABLE DATA                 public          postgres    false    233   �       �          0    16629    place 
   TABLE DATA                 public          postgres    false    211   �       �          0    57429    placemaster 
   TABLE DATA                 public          postgres    false    229   b       �          0    16584    product 
   TABLE DATA                 public          postgres    false    207   �       |          0    16556    staff 
   TABLE DATA                 public          postgres    false    203   �       �          0    16640    stock 
   TABLE DATA                 public          postgres    false    213   �       �          0    24690    stockinproduct 
   TABLE DATA                 public          postgres    false    215   �       �          0    32881    transactionproduct 
   TABLE DATA                 public          postgres    false    219   �        �          0    16616    voucher 
   TABLE DATA                 public          postgres    false    209   �       �          0    49226    voucherinuser 
   TABLE DATA                 public          postgres    false    227   �       �           0    0    Transaction_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public."Transaction_id_seq"', 12, true);
          public          postgres    false    216            �           0    0    User_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public."User_id_seq"', 103, true);
          public          postgres    false    200            �           0    0    brand_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.brand_id_seq', 38, true);
          public          postgres    false    224            �           0    0    cart_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('public.cart_id_seq', 5, true);
          public          postgres    false    220            �           0    0    cartproduct_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.cartproduct_id_seq', 13, true);
          public          postgres    false    222            �           0    0    category_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.category_id_seq', 36, true);
          public          postgres    false    204            �           0    0    commentproduct_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.commentproduct_id_seq', 9, true);
          public          postgres    false    230            �           0    0    guaranteeinfo_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.guaranteeinfo_id_seq', 5, true);
          public          postgres    false    232            �           0    0    place_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.place_id_seq', 3, true);
          public          postgres    false    210            �           0    0    placemaster_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.placemaster_id_seq', 64, true);
          public          postgres    false    228            �           0    0    product_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.product_id_seq', 48, true);
          public          postgres    false    206            �           0    0    staff_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.staff_id_seq', 1, true);
          public          postgres    false    202            �           0    0    stock_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.stock_id_seq', 4, true);
          public          postgres    false    212            �           0    0    stockinproduct_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.stockinproduct_id_seq', 53, true);
          public          postgres    false    214            �           0    0    transactionproduct_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.transactionproduct_id_seq', 11, true);
          public          postgres    false    218            �           0    0    voucher_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.voucher_id_seq', 8, true);
          public          postgres    false    208            �           0    0    voucherinuser_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.voucherinuser_id_seq', 11, true);
          public          postgres    false    226            �           2606    16609    User User_email_key 
   CONSTRAINT     S   ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_email_key" UNIQUE (email);
 A   ALTER TABLE ONLY public."User" DROP CONSTRAINT "User_email_key";
       public            postgres    false    201            �           2606    16611    User User_username_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_username_key" UNIQUE (username);
 D   ALTER TABLE ONLY public."User" DROP CONSTRAINT "User_username_key";
       public            postgres    false    201            �           2606    49208    brand brand_pk 
   CONSTRAINT     L   ALTER TABLE ONLY public.brand
    ADD CONSTRAINT brand_pk PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.brand DROP CONSTRAINT brand_pk;
       public            postgres    false    225            �           2606    40999    cart cart_pk 
   CONSTRAINT     J   ALTER TABLE ONLY public.cart
    ADD CONSTRAINT cart_pk PRIMARY KEY (id);
 6   ALTER TABLE ONLY public.cart DROP CONSTRAINT cart_pk;
       public            postgres    false    221            �           2606    41016    cartproduct cart_product_pk 
   CONSTRAINT     Y   ALTER TABLE ONLY public.cartproduct
    ADD CONSTRAINT cart_product_pk PRIMARY KEY (id);
 E   ALTER TABLE ONLY public.cartproduct DROP CONSTRAINT cart_product_pk;
       public            postgres    false    223            �           2606    16581    category category_pk 
   CONSTRAINT     R   ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pk PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.category DROP CONSTRAINT category_pk;
       public            postgres    false    205            �           2606    65622 !   commentproduct comment_product_pk 
   CONSTRAINT     _   ALTER TABLE ONLY public.commentproduct
    ADD CONSTRAINT comment_product_pk PRIMARY KEY (id);
 K   ALTER TABLE ONLY public.commentproduct DROP CONSTRAINT comment_product_pk;
       public            postgres    false    231            �           2606    65667    guaranteeinfo guarantee_pk 
   CONSTRAINT     X   ALTER TABLE ONLY public.guaranteeinfo
    ADD CONSTRAINT guarantee_pk PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.guaranteeinfo DROP CONSTRAINT guarantee_pk;
       public            postgres    false    233            �           2606    57437    placemaster place_master_pk 
   CONSTRAINT     Y   ALTER TABLE ONLY public.placemaster
    ADD CONSTRAINT place_master_pk PRIMARY KEY (id);
 E   ALTER TABLE ONLY public.placemaster DROP CONSTRAINT place_master_pk;
       public            postgres    false    229            �           2606    16637    place place_pk 
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
       public            postgres    false    217            �           2606    32891 )   transactionproduct transaction_product_pk 
   CONSTRAINT     g   ALTER TABLE ONLY public.transactionproduct
    ADD CONSTRAINT transaction_product_pk PRIMARY KEY (id);
 S   ALTER TABLE ONLY public.transactionproduct DROP CONSTRAINT transaction_product_pk;
       public            postgres    false    219            �           2606    16553    User user_pk 
   CONSTRAINT     L   ALTER TABLE ONLY public."User"
    ADD CONSTRAINT user_pk PRIMARY KEY (id);
 8   ALTER TABLE ONLY public."User" DROP CONSTRAINT user_pk;
       public            postgres    false    201            �           2606    49234     voucherinuser voucher_in_user_pk 
   CONSTRAINT     ^   ALTER TABLE ONLY public.voucherinuser
    ADD CONSTRAINT voucher_in_user_pk PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.voucherinuser DROP CONSTRAINT voucher_in_user_pk;
       public            postgres    false    227            �           2606    16626    voucher voucher_pk 
   CONSTRAINT     P   ALTER TABLE ONLY public.voucher
    ADD CONSTRAINT voucher_pk PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.voucher DROP CONSTRAINT voucher_pk;
       public            postgres    false    209            �           2606    41022    cartproduct cart_in_product_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.cartproduct
    ADD CONSTRAINT cart_in_product_fk FOREIGN KEY (product_id) REFERENCES public.product(id);
 H   ALTER TABLE ONLY public.cartproduct DROP CONSTRAINT cart_in_product_fk;
       public          postgres    false    223    3013    207            �           2606    41027    cartproduct cart_product_fk    FK CONSTRAINT     y   ALTER TABLE ONLY public.cartproduct
    ADD CONSTRAINT cart_product_fk FOREIGN KEY (cart_id) REFERENCES public.cart(id);
 E   ALTER TABLE ONLY public.cartproduct DROP CONSTRAINT cart_product_fk;
       public          postgres    false    223    3029    221            �           2606    41017 !   cartproduct cart_product_stock_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.cartproduct
    ADD CONSTRAINT cart_product_stock_fk FOREIGN KEY (stock_id) REFERENCES public.stock(id);
 K   ALTER TABLE ONLY public.cartproduct DROP CONSTRAINT cart_product_stock_fk;
       public          postgres    false    223    3021    213            �           2606    41000    cart cart_user_fk    FK CONSTRAINT     q   ALTER TABLE ONLY public.cart
    ADD CONSTRAINT cart_user_fk FOREIGN KEY (user_id) REFERENCES public."User"(id);
 ;   ALTER TABLE ONLY public.cart DROP CONSTRAINT cart_user_fk;
       public          postgres    false    221    3003    201            �           2606    16598    product category_product_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.product
    ADD CONSTRAINT category_product_fk FOREIGN KEY (category_id) REFERENCES public.category(id);
 E   ALTER TABLE ONLY public.product DROP CONSTRAINT category_product_fk;
       public          postgres    false    3011    205    207            �           2606    49219    product fk_branch_product    FK CONSTRAINT     y   ALTER TABLE ONLY public.product
    ADD CONSTRAINT fk_branch_product FOREIGN KEY (brand_id) REFERENCES public.brand(id);
 C   ALTER TABLE ONLY public.product DROP CONSTRAINT fk_branch_product;
       public          postgres    false    3033    225    207            �           2606    57448 "   Transaction fk_transaction_voucher    FK CONSTRAINT     �   ALTER TABLE ONLY public."Transaction"
    ADD CONSTRAINT fk_transaction_voucher FOREIGN KEY (voucher_id) REFERENCES public.voucher(id);
 N   ALTER TABLE ONLY public."Transaction" DROP CONSTRAINT fk_transaction_voucher;
       public          postgres    false    209    217    3017            �           2606    57438    User fk_user_place    FK CONSTRAINT     z   ALTER TABLE ONLY public."User"
    ADD CONSTRAINT fk_user_place FOREIGN KEY (place_id) REFERENCES public.placemaster(id);
 >   ALTER TABLE ONLY public."User" DROP CONSTRAINT fk_user_place;
       public          postgres    false    229    201    3037            �           2606    65668 .   guaranteeinfo guarantee_transaction_product_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.guaranteeinfo
    ADD CONSTRAINT guarantee_transaction_product_fk FOREIGN KEY (transactionproduct_id) REFERENCES public.transactionproduct(id);
 X   ALTER TABLE ONLY public.guaranteeinfo DROP CONSTRAINT guarantee_transaction_product_fk;
       public          postgres    false    233    219    3027            �           2606    65633 )   commentproduct product_comment_product_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.commentproduct
    ADD CONSTRAINT product_comment_product_fk FOREIGN KEY (product_id) REFERENCES public.product(id);
 S   ALTER TABLE ONLY public.commentproduct DROP CONSTRAINT product_comment_product_fk;
       public          postgres    false    231    207    3013            �           2606    24704    stockinproduct product_fk    FK CONSTRAINT     }   ALTER TABLE ONLY public.stockinproduct
    ADD CONSTRAINT product_fk FOREIGN KEY (product_id) REFERENCES public.product(id);
 C   ALTER TABLE ONLY public.stockinproduct DROP CONSTRAINT product_fk;
       public          postgres    false    207    215    3013            �           2606    65623 '   commentproduct stock_comment_product_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.commentproduct
    ADD CONSTRAINT stock_comment_product_fk FOREIGN KEY (stock_id) REFERENCES public.stock(id);
 Q   ALTER TABLE ONLY public.commentproduct DROP CONSTRAINT stock_comment_product_fk;
       public          postgres    false    231    3021    213            �           2606    24699    stockinproduct stock_fk    FK CONSTRAINT     w   ALTER TABLE ONLY public.stockinproduct
    ADD CONSTRAINT stock_fk FOREIGN KEY (stock_id) REFERENCES public.stock(id);
 A   ALTER TABLE ONLY public.stockinproduct DROP CONSTRAINT stock_fk;
       public          postgres    false    213    215    3021            �           2606    16649    stock stock_place_fk    FK CONSTRAINT     t   ALTER TABLE ONLY public.stock
    ADD CONSTRAINT stock_place_fk FOREIGN KEY (place_id) REFERENCES public.place(id);
 >   ALTER TABLE ONLY public.stock DROP CONSTRAINT stock_place_fk;
       public          postgres    false    211    3019    213            �           2606    32897 ,   transactionproduct transaction_in_product_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.transactionproduct
    ADD CONSTRAINT transaction_in_product_fk FOREIGN KEY (product_id) REFERENCES public.product(id);
 V   ALTER TABLE ONLY public.transactionproduct DROP CONSTRAINT transaction_in_product_fk;
       public          postgres    false    219    207    3013            �           2606    32902 )   transactionproduct transaction_product_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.transactionproduct
    ADD CONSTRAINT transaction_product_fk FOREIGN KEY (transaction_id) REFERENCES public."Transaction"(id);
 S   ALTER TABLE ONLY public.transactionproduct DROP CONSTRAINT transaction_product_fk;
       public          postgres    false    3025    217    219            �           2606    32892 /   transactionproduct transaction_product_stock_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.transactionproduct
    ADD CONSTRAINT transaction_product_stock_fk FOREIGN KEY (stock_id) REFERENCES public.stock(id);
 Y   ALTER TABLE ONLY public.transactionproduct DROP CONSTRAINT transaction_product_stock_fk;
       public          postgres    false    3021    213    219            �           2606    32874    Transaction transaction_user_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public."Transaction"
    ADD CONSTRAINT transaction_user_fk FOREIGN KEY (user_id) REFERENCES public."User"(id);
 K   ALTER TABLE ONLY public."Transaction" DROP CONSTRAINT transaction_user_fk;
       public          postgres    false    201    217    3003            �           2606    65628 &   commentproduct user_comment_product_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.commentproduct
    ADD CONSTRAINT user_comment_product_fk FOREIGN KEY (user_id) REFERENCES public."User"(id);
 P   ALTER TABLE ONLY public.commentproduct DROP CONSTRAINT user_comment_product_fk;
       public          postgres    false    231    3003    201            �           2606    49235    voucherinuser user_fk    FK CONSTRAINT     u   ALTER TABLE ONLY public.voucherinuser
    ADD CONSTRAINT user_fk FOREIGN KEY (user_id) REFERENCES public."User"(id);
 ?   ALTER TABLE ONLY public.voucherinuser DROP CONSTRAINT user_fk;
       public          postgres    false    201    3003    227            �           2606    49240    voucherinuser voucher_fk    FK CONSTRAINT     |   ALTER TABLE ONLY public.voucherinuser
    ADD CONSTRAINT voucher_fk FOREIGN KEY (voucher_id) REFERENCES public.voucher(id);
 B   ALTER TABLE ONLY public.voucherinuser DROP CONSTRAINT voucher_fk;
       public          postgres    false    209    227    3017           