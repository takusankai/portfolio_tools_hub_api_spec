# portfolio_tools_hub_api_spec

Portfolio Tools Hub APIのOpenAPI仕様書とモックサーバー

## サービス起動

### Docker版（推奨）
```bash
# モックサーバーとSwagger UIを起動
make up

# ブラウザでアクセス
# Swagger UI: http://localhost:8080
# モックAPI: http://localhost:8081
```

### ローカル版（Prism CLI）
```bash
# Prismをインストール（初回のみ）
make pr-install

# ローカルモックサーバーを起動
make pr-mock          # 静的モック（port 8084）
make pr-mock-dynamic  # 動的モック（port 8085）
```

## 📋 利用可能なサービス

| サービス | URL | 説明 |
|---------|-----|------|
| **Swagger UI** | http://localhost:8080 | API仕様書の閲覧・インタラクティブテスト |
| **Prism Mock (Docker)** | http://localhost:8081 | Dockerベースのモックサーバー |
| **Prism Mock (Local)** | http://localhost:8084 | ローカルの静的モックサーバー |
| **Prism Dynamic** | http://localhost:8085 | ローカルの動的モックサーバー |

## 🔧 開発コマンド

### Docker関連
```bash
make up           # サービス起動
make down         # サービス停止
make logs         # 全ログ表示
make logs-mock    # モックサーバーログのみ
make logs-swagger # Swagger UIログのみ
```

### OpenAPI関連
```bash
make bundle       # definitions/をbundled.yamlに統合
make validate     # OpenAPIスペックの検証（redocly lint）
```

### コード生成
```bash
make gen-go       # Go言語のサーバーコード生成
make gen-ts       # TypeScriptの型定義生成
```

### Prism CLI
```bash
make pr-install      # Prism CLIをグローバルインストール
make pr-mock         # 静的モックサーバー起動
make pr-mock-dynamic # 動的モックサーバー起動
```

## 📡 API エンドポイント例

### 認証系
```bash
# ユーザー登録
curl -X POST http://localhost:8081/auth/signup \
  -H "Content-Type: application/json" \
  -d '{"email":"test@example.com","password":"password123"}'

# ログイン
curl -X POST http://localhost:8081/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"test@example.com","password":"password123"}'
```

### ユーザー情報取得
```bash
# ユーザーIDリスト
curl "http://localhost:8081/userIdList?limit=10"

# ユーザー名リスト
curl "http://localhost:8081/userNameList?limit=10"

# ルートエンドポイント
curl "http://localhost:8081/?sampleQuery=hello"
```

## 🏗️ プロジェクト構成

```
portfolio_tools_hub_api_spec/
├── definitions/           # OpenAPI仕様の分割ファイル
│   ├── main.yaml         # メインファイル
│   ├── paths/            # エンドポイント定義
│   ├── components/       # 再利用可能なコンポーネント
│   └── schemas/          # データスキーマ
├── bundled.yaml          # 統合されたOpenAPI仕様書
├── docker-compose.yaml   # Docker設定
├── Makefile             # 開発用コマンド
├── .cursorrules         # Cursor AI設定
└── README.md            # このファイル
```

## 🔄 開発フロー

1. **仕様編集**: `definitions/` 内でOpenAPI仕様を編集
2. **バンドル**: `make bundle` で統合ファイルを生成
3. **検証**: `make validate` でスペックをチェック
4. **テスト**: `make up` でモックサーバーを起動してテスト
5. **コード生成**: `make gen-go` や `make gen-ts` でコード生成

## 🎯 Static vs Dynamic モック

### Static モック
- OpenAPIの`example`値を返す
- 常に同じレスポンス
- API仕様の確認に適している

### Dynamic モック
- スキーマに基づいてランダム値を生成
- リクエストごとに異なるレスポンス
- フロントエンド開発・テストに適している

## 🛠️ トラブルシューティング

### よくある問題

**Docker起動エラー**
```bash
# ポートが使用中の場合
docker-compose down
make up
```

**Prismインストールエラー**
```bash
# 正しいパッケージ名でインストール
npm install -g @stoplight/prism-cli
```

**ディレクトリエラー**
```bash
# 新しいターミナルでプロジェクトディレクトリに移動
cd portfolio_tools_hub_api_spec
pwd  # 現在位置を確認
```

## 📚 参考リンク

- [OpenAPI Specification](https://swagger.io/specification/)
- [Stoplight Prism](https://meta.stoplight.io/docs/prism/)
- [Redocly CLI](https://redocly.com/docs/cli/)
- [Swagger UI](https://swagger.io/tools/swagger-ui/)