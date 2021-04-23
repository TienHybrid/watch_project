PGDMP                         y            watch    13.1 (Debian 13.1-1.pgdg100+1)    13.2 G    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                        1262    16384    watch    DATABASE     Y   CREATE DATABASE watch WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.utf8';
    DROP DATABASE watch;
                postgres    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
                postgres    false                       0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                   postgres    false    3            �            1259    16542    User    TABLE     F  CREATE TABLE public."User" (
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
       public          postgres    false    3    201                       0    0    User_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public."User_id_seq" OWNED BY public."User".id;
          public          postgres    false    200            �            1259    16570    category    TABLE     H  CREATE TABLE public.category (
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
       public          postgres    false    205    3                       0    0    category_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.category_id_seq OWNED BY public.category.id;
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
       public          postgres    false    3    211                       0    0    place_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.place_id_seq OWNED BY public.place.id;
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
       public          postgres    false    207    3                       0    0    product_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.product_id_seq OWNED BY public.product.id;
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
       public          postgres    false    3    203                       0    0    staff_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.staff_id_seq OWNED BY public.staff.id;
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
       public          postgres    false    213    3                       0    0    stock_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.stock_id_seq OWNED BY public.stock.id;
          public          postgres    false    212            �            1259    16656    stockinproduct    TABLE     Z  CREATE TABLE public.stockinproduct (
    id integer NOT NULL,
    stock_id integer,
    product_id integer,
    quantity integer NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL
);
 "   DROP TABLE public.stockinproduct;
       public         heap    postgres    false    3            �            1259    16654    stockinproduct_id_seq    SEQUENCE     �   CREATE SEQUENCE public.stockinproduct_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.stockinproduct_id_seq;
       public          postgres    false    215    3                       0    0    stockinproduct_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.stockinproduct_id_seq OWNED BY public.stockinproduct.id;
          public          postgres    false    214            �            1259    16616    voucher    TABLE     p  CREATE TABLE public.voucher (
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
       public          postgres    false    3    209            	           0    0    voucher_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.voucher_id_seq OWNED BY public.voucher.id;
          public          postgres    false    208            "           2604    16545    User id    DEFAULT     f   ALTER TABLE ONLY public."User" ALTER COLUMN id SET DEFAULT nextval('public."User_id_seq"'::regclass);
 8   ALTER TABLE public."User" ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    200    201    201            +           2604    16573    category id    DEFAULT     j   ALTER TABLE ONLY public.category ALTER COLUMN id SET DEFAULT nextval('public.category_id_seq'::regclass);
 :   ALTER TABLE public.category ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    205    204    205            ?           2604    16632    place id    DEFAULT     d   ALTER TABLE ONLY public.place ALTER COLUMN id SET DEFAULT nextval('public.place_id_seq'::regclass);
 7   ALTER TABLE public.place ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    210    211    211            /           2604    16587 
   product id    DEFAULT     h   ALTER TABLE ONLY public.product ALTER COLUMN id SET DEFAULT nextval('public.product_id_seq'::regclass);
 9   ALTER TABLE public.product ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    206    207    207            '           2604    16559    staff id    DEFAULT     d   ALTER TABLE ONLY public.staff ALTER COLUMN id SET DEFAULT nextval('public.staff_id_seq'::regclass);
 7   ALTER TABLE public.staff ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    203    202    203            C           2604    16643    stock id    DEFAULT     d   ALTER TABLE ONLY public.stock ALTER COLUMN id SET DEFAULT nextval('public.stock_id_seq'::regclass);
 7   ALTER TABLE public.stock ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    212    213    213            G           2604    16659    stockinproduct id    DEFAULT     v   ALTER TABLE ONLY public.stockinproduct ALTER COLUMN id SET DEFAULT nextval('public.stockinproduct_id_seq'::regclass);
 @   ALTER TABLE public.stockinproduct ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    215    214    215            6           2604    16619 
   voucher id    DEFAULT     h   ALTER TABLE ONLY public.voucher ALTER COLUMN id SET DEFAULT nextval('public.voucher_id_seq'::regclass);
 9   ALTER TABLE public.voucher ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    208    209    209            �          0    16542    User 
   TABLE DATA           �   COPY public."User" (id, username, fullname, email, password, address, phone_number, avatar_url, created_at, updated_at, is_deleted, voucher) FROM stdin;
    public          postgres    false    201            �          0    16570    category 
   TABLE DATA           [   COPY public.category (id, name, image_url, created_at, updated_at, is_deleted) FROM stdin;
    public          postgres    false    205            �          0    16629    place 
   TABLE DATA           Y   COPY public.place (id, name, short_name, created_at, updated_at, is_deleted) FROM stdin;
    public          postgres    false    211            �          0    16584    product 
   TABLE DATA           �   COPY public.product (id, name, price, quantity, category_id, image_url, slug, description, created_at, updated_at, is_deleted) FROM stdin;
    public          postgres    false    207            �          0    16556    staff 
   TABLE DATA           �   COPY public.staff (id, username, fullname, email, password, address, phone_number, avatar_url, created_at, updated_at, is_deleted) FROM stdin;
    public          postgres    false    203            �          0    16640    stock 
   TABLE DATA           W   COPY public.stock (id, name, place_id, created_at, updated_at, is_deleted) FROM stdin;
    public          postgres    false    213            �          0    16656    stockinproduct 
   TABLE DATA           p   COPY public.stockinproduct (id, stock_id, product_id, quantity, created_at, updated_at, is_deleted) FROM stdin;
    public          postgres    false    215            �          0    16616    voucher 
   TABLE DATA           �   COPY public.voucher (id, name, type, begin_date, end_date, created_at, updated_at, is_deleted, discount, active, code) FROM stdin;
    public          postgres    false    209            
           0    0    User_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public."User_id_seq"', 33, true);
          public          postgres    false    200                       0    0    category_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.category_id_seq', 35, true);
          public          postgres    false    204                       0    0    place_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.place_id_seq', 3, true);
          public          postgres    false    210                       0    0    product_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.product_id_seq', 36, true);
          public          postgres    false    206                       0    0    staff_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.staff_id_seq', 1, true);
          public          postgres    false    202                       0    0    stock_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.stock_id_seq', 4, true);
          public          postgres    false    212                       0    0    stockinproduct_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.stockinproduct_id_seq', 7, true);
          public          postgres    false    214                       0    0    voucher_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.voucher_id_seq', 3, true);
          public          postgres    false    208            L           2606    16609    User User_email_key 
   CONSTRAINT     S   ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_email_key" UNIQUE (email);
 A   ALTER TABLE ONLY public."User" DROP CONSTRAINT "User_email_key";
       public            postgres    false    201            N           2606    16611    User User_username_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_username_key" UNIQUE (username);
 D   ALTER TABLE ONLY public."User" DROP CONSTRAINT "User_username_key";
       public            postgres    false    201            X           2606    16581    category category_pk 
   CONSTRAINT     R   ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pk PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.category DROP CONSTRAINT category_pk;
       public            postgres    false    205            `           2606    16637    place place_pk 
   CONSTRAINT     L   ALTER TABLE ONLY public.place
    ADD CONSTRAINT place_pk PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.place DROP CONSTRAINT place_pk;
       public            postgres    false    211            Z           2606    16597    product product_pk 
   CONSTRAINT     P   ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_pk PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.product DROP CONSTRAINT product_pk;
       public            postgres    false    207            \           2606    16613    product product_slug_key 
   CONSTRAINT     S   ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_slug_key UNIQUE (slug);
 B   ALTER TABLE ONLY public.product DROP CONSTRAINT product_slug_key;
       public            postgres    false    207            R           2606    16605    staff staff_email_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.staff
    ADD CONSTRAINT staff_email_key UNIQUE (email);
 ?   ALTER TABLE ONLY public.staff DROP CONSTRAINT staff_email_key;
       public            postgres    false    203            T           2606    16567    staff staff_pk 
   CONSTRAINT     L   ALTER TABLE ONLY public.staff
    ADD CONSTRAINT staff_pk PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.staff DROP CONSTRAINT staff_pk;
       public            postgres    false    203            V           2606    16607    staff staff_username_key 
   CONSTRAINT     W   ALTER TABLE ONLY public.staff
    ADD CONSTRAINT staff_username_key UNIQUE (username);
 B   ALTER TABLE ONLY public.staff DROP CONSTRAINT staff_username_key;
       public            postgres    false    203            d           2606    16664 "   stockinproduct stock_in_product_pk 
   CONSTRAINT     `   ALTER TABLE ONLY public.stockinproduct
    ADD CONSTRAINT stock_in_product_pk PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.stockinproduct DROP CONSTRAINT stock_in_product_pk;
       public            postgres    false    215            b           2606    16648    stock stock_pk 
   CONSTRAINT     L   ALTER TABLE ONLY public.stock
    ADD CONSTRAINT stock_pk PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.stock DROP CONSTRAINT stock_pk;
       public            postgres    false    213            P           2606    16553    User user_pk 
   CONSTRAINT     L   ALTER TABLE ONLY public."User"
    ADD CONSTRAINT user_pk PRIMARY KEY (id);
 8   ALTER TABLE ONLY public."User" DROP CONSTRAINT user_pk;
       public            postgres    false    201            ^           2606    16626    voucher voucher_pk 
   CONSTRAINT     P   ALTER TABLE ONLY public.voucher
    ADD CONSTRAINT voucher_pk PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.voucher DROP CONSTRAINT voucher_pk;
       public            postgres    false    209            e           2606    16598    product category_product_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.product
    ADD CONSTRAINT category_product_fk FOREIGN KEY (category_id) REFERENCES public.category(id);
 E   ALTER TABLE ONLY public.product DROP CONSTRAINT category_product_fk;
       public          postgres    false    207    205    2904            h           2606    16670    stockinproduct product_fk    FK CONSTRAINT     }   ALTER TABLE ONLY public.stockinproduct
    ADD CONSTRAINT product_fk FOREIGN KEY (product_id) REFERENCES public.product(id);
 C   ALTER TABLE ONLY public.stockinproduct DROP CONSTRAINT product_fk;
       public          postgres    false    207    2906    215            g           2606    16665    stockinproduct stock_fk    FK CONSTRAINT     w   ALTER TABLE ONLY public.stockinproduct
    ADD CONSTRAINT stock_fk FOREIGN KEY (stock_id) REFERENCES public.stock(id);
 A   ALTER TABLE ONLY public.stockinproduct DROP CONSTRAINT stock_fk;
       public          postgres    false    213    2914    215            f           2606    16649    stock stock_place_fk    FK CONSTRAINT     t   ALTER TABLE ONLY public.stock
    ADD CONSTRAINT stock_place_fk FOREIGN KEY (place_id) REFERENCES public.place(id);
 >   ALTER TABLE ONLY public.stock DROP CONSTRAINT stock_place_fk;
       public          postgres    false    211    213    2912            �   �   x�}��N�0Ek�+�Xʍ=�G�HD�j�٠$�b����h�ՑNs.��sae��l�^�~\h��!.,_�9>������VJ4�g{�*(�ҷM��� @8��['t0R`�lk�DC�s����1@@v)%��0m���ōF_�1���4���)x����h;�a�)��b���_��n����8�Y����i����.�M�P ��:�< vZt 56ZJ��
�������{�W�      �   1  x���1N�0@��Y���qGBH���:"ENk�Ai%�[ 13q�20�#�{�&Dl��N����ޓ>������F����f�����86U�K��޻NY��s�֪�z�t����e�T�nV���Ƥ���[����/���u/g�j���������������ԌF�$�3�(˙����$IĎ��vJ{V�D
A{`9��$"2��C���a����r�(��p�Db!��bPr��X��mլ�LH
Ι��T &� MC� ~�i-~?��{c���EF�`'3Ɵ��J!d�F�Ħ9�      �   �   x�3��8�@�����~�FF��&�F�
�FV�V�zƖ&�f��Ҹ�9=��qx��of^�G�3�C+#3=SCKcC|Ri\F�G&�]�kk^:������,-�LML�I�q��qqq q5�      �   �  x����n�0���Sd�'>Ǘ8�j�RMG���y&��(7&)��q��E�&X�v`:��^xq�}���������M�m������m�{���M��H�}�x�p��,������� /w�J�Y?�;]d~ѶE����u[�i�
ֺʚT��*�%�u��];��6x�k����_�٠�*��F�mW������R?�R�G�Т C�(�(�S
~s��l�v�9�F�ɶ��9~Y97K)�� � c1�|&Bq�����h�X^zo����^��pq�-.�Ζ�h]>�N��B
{pE@���(8���TDn�*����_,6g�?Fx�d���5+u�6�7�fWL�o�B�i3��D�B��z.Lہ�Ȧb��"�G$ I8�U�7��]����y2XJ%�:Q14ɧi���&r��qcjZ�d"A��{�V���E�����2� ���z���xY�c��}3�1���ǥܽ�]�����      �   �   x�}��N�0Eg�+:�1��Ǒ,�	LH�s������b�LW�,G�¹���v(;m�U�����"�Lxj��_�b�y$�]��4�j�;o-B�d�';0��K480t�+s
�
��P�����{)ò��|m�;M�L1N+SZ�I~��r�����ڇ�BC)���2�\(�|�в���uZ[h>��Dky��@@U��Q��z�Ck��O�꽩���Y�      �   �   x�3����W�H��P�(=�(�Ӑ����P��D��X��������P�������T��,���&g(�&fb3��X�������T�1�(��\��cJ9�1���Y�Z�I�2�sd����|���9����D������sRi\1z\\\ �>D�      �   �   x�}���0�᳙���,=���/Mՠ��F������6���~Hb���S*��z+��dF�S*�%�`���8H0r��S*�E��&4M�oK������	�L��� NAמ�1ud#��R���h��S��T�F � uxT�      �   �   x�3�<2����y�
*�r&��ė�q���+X�D��@�� M���������T�������TP�������=���1�Ȁˈ�;#1S!��؆c�N�Dq��	+-	8�����3 RPgx{8zƇ�]�et���
��ٵ=Y�)�����p10ôO�XXm5154�'��iu��G���s���kW� %e      G    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                        1262    16384    watch    DATABASE     Y   CREATE DATABASE watch WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.utf8';
    DROP DATABASE watch;
                postgres    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
                postgres    false                       0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                   postgres    false    3            �            1259    16542    User    TABLE     F  CREATE TABLE public."User" (
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
       public          postgres    false    3    201                       0    0    User_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public."User_id_seq" OWNED BY public."User".id;
          public          postgres    false    200            �            1259    16570    category    TABLE     H  CREATE TABLE public.category (
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
       public          postgres    false    205    3                       0    0    category_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.category_id_seq OWNED BY public.category.id;
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
       public          postgres    false    3    211                       0    0    place_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.place_id_seq OWNED BY public.place.id;
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
       public          postgres    false    207    3                       0    0    product_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.product_id_seq OWNED BY public.product.id;
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
       public          postgres    false    3    203                       0    0    staff_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.staff_id_seq OWNED BY public.staff.id;
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
       public          postgres    false    213    3                       0    0    stock_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.stock_id_seq OWNED BY public.stock.id;
          public          postgres    false    212            �            1259    16656    stockinproduct    TABLE     Z  CREATE TABLE public.stockinproduct (
    id integer NOT NULL,
    stock_id integer,
    product_id integer,
    quantity integer NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL
);
 "   DROP TABLE public.stockinproduct;
       public         heap    postgres    false    3            �            1259    16654    stockinproduct_id_seq    SEQUENCE     �   CREATE SEQUENCE public.stockinproduct_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.stockinproduct_id_seq;
       public          postgres    false    215    3                       0    0    stockinproduct_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.stockinproduct_id_seq OWNED BY public.stockinproduct.id;
          public          postgres    false    214            �            1259    16616    voucher    TABLE     p  CREATE TABLE public.voucher (
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
       public          postgres    false    3    209            	           0    0    voucher_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.voucher_id_seq OWNED BY public.voucher.id;
          public          postgres    false    208            "           2604    16545    User id    DEFAULT     f   ALTER TABLE ONLY public."User" ALTER COLUMN id SET DEFAULT nextval('public."User_id_seq"'::regclass);
 8   ALTER TABLE public."User" ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    200    201    201            +           2604    16573    category id    DEFAULT     j   ALTER TABLE ONLY public.category ALTER COLUMN id SET DEFAULT nextval('public.category_id_seq'::regclass);
 :   ALTER TABLE public.category ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    205    204    205            ?           2604    16632    place id    DEFAULT     d   ALTER TABLE ONLY public.place ALTER COLUMN id SET DEFAULT nextval('public.place_id_seq'::regclass);
 7   ALTER TABLE public.place ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    210    211    211            /           2604    16587 
   product id    DEFAULT     h   ALTER TABLE ONLY public.product ALTER COLUMN id SET DEFAULT nextval('public.product_id_seq'::regclass);
 9   ALTER TABLE public.product ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    206    207    207            '           2604    16559    staff id    DEFAULT     d   ALTER TABLE ONLY public.staff ALTER COLUMN id SET DEFAULT nextval('public.staff_id_seq'::regclass);
 7   ALTER TABLE public.staff ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    203    202    203            C           2604    16643    stock id    DEFAULT     d   ALTER TABLE ONLY public.stock ALTER COLUMN id SET DEFAULT nextval('public.stock_id_seq'::regclass);
 7   ALTER TABLE public.stock ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    212    213    213            G           2604    16659    stockinproduct id    DEFAULT     v   ALTER TABLE ONLY public.stockinproduct ALTER COLUMN id SET DEFAULT nextval('public.stockinproduct_id_seq'::regclass);
 @   ALTER TABLE public.stockinproduct ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    215    214    215            6           2604    16619 
   voucher id    DEFAULT     h   ALTER TABLE ONLY public.voucher ALTER COLUMN id SET DEFAULT nextval('public.voucher_id_seq'::regclass);
 9   ALTER TABLE public.voucher ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    208    209    209            �          0    16542    User 
   TABLE DATA           �   COPY public."User" (id, username, fullname, email, password, address, phone_number, avatar_url, created_at, updated_at, is_deleted, voucher) FROM stdin;
    public          postgres    false    201   �       �          0    16570    category 
   TABLE DATA           [   COPY public.category (id, name, image_url, created_at, updated_at, is_deleted) FROM stdin;
    public          postgres    false    205   �        �          0    16629    place 
   TABLE DATA           Y   COPY public.place (id, name, short_name, created_at, updated_at, is_deleted) FROM stdin;
    public          postgres    false    211   ;       �          0    16584    product 
   TABLE DATA           �   COPY public.product (id, name, price, quantity, category_id, image_url, slug, description, created_at, updated_at, is_deleted) FROM stdin;
    public          postgres    false    207   �        �          0    16556    staff 
   TABLE DATA           �   COPY public.staff (id, username, fullname, email, password, address, phone_number, avatar_url, created_at, updated_at, is_deleted) FROM stdin;
    public          postgres    false    203   �       �          0    16640    stock 
   TABLE DATA           W   COPY public.stock (id, name, place_id, created_at, updated_at, is_deleted) FROM stdin;
    public          postgres    false    213   �        �          0    16656    stockinproduct 
   TABLE DATA           p   COPY public.stockinproduct (id, stock_id, product_id, quantity, created_at, updated_at, is_deleted) FROM stdin;
    public          postgres    false    215   �        �          0    16616    voucher 
   TABLE DATA           �   COPY public.voucher (id, name, type, begin_date, end_date, created_at, updated_at, is_deleted, discount, active, code) FROM stdin;
    public          postgres    false    209   �        
           0    0    User_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public."User_id_seq"', 33, true);
          public          postgres    false    200                       0    0    category_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.category_id_seq', 35, true);
          public          postgres    false    204                       0    0    place_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.place_id_seq', 3, true);
          public          postgres    false    210                       0    0    product_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.product_id_seq', 36, true);
          public          postgres    false    206                       0    0    staff_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.staff_id_seq', 1, true);
          public          postgres    false    202                       0    0    stock_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.stock_id_seq', 4, true);
          public          postgres    false    212                       0    0    stockinproduct_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.stockinproduct_id_seq', 7, true);
          public          postgres    false    214                       0    0    voucher_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.voucher_id_seq', 3, true);
          public          postgres    false    208            L           2606    16609    User User_email_key 
   CONSTRAINT     S   ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_email_key" UNIQUE (email);
 A   ALTER TABLE ONLY public."User" DROP CONSTRAINT "User_email_key";
       public            postgres    false    201            N           2606    16611    User User_username_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_username_key" UNIQUE (username);
 D   ALTER TABLE ONLY public."User" DROP CONSTRAINT "User_username_key";
       public            postgres    false    201            X           2606    16581    category category_pk 
   CONSTRAINT     R   ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pk PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.category DROP CONSTRAINT category_pk;
       public            postgres    false    205            `           2606    16637    place place_pk 
   CONSTRAINT     L   ALTER TABLE ONLY public.place
    ADD CONSTRAINT place_pk PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.place DROP CONSTRAINT place_pk;
       public            postgres    false    211            Z           2606    16597    product product_pk 
   CONSTRAINT     P   ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_pk PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.product DROP CONSTRAINT product_pk;
       public            postgres    false    207            \           2606    16613    product product_slug_key 
   CONSTRAINT     S   ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_slug_key UNIQUE (slug);
 B   ALTER TABLE ONLY public.product DROP CONSTRAINT product_slug_key;
       public            postgres    false    207            R           2606    16605    staff staff_email_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.staff
    ADD CONSTRAINT staff_email_key UNIQUE (email);
 ?   ALTER TABLE ONLY public.staff DROP CONSTRAINT staff_email_key;
       public            postgres    false    203            T           2606    16567    staff staff_pk 
   CONSTRAINT     L   ALTER TABLE ONLY public.staff
    ADD CONSTRAINT staff_pk PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.staff DROP CONSTRAINT staff_pk;
       public            postgres    false    203            V           2606    16607    staff staff_username_key 
   CONSTRAINT     W   ALTER TABLE ONLY public.staff
    ADD CONSTRAINT staff_username_key UNIQUE (username);
 B   ALTER TABLE ONLY public.staff DROP CONSTRAINT staff_username_key;
       public            postgres    false    203            d           2606    16664 "   stockinproduct stock_in_product_pk 
   CONSTRAINT     `   ALTER TABLE ONLY public.stockinproduct
    ADD CONSTRAINT stock_in_product_pk PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.stockinproduct DROP CONSTRAINT stock_in_product_pk;
       public            postgres    false    215            b           2606    16648    stock stock_pk 
   CONSTRAINT     L   ALTER TABLE ONLY public.stock
    ADD CONSTRAINT stock_pk PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.stock DROP CONSTRAINT stock_pk;
       public            postgres    false    213            P           2606    16553    User user_pk 
   CONSTRAINT     L   ALTER TABLE ONLY public."User"
    ADD CONSTRAINT user_pk PRIMARY KEY (id);
 8   ALTER TABLE ONLY public."User" DROP CONSTRAINT user_pk;
       public            postgres    false    201            ^           2606    16626    voucher voucher_pk 
   CONSTRAINT     P   ALTER TABLE ONLY public.voucher
    ADD CONSTRAINT voucher_pk PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.voucher DROP CONSTRAINT voucher_pk;
       public            postgres    false    209            e           2606    16598    product category_product_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.product
    ADD CONSTRAINT category_product_fk FOREIGN KEY (category_id) REFERENCES public.category(id);
 E   ALTER TABLE ONLY public.product DROP CONSTRAINT category_product_fk;
       public          postgres    false    207    205    2904            h           2606    16670    stockinproduct product_fk    FK CONSTRAINT     }   ALTER TABLE ONLY public.stockinproduct
    ADD CONSTRAINT product_fk FOREIGN KEY (product_id) REFERENCES public.product(id);
 C   ALTER TABLE ONLY public.stockinproduct DROP CONSTRAINT product_fk;
       public          postgres    false    207    2906    215            g           2606    16665    stockinproduct stock_fk    FK CONSTRAINT     w   ALTER TABLE ONLY public.stockinproduct
    ADD CONSTRAINT stock_fk FOREIGN KEY (stock_id) REFERENCES public.stock(id);
 A   ALTER TABLE ONLY public.stockinproduct DROP CONSTRAINT stock_fk;
       public          postgres    false    213    2914    215            f           2606    16649    stock stock_place_fk    FK CONSTRAINT     t   ALTER TABLE ONLY public.stock
    ADD CONSTRAINT stock_place_fk FOREIGN KEY (place_id) REFERENCES public.place(id);
 >   ALTER TABLE ONLY public.stock DROP CONSTRAINT stock_place_fk;
       public          postgres    false    211    213    2912           