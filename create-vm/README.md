## `create-vm`: Create libvirt VMs quickly

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
3. Adjust the [`cloud-init`](https://cloudinit.readthedocs.io/en/latest/reference/modules.html) config files in [`cidata/`](./cidata) according to your needs
4. Run the script
