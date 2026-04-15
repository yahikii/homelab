# Homelab

<div align="center"> 🌿•₊✧💻⋆⭒˚☕️｡⋆ </div>

personal homelab setup | podman kube manifests for my self-hosted services | always evolving („• ֊ •„)੭

-> running on UGreen NAS DXP4800 (RAID 5) (hardware prices please go down,,,)


## Services

| Name | Description | Location |
| ---- | ----------- | -------- |
| Traefik | Reverse Proxy & SSL Termination | `./traefik/` |
| Tailscale | VPN Access, implemented in Traefik | `./traefik/` |
| Mediaserver | Jellyfin & Media-stack | `./mediaserver/` |

## Overview

Services are running via podman over the NAS. Traefik sits in front of every service and handles routing + tls. All services are being deployed via podman kube manifests (for easier migration in the future to K8s), their traffic is routed through the dynamic traefik ingress rules.

DNS entries are being handled via the pi-hole. For external access, tailscale is installed on the NAS itself. 💡 Note to myself, remove the one from tailscale >:(

```
internet → pi-hole → tailscale →  traefik   → mediaserver
                                            → media-stack
                                            → (more services soon...™)
```
The mediaserver was moved to an private repository and is added to this one via git submodules.


<div align="center"> ‧₊˚🎐✩ ₊˚🕊️⊹ ♡ </div>

## Usage

### Deployment

For initial deployment, do the following:

```bash
# clone repo with submodules
git clone --recurse-submodules https://github.com/yahikii/homelab

# change to service folder and deploy with makefile
make deploy

# or run podman kube manually, e.g. traefik
podman kube play --replace traefik.configmaps.yaml traefik.dynamic.configmaps.yaml tailscale.secrets.yaml traefik.deployment.yaml
```

### Updating submodules

To have the most recent submodule or updating it, run the following:

```bash
git submodule update --remote mediaserver

# or if the initializing is missing:
git submodule update --init --remote mediaserver
```

## Known Issues

### Podman version workaround

The NAS ships with Podman 4.3.1 which is too old for some `podman kube` features that are needed. (E.g. secrets management handling) Since the OS doesn't offer a newer package and just install a static Podman binary in the userspace:

```bash
curl -L https://github.com/nicholasgasior/podman-static/releases/download/v5.8.0/podman-linux-amd64 \
  -o ~/.local/bin/podman
chmod +x ~/.local/bin/podman
```

`~/.local/bin` takes priority over `/usr/bin` in `$PATH`, so the newer binary is picked up automatically without touching the system Podman.

👉 Version needs to be changed if newer one came out


## To-Do

- [x] Rewrite in Podman Kube
- [x] Add external access solution -> Tailscale?
- [ ] Add Tailscale deploy script for NAS deployment
- [ ] Automatic certificate rotation
- [ ] Templating of config files for services
- [ ] Rewrite in Terraform 🤡
