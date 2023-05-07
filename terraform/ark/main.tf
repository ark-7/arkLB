/* 
This Terraform script creates 3 VMs in the same VPC network.
The 1st VM has 3 NICs and the 2nd and 3rd VMs have 2 NICs.

You can use this script to create a test environment for T-Rex.
NOTE: Edit the script to add your values before deployment.
*/
provider "google" {
  project = "<project_id>"
  region  = "us-central1"
}

# Create the 1st VM with N2 machine type, 32GB RAM, Intel Cascade Lake CPU type, and 3 NICs
resource "google_compute_instance" "vm1" {
  name         = "vm1"
  machine_type = "n2-standard-8"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }

  network_interface {
    network    = "default"
    nic_type   = "VIRTIO_NET"
  }

  network_interface {
    network    = "t-rex-1"
    nic_type   = "VIRTIO_NET"
  }

  network_interface {
    network    = "t-rex-2"
    nic_type   = "VIRTIO_NET"
  }

  guest_accelerator {
    type = "intel-cascade-lake"
    count = 1
  }

  metadata = {
    ssh-keys = "<your_ssh_public_key>"
  }
}

# Create the 2nd and 3rd VMs with Debian 11 OS and 2 NICs
resource "google_compute_instance" "vm2" {
  name         = "vm2"
  machine_type = "n2-standard-4"
  zone         = "us-central1-b"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network    = "default"
    nic_type   = "VIRTIO_NET"
  }

  network_interface {
    network    = "t-rex-1"
    nic_type   = "VIRTIO_NET"
  }

  metadata = {
    ssh-keys = "<your_ssh_public_key>"
  }
}

resource "google_compute_instance" "vm3" {
  name         = "vm3"
  machine_type = "n2-standard-4"
  zone         = "us-central1-c"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network    = "default"
    nic_type   = "VIRTIO_NET"
  }

  network_interface {
    network    = "t-rex-1"
    nic_type   = "VIRTIO_NET"
  }

  metadata = {
    ssh-keys = "<your_ssh_public_key>"
  }
}
