.PHONY: bundle gen-go gen-ts

bundle:
	redocly bundle definitions/main.yaml -o bundled.yaml

# CHIベースのgolangバックエンドAPIコード自動生成
gen-go:
	@oapi-codegen -config chi_config.yaml \
		bundled.yaml > ../app/gen/api.go

# openapi-typescript-codegenによるTypeScript型定義ファイルの生成
gen-ts:
	@npx openapi-typescript-codegen --input bundled.yaml --output ../app/gen/api