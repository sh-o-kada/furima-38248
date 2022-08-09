# テーブル設計

## usersテーブル

| Column              | Type   | Options                   |
| ------------------- | ------ | ------------------------- |
| nickname            | string | null: false               |
| email               | string | null: false, unique: true |
| encrypted_password  | string | null: false               |
| last_name           | string | null: false               |
| first_name          | string | null: false               |
| last_name_spelling  | string | null: false               |
| first_name_spelling | string | null: false               |
| birthday            | date   | null: false               |

### Association

- has_many :items
- has_many :orders

## itemsテーブル

| Column          | Type       | Options                        |
| --------------- | ---------- | ------------------------------ |
| name            | string     | null: false                    |
| content         | text       | null: false                    |
| category        | integer    | null: false                    |
| condition       | integer    | null: false                    |
| delivery_charge | integer    | null: false                    |
| prefecture      | integer    | null: false                    |
| take            | integer    | null: false                    |
| price           | integer    | null: false                    |
| user            | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :order

## ordersテーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| user    | references | null: false, foreign_key: true |
| item    | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :address

## addressテーブル

| Column    | Type       | Options                        |
| post_code | string     | null: false                    |
| city      | string     | null: false                    |
| address   | string     | null: false                    |
| building  | string     |                                |
| phone     | string     | null: false                    |
| order     | references | null: false, foreign_key: true |

### Association

- belongs_to :order