resource "proxmox_virtual_environment_download_file" "ubuntu_cloud_image" {
  content_type         = "iso"
  datastore_id         = var.datastore_iso
  node_name            = var.node_name
  url                  = var.image_url
  file_name            = var.file_name
  overwrite_unmanaged  = true
}
