## `vm-init`: Create libvirt VMs quickly

### Dependencies

- `gum`
- `virt-install`
- `virsh`

### Installation

1. Prepare a directory for storing the required cloud images and qcow2 disks with the following structure:

```
.
├── disks
│   ├── ...
│   └── ubuntu18.04-server.qcow2
└── img
    ├── ...
    └── ubuntu-18.04-server-cloudimg-amd64.img
```

2. Set environmental variable `VIRT_HOME` to point to that directory
3. Download cloud disk images (`.qcow2`/`.img`) using any of the following:

- [Ubuntu](https://cloud-images.ubuntu.com/releases/) (download `VERSION/release/ubuntu-VERSION-server-cloudimg-amd64.img`, place into the `img/` directory)
- [Arch Linux](https://geo.mirror.pkgbuild.com/images/latest/) (download `Arch-Linux-x86_64-cloudimg.qcow2`, rename to `arch-linux-x86_64-cloudimg.img` to be detected, place into the `img/` directory)
- [AlmaLinux](https://almalinux.org/get-almalinux/) (download generic cloud image, change name to be all lowercase and change extension to `.img`)

4. Adjust the [`cloud-init`](https://cloudinit.readthedocs.io/en/latest/reference/modules.html) config files in [`cidata/`](./cidata) according to your needs
5. Run the script
