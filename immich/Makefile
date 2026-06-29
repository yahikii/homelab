SECRET_NAME = database-secrets
SECRET_FILE = immich.secrets.yaml

.PHONY: ensure-secret deploy remove-pod purge

ensure-secret:
	@echo "Checking if secrets '$(SECRET_NAME)' are existing..."
	@if ! podman secret inspect $(SECRET_NAME) >/dev/null 2>&1; then \
		echo "Secrets not found, creating..."; \
		podman kube play $(SECRET_FILE); \
	else \
		echo "Secrets '$(SECRET_NAME)' are existing, skipping creation."; \
	fi

deploy: ensure-secret
	@echo 'Deploying Immich pods and configurations'
	podman kube play --replace immich.configmaps.yaml immich.secrets.yaml immich.deployment.yaml

remove-pod:
	podman kube down immich.deployment.yaml


purge:
	podman kube down immich.configmaps.yaml immich.secrets.yaml immich.deployment.yaml
