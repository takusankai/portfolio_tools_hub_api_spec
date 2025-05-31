.PHONY: red-install bundle valid gen-go gen-ts up down logs logs-mock logs-swagger pr-install pr-mock pr-mock-dynamic pr-stop pr-validate pr-proxy

# OpenAPIスペックのバンドルコマンド
red-install:
	npm install -g @redocly/cli

bundle:
	redocly bundle definitions/main.yaml -o bundled.yaml

# コードの自動生成関連のコマンド
# CHIベースのgolangバックエンドAPIコード自動生成
gen-go:
	@oapi-codegen -config chi_config.yaml \
		bundled.yaml > ../app/gen/api.go

# openapi-typescript-codegenによるTypeScript型定義ファイルの生成
gen-ts:
	@npx openapi-typescript-codegen --input bundled.yaml --output ../app/gen/api

# Docker関連のコマンド
up:
	docker-compose up -d

down:
	docker-compose down

log:
	docker-compose logs -f

los-mock:
	docker-compose logs -f mock-server

log-swagger:
	docker-compose logs -f swagger-ui
	
# prism関連のコマンド
pr-install:
	npm install -g @stoplight/prism-cli

pr-mock:
	prism mock bundled.yaml --port 8084

pr-mock-dynamic:
	prism mock bundled.yaml --dynamic --port 8085

pr-proxy:
	prism proxy bundled.yaml http://localhost:8080 --port 8086
