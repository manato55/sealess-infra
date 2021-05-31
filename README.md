# フォルダ構成

```
tennisup
 |-- tennisup-frontend
 |-- tennisup-backend
 |-- tennisup-infra
```

# 準備

### 1. Git Clone

```
mkdir tennisup
cd tennisup
git clone https://github.com/manato55/tennisup-infra.git
git clone https://github.com/manato55/tennisup-backend.git
git clone https://github.com/manato55/tennisup-frontend.git
```

### 2. 環境設定をする

```
cd tennisup-infra
cp .env.sample .env
```

.env に環境設定値をセットする
<br />
<br />

# 開発環境

### 1. docker image 作成

```
cd tennisup-infra
docker-compose build
```

### 2. docker containar 起動

```
docker-compose up -d
```

### 3. laravel 初期設定

php コンテナに入る

```
docker-compose exec server bash
```

php コンテナ内

```
cp .env.sample .env

composer install

chmod 777 -R storage/
chmod 777 -R bootstrap/cache/

php artisan key:generate
php artisan migrate
php artisan db:seed
```

### 4. Vuejs 初期設定

ローカル環境に Nodejs がインストールされていない場合はインストールする
[Nodejs ダウンロード](https://nodejs.org/ja/)

```
cd tennisup-frontend
cp .env.sample .env
```

.env に環境設定値をセットする
<br />
<br />

パッケージインストール

```
npm install
```

### 5. front サーバ起動

Vuejs のビルドインサーバ起動

```
npm run serve
```
