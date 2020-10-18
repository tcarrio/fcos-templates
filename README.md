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

