.PHONY: seal-secrets clean-secrets

SECRETS_DIR := manifests/secrets
SEALED_DIR := manifests/sealed-secrets


seal-secrets:
	@echo "Sealing secrets..."
	@mkdir -p $(SEALED_DIR)
	@for file in $(SECRETS_DIR)/*.yaml $(SECRETS_DIR)/.*yml; do \
		if [ -f "$$file" ]; then \
			filename=$$(basename "$$file"); \
			echo "	-> sealing $$filename..."; \
			kubeseal --format=yaml < "$$file" > "$(SEALED_DIR)/$$filename"; \
		fi; \
	done
	@echo "Done! Sealded files can be found in $(SEALED_DIR)"
	@echo "Be sure $(SECRETS_DIR) in .gitignore"

clean-secrets:
	@echo "Deleting old selead secrets"
	@rm -f $(SEALED_DIR)/*.yaml $(SEALED_DIR)/*.yml
	@echo "$(SEALED_DIR) is clean now"
