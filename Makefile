.PHONY: bundle gen-go gen-go-chi

bundle:
	redocly bundle definitions/main.yaml -o bundled.yaml

# バンドル済みYAMLからGoのAPIコードを生成
gen-go:
	@oapi-codegen -package api \
		-generate types,server,spec \
		bundled.yaml > ../app/gen_api/api.go

# CHIベースの生成（新規追加）
gen-go-chi:
	@oapi-codegen -config chi_config.yaml \
		bundled.yaml > ../app/gen_api/api.go