.PHONY: deploy remove-pod purge

deploy:
	@echo 'Creating Traefik Pod'
	podman kube play --replace traefik.configmaps.yaml traefik.dynamic.configmaps.yaml traefik.deployment.yaml

remove-pod:
	podman kube down traefik.deployment.yaml

purge:
	podman kube down traefik.configmaps.yaml traefik.dynamic.configmaps.yaml traefik.deployment.yaml
