.PHONY: bundle gen-go

bundle:
	redocly bundle definitions/main.yaml -o bundled.yaml

# CHIベースのgolangバックエンドAPIコード自動生成
gen-go:
	@oapi-codegen -config chi_config.yaml \
		bundled.yaml > ../app/gen_api/api.go