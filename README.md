# focs-templates

Some potentially useful Fedora CoreOS templates (Ignition Configurations, Fedora CoreOS Configurations, etc.) that I'm storing here for later reference.

## Getting Started

Well, if you want to start doing any of this from scratch, install `fcct`. There's an AUR package (duh, it's the AUR). If not on Arch, download the Fedora GPG signing keys from `https://getfedora.org/static/fedora.gpg` so you can verify the files.

Download the latest version of [fcct](https://github.com/coreos/fcct/releases), the corresponding [signature](), and verify the download.

```sh
gpg --verify fcct-$arch-$version-linux-gnu.asc fcct-$arch-$version-linux-gnu
```

Now you can make a Fedora CoreOS configuration file.

```sh
touch base.fcc
```

## Installation

With a CoreOS Configuration File transpiled to an Ignition File, you would not be ready to install CoreOS.

### Generating a virtual machine

Download the installer ISO

```sh
podman run --privileged --pull=always --rm -v .:/data -w /data \
    quay.io/coreos/coreos-installer:release download -f iso
```

Now, host the generated Ignition configuration file so it will be accessible for the installer

```
python -m http.server
```

That should launch at localhost with the current context.

Now, launch a virtual machine with the installer ISO. When you're booted, run the command to install from the Ignition config:

```sh
sudo coreos-installer install /dev/sda \
    --ignition-url https://localhost:8000/example.ign
```

### Installing to disk

You can mount the block files to a container to install directly to it.

```sh
sudo podman run --pull=always --privileged --rm \
    -v /dev:/dev -v /run/udev:/run/udev -v .:/data -w /data \
    quay.io/coreos/coreos-installer:release \
    install /dev/vdb -i config.ign
```